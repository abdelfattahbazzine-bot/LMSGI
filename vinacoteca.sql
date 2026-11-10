
USE vinacoteca;

-- 3. Tabla varietats_de_raims
CREATE TABLE IF NOT EXISTS varietats_de_raims (
    id_raim INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50)
);

-- 4. Tabla do
CREATE TABLE IF NOT EXISTS do (
    id_do INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(30),
    descripció TEXT,
    hectarees INT UNSIGNED,
    numero_viticultors INT UNSIGNED
);

-- 5. Tabla bodegues
CREATE TABLE IF NOT EXISTS bodegues (
    id_bodega INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_do INT UNSIGNED,
    nom VARCHAR(30),
    descripció TEXT,
    any_fundació YEAR,
    producció_anual INT UNSIGNED,
    adreca VARCHAR(100),
    telefon CHAR(9),
    lloc_web VARCHAR(50),
    CONSTRAINT FK_bodegues_do
        FOREIGN KEY (id_do)
        REFERENCES denominacions(id_do)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- 6. Tabla vins
CREATE TABLE IF NOT EXISTS vins (
    id_vi INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_raim INT UNSIGNED,
    id_bodega INT UNSIGNED,
    nom VARCHAR(25),
    descripció TEXT,
    any_collita YEAR,
    tipus ENUM('blanc', 'negre', 'rosat', 'escumos'),
    preu_unitat DOUBLE,
    CONSTRAINT FK_vins_raim_varietatprincipal
        FOREIGN KEY (id_raim)
        REFERENCES varietats_de_raims(id_raim)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_vins_bodegues
        FOREIGN KEY (id_bodega)
        REFERENCES bodegues(id_bodega)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- 7. Tabla vi_raims
CREATE TABLE IF NOT EXISTS vi_raims (
    id_vi INT UNSIGNED,
    id_raim INT UNSIGNED,
    PRIMARY KEY (id_vi, id_raim),
    CONSTRAINT FK_vi_raims_raim
        FOREIGN KEY (id_raim)
        REFERENCES varietats_de_raims(id_raim)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_vi_raims_vi
        FOREIGN KEY (id_vi)
        REFERENCES vins(id_vi)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

1-
-- Inserim les 'do' d'origen amb un sol INSERT
INSERT INTO `do` (`nom`, `descripció`, `hectàrees`, `viticultors`)
VALUES
('Pla de Bages', 'DO de la Catalunya central, terra de tines de pedra i del picapoll.', 550, 90),
('Tarragona', 'DO costanera al voltant del Camp de Tarragona.', 4500, 1200);

2-
-- Inserim les cinc varietats de raïm amb un sol INSERT
INSERT INTO varietats_de_raims (nom)
VALUES
('Picapoll blanc'),
('Picapoll negre'),
('Mandó'),
('Malvasia'),
('Garnatxa roja');

3A-
-- Consultem l'ID de la DO Pla de Bages
SELECT id
FROM `do`
WHERE nom = 'Pla de Bages';

-- Inserim Celler Les Tines amb l'ID 3 de Pla de Bages
INSERT INTO bodegues
(nom, descripció, any_fundació, producció_anual, adreça, telèfon, web, do_id)
VALUES
('Celler Les Tines', 'Celler que recupera les antigues tines de pedra.', 2008, 35000, 'Camí de les Tines s/n, Artés', '938000201', 'www.lestines.cat', 3);

3B-
-- Inserim les dues bodegues obtenint el do_id amb una subconsulta
INSERT INTO bodegues
(nom, descripció, any_fundació, producció_anual, adreça, telèfon, web, do_id)
VALUES
('Celler Vinya del Bages', 'Cooperativa de petits viticultors del Bages.', 1964, 150000, 'Carrer de la Vinya 8, Navarcles', '938000202', 'www.vinyadelbages.cat',
    (SELECT id_do FROM `do` WHERE nom = 'Pla de Bages')),
('Celler Mas del Camp', 'Masia vitícola a tocar del mar.', 1976, 220000, 'Mas del Camp, el Morell', '977000203', 'www.masdelcamp.cat',
    (SELECT id_do FROM `do` WHERE nom = 'Tarragona'));

3C-
-- La subconsulta permet obtenir automàticament l'ID de la DO sense haver de consultar-lo manualment. Així, no depenem de conèixer el número de l'ID i evitem possibles errors.


-- Inserim els cinc vins amb un sol INSERT i subconsultes
INSERT INTO vins
(nom, descripció, any_collita, tipus, preu_unitat, id_bodega, id_raim)
VALUES
('Tines Picapoll', 'Blanc fresc fermentat en tina de pedra.', 2023, 'blanc', 12.90,
    (SELECT id_bodega FROM bodegues WHERE nom = 'Celler Les Tines'),
    (SELECT id_raim FROM varietats_de_raims WHERE nom = 'Picapoll blanc')),

('Tines Mandó', 'Negre lleuger i especiat.', 2021, 'negre', 16.50,
    (SELECT id_bodega FROM bodegues WHERE nom = 'Celler Les Tines'),
    (SELECT id_raim FROM varietats_de_raims WHERE nom = 'Mandó')),

('Bages Rosat', 'Rosat de picapoll negre.', 2023, 'rosat', 9.80,
    (SELECT id_bodega FROM bodegues WHERE nom = 'Celler Vinya del Bages'),
    (SELECT id_raim FROM varietats_de_raims WHERE nom = 'Picapoll negre')),

('Mas del Camp Blanc', 'Blanc mediterrani amb notes florals.', 2022, 'blanc', 8.75,
    (SELECT id_bodega FROM bodegues WHERE nom = 'Celler Mas del Camp'),
    (SELECT id_raim FROM varietats_de_raims WHERE nom = 'Malvasia')),

('Mas del Camp Brut', 'Escumós sec de criança curta.', 2021, 'escumos', 13.40,
    (SELECT id_bodega FROM bodegues WHERE nom = 'Celler Mas del Camp'),
    (SELECT id_raim FROM varietats_de_raims WHERE nom = 'Garnatxa roja'));

    5-
    -- Tines Picapoll: Picapoll blanc
INSERT INTO vi_raims (id_vi, id_raim)
VALUES (
    (SELECT id_vi FROM vins WHERE nom = 'Tines Picapoll'),
    (SELECT id_raim FROM varietats_de_raims WHERE nom = 'Picapoll blanc')
);

-- Tines Mandó: Mandó
INSERT INTO vi_raims (id_vi, id_raim)
VALUES (
    (SELECT id_vi FROM vins WHERE nom = 'Tines Mandó'),
    (SELECT id_raim FROM varietats_de_raims WHERE nom = 'Mandó')
);

-- Tines Mandó: Picapoll negre
INSERT INTO vi_raims (id_vi, id_raim)
VALUES (
    (SELECT id_vi FROM vins WHERE nom = 'Tines Mandó'),
    (SELECT id_raim FROM varietats_de_raims WHERE nom = 'Picapoll negre')
);

-- Bages Rosat: Picapoll negre
INSERT INTO vi_raims (id_vi, id_raim)
VALUES (
    (SELECT id_vi FROM vins WHERE nom = 'Bages Rosat'),
    (SELECT id_raim FROM varietats_de_raims WHERE nom = 'Picapoll negre')
);

-- Mas del Camp Blanc: Malvasia
INSERT INTO vi_raims (id_vi, id_raim)
VALUES (
    (SELECT id_vi FROM vins WHERE nom = 'Mas del Camp Blanc'),
    (SELECT id_raim FROM varietats_de_raims WHERE nom = 'Malvasia')
);

-- Mas del Camp Blanc: Garnatxa roja
INSERT INTO vi_raims (id_vi, id_raim)
VALUES (
    (SELECT id_vi FROM vins WHERE nom = 'Mas del Camp Blanc'),
    (SELECT id_raim FROM varietats_de_raims WHERE nom = 'Garnatxa roja')
);

-- Mas del Camp Brut: Garnatxa roja
INSERT INTO vi_raims (id_vi, id_raim)
VALUES (
    (SELECT id_vi FROM vins WHERE nom = 'Mas del Camp Brut'),
    (SELECT id_raim FROM varietats_de_raims WHERE nom = 'Garnatxa roja')
);

-- Mas del Camp Brut: Malvasia
INSERT INTO vi_raims (id_vi, id_raim)
VALUES (
    (SELECT id_vi FROM vins WHERE nom = 'Mas del Camp Brut'),
    (SELECT id_raim FROM varietats_de_raims WHERE nom = 'Malvasia')
);
);