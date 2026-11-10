-- ─────────────────────────────────────────────────────────────
--  GimNova · esquema de la base de dades (SQLite)
--  Model relacional: socis, classes i reserves.
--  Una reserva enllaça UN soci amb UNA classe (relació N:M).
--
--  Com s'usa (vegeu BASE_DADES.pdf):
--   · Obre DB Browser for SQLite → New Database → anomena-la gimnova.db
--   · Pestanya "Execute SQL" → enganxa TOT aquest fitxer → Run (▶)
--   · "Write Changes" → ja tens gimnova.db per pujar a PythonAnywhere
-- ─────────────────────────────────────────────────────────────

PRAGMA foreign_keys = ON;

-- Esborra les taules si ja existien (per poder refer l'esquema net)
DROP TABLE IF EXISTS reserves;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS socis;

-- Taula de socis del gimnàs
CREATE TABLE socis (
    id    INTEGER PRIMARY KEY AUTOINCREMENT,
    nom   TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);

-- Taula de classes (amb el nombre de places totals)
CREATE TABLE classes (
    id     INTEGER PRIMARY KEY AUTOINCREMENT,
    nom    TEXT NOT NULL,
    hora   TEXT NOT NULL,
    places INTEGER NOT NULL DEFAULT 0
);

-- Taula de reserves: relaciona un soci amb una classe (claus foranes)
CREATE TABLE reserves (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    soci_id   INTEGER NOT NULL REFERENCES socis(id),
    classe_id INTEGER NOT NULL REFERENCES classes(id),
    data      TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Dades d'exemple ----------------------------------------------
INSERT INTO socis (nom, email) VALUES
    ('Alex Vidal',  'alex@example.com'),
    ('Mar Puig',    'mar@example.com'),
    ('Joan Serra',  'joan@example.com');

INSERT INTO classes (nom, hora, places) VALUES
    ('Body Pump', '18:00', 8),
    ('Ioga',      '18:30', 4),
    ('Spinning',  '19:00', 6);

-- Tres reserves d'exemple (Body Pump ja té 1 plaça ocupada, Ioga 2)
INSERT INTO reserves (soci_id, classe_id) VALUES
    (1, 1),
    (1, 2),
    (2, 2);
