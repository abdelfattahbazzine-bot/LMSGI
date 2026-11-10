"""
GimNova · aplicació web de reserves (versió amb base de dades relacional)
-------------------------------------------------------------------------
App Flask per publicar a PythonAnywhere (gratis, sense targeta).

Model de dades (3 taules relacionades):
  · socis     (id, nom, email)
  · classes   (id, nom, hora, places)
  · reserves  (id, soci_id -> socis, classe_id -> classes, data)

La base de dades és un fitxer SQLite (gimnova.db). El creeu vosaltres a
partir de esquema.sql amb DB Browser for SQLite i el pugeu (BASE_DADES.pdf).
Si el fitxer no hi és, l'app el crea i hi posa dades d'exemple perquè mai
quedi en blanc.

L'app fa servir SQLAlchemy (ORM): les consultes són PARAMETRITZADES, cosa
que la protegeix de la injecció SQL (ho comprovareu al pentest).
"""

import os
from datetime import datetime
from flask import Flask, render_template, request, redirect, url_for, flash, jsonify, abort
from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, func
from sqlalchemy.orm import declarative_base, sessionmaker, relationship

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DB_PATH = os.path.join(BASE_DIR, "gimnova.db")
DATABASE_URL = os.environ.get("DATABASE_URL", "sqlite:///" + DB_PATH)

engine = create_engine(DATABASE_URL, future=True, pool_pre_ping=True)
SessionLocal = sessionmaker(bind=engine, future=True)
Base = declarative_base()


# ---------- Model (coincideix amb esquema.sql) ----------
class Soci(Base):
    __tablename__ = "socis"
    id = Column(Integer, primary_key=True)
    nom = Column(String(80), nullable=False)
    email = Column(String(120), nullable=False, unique=True)
    reserves = relationship("Reserva", back_populates="soci")


class Classe(Base):
    __tablename__ = "classes"
    id = Column(Integer, primary_key=True)
    nom = Column(String(80), nullable=False)
    hora = Column(String(20), nullable=False)
    places = Column(Integer, nullable=False, default=0)
    reserves = relationship("Reserva", back_populates="classe")


class Reserva(Base):
    __tablename__ = "reserves"
    id = Column(Integer, primary_key=True)
    soci_id = Column(Integer, ForeignKey("socis.id"), nullable=False)
    classe_id = Column(Integer, ForeignKey("classes.id"), nullable=False)
    # La data es posa automàticament en crear la reserva (format AAAA-MM-DD HH:MM:SS).
    data = Column(String(40), default=lambda: datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
    soci = relationship("Soci", back_populates="reserves")
    classe = relationship("Classe", back_populates="reserves")


def init_db():
    """Crea les taules i dades d'exemple NOMÉS si la base encara no existeix."""
    Base.metadata.create_all(engine)
    s = SessionLocal()
    try:
        if s.query(Classe).count() == 0:
            socis = [Soci(nom="Alex Vidal", email="alex@example.com"),
                     Soci(nom="Mar Puig", email="mar@example.com"),
                     Soci(nom="Joan Serra", email="joan@example.com")]
            classes = [Classe(nom="Body Pump", hora="18:00", places=8),
                       Classe(nom="Ioga", hora="18:30", places=4),
                       Classe(nom="Spinning", hora="19:00", places=6)]
            s.add_all(socis + classes)
            s.commit()
            s.add_all([Reserva(soci_id=1, classe_id=1),
                       Reserva(soci_id=1, classe_id=2),
                       Reserva(soci_id=2, classe_id=2)])
            s.commit()
    finally:
        s.close()


app = Flask(__name__)
app.secret_key = os.environ.get("SECRET_KEY", "canvia-aquesta-clau")


def places_lliures(s, classe):
    """Places totals menys les reserves fetes (demostra un COUNT amb relació)."""
    ocupades = s.query(func.count(Reserva.id)).filter(Reserva.classe_id == classe.id).scalar()
    return classe.places - ocupades


# ---------- Rutes ----------
@app.get("/salut")
def salut():
    return jsonify(estat="ok")


@app.get("/")
def index():
    s = SessionLocal()
    try:
        classes = s.query(Classe).order_by(Classe.hora).all()
        socis = s.query(Soci).order_by(Soci.nom).all()
        dades = [{"c": c, "lliures": places_lliures(s, c)} for c in classes]
        return render_template("index.html", dades=dades, socis=socis)
    finally:
        s.close()


@app.post("/reservar")
def reservar():
    """Crea una reserva a partir del formulari (soci + classe), amb validació."""
    s = SessionLocal()
    try:
        # Validació d'entrada: han de ser nombres i han d'existir
        try:
            soci_id = int(request.form.get("soci_id", ""))
            classe_id = int(request.form.get("classe_id", ""))
        except ValueError:
            flash("Dades no vàlides.", "error")
            return redirect(url_for("index"))

        soci = s.get(Soci, soci_id)
        classe = s.get(Classe, classe_id)
        if not soci or not classe:
            flash("El soci o la classe no existeixen.", "error")
            return redirect(url_for("index"))

        if places_lliures(s, classe) <= 0:
            flash("La classe %s ja és plena." % classe.nom, "error")
            return redirect(url_for("index"))

        s.add(Reserva(soci_id=soci.id, classe_id=classe.id))
        s.commit()
        flash("Reserva feta per a %s a %s." % (soci.nom, classe.nom), "ok")
        return redirect(url_for("index"))
    finally:
        s.close()


@app.get("/socis")
def socis():
    s = SessionLocal()
    try:
        llista = s.query(Soci).order_by(Soci.nom).all()
        # Per a cada soci, les seves reserves (demostra la relació)
        dades = []
        for soci in llista:
            reserves = [r.classe.nom for r in soci.reserves]
            dades.append({"soci": soci, "reserves": reserves})
        return render_template("socis.html", dades=dades)
    finally:
        s.close()


@app.get("/api/reserves")
def api_reserves():
    """API JSON: reserves amb el nom del soci i de la classe (JOIN via relació)."""
    s = SessionLocal()
    try:
        reserves = s.query(Reserva).all()
        data = [{"id": r.id, "soci": r.soci.nom, "classe": r.classe.nom, "data": r.data}
                for r in reserves]
        return jsonify(reserves=data)
    finally:
        s.close()


init_db()


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)
