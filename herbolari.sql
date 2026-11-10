CREATE TABLE ingredients (
    nom_comu VARCHAR(100) PRIMARY KEY,
    nom_cientific VARCHAR(150),
    descripcio_planta TEXT,
    fotografia_flor BLOB,
    fotografia_planta BLOB,
    ilustracio_planta VARCHAR(255)
);

CREATE TABLE pocions (
    id_NOM INT PRIMARY KEY,
    descripcio_defectes TEXT
);

CREATE TABLE ingredient_pocio (
    id_NOM_COMU VARCHAR(100),
    id_NOM INT,
    quantitat_grams DECIMAL(10,2),

    PRIMARY KEY (id_NOM_COMU, id_NOM),

    FOREIGN KEY (id_NOM_COMU)
        REFERENCES ingredients(nom_comu),

    FOREIGN KEY (id_NOM)
        REFERENCES pocions(id_NOM)
);


INSERT INTO ingredients (nom_comu, descripcio_planta)
VALUES (
    'Menta',
    'És una planta usada comunament com a aromatitzant i ocasionalment com a ingredient de pocions, amb tija i fulles de color verd.'
);



INSERT INTO ingredients (nom_comu, descripcio_planta)
VALUES (
    'Espígol',
    'És una flor que destaca pel seu "color bonic" i "fragància relaxant". Es pot utilitzar com a ingredient en una varietat de pocions.'
);



INSERT INTO ingredients (nom_comu, descripcio_planta)
VALUES (
    'Mandràgora',
    'És una planta màgica i sensible que té una arrel que s''assembla a un ésser humà (com un nadó quan la planta és jove, però madura a mesura que la planta creix). Quan madura, el seu crit pot ser fatal per a qualsevol persona que l''escolti.'
);



INSERT INTO ingredients (nom_comu, descripcio_planta)
VALUES (
    'Acònit',
    'Aquesta planta ara només es troba en llocs silvestres. Les seves flors són útils per fer pocions, però les seves fulles són molt tòxiques. La seva arrel es pot utilitzar com a ingredient de pocions.'
);



INSERT INTO ingredients (nom_comu, descripcio_planta)
VALUES (
    'Bitxo',
    'És de forma prima i allargada. Presenta un alt contingut en capsaïcina i per aquest motiu és intensament coent o picant. S''utilitza com a condiment culinari de molts plats i salses.'
);



INSERT INTO ingredients (nom_comu, descripcio_planta)
VALUES (
    'Valeriana',
    'Era coneguda en temps medievals com "Sana Tot", reconeguda per les seves propietats sedants i antiespasmòdiques, i per tant era usada com a remei per dormir i calmar els nervis i més tard per al tractament de l''epilèpsia.'
);


UPDATE ingredients
SET
    fotografia_flor = LOAD_FILE('C:/xampp/htdocs/xampp/fotos/menta_flor.jpg'),
    fotografia_planta = LOAD_FILE('C:/xampp/htdocs/xampp/fotos/menta_planta.jpg')
WHERE nom_comu = 'Menta';


UPDATE ingredients
SET
    fotografia_flor = LOAD_FILE('C:/xampp/htdocs/xampp/fotos/valeriana_flor.jpg'),
    fotografia_planta = LOAD_FILE('C:/xampp/htdocs/xampp/fotos/valeriana_planta.jpg')
WHERE nom_comu = 'Valeriana';



UPDATE ingredients
SET
    fotografia_flor = LOAD_FILE('C:/xampp/htdocs/xampp/fotos/espigol_flor.jpg'),
    fotografia_planta = LOAD_FILE('C:/xampp/htdocs/xampp/fotos/espigol_planta.jpg')
WHERE nom_comu = 'Espígol';



UPDATE ingredients
SET
    fotografia_flor = LOAD_FILE('C:/xampp/htdocs/xampp/fotos/mandragora_flor.jpg'),
    fotografia_planta = LOAD_FILE('C:/xampp/htdocs/xampp/fotos/mandragora_planta.jpg')
WHERE nom_comu = 'Mandràgora';



UPDATE ingredients
SET
    fotografia_flor = LOAD_FILE('C:/xampp/htdocs/xampp/fotos/aconit_flor.jpg'),
    fotografia_planta = LOAD_FILE('C:/xampp/htdocs/xampp/fotos/aconit_planta.jpg')
WHERE nom_comu = 'Acònit';



UPDATE ingredients
SET
    fotografia_flor = LOAD_FILE('C:/xampp/htdocs/xampp/fotos/bitxo_flor.jpg'),
    fotografia_planta = LOAD_FILE('C:/xampp/htdocs/xampp/fotos/bitxo_planta.jpg')
WHERE nom_comu = 'Bitxo';



INSERT INTO pocions (id_NOM, nom)
VALUES
    (1, 'Alè de foc'),
    (2, 'Pòcima per dormir'),
    (3, 'Antídot per verins comuns');



UPDATE pocions
SET descripcio_defectes = 'És una poció perillosa que pot fer que una persona exhali foc.'
WHERE nom = 'Alè de foc';



UPDATE pocions
SET descripcio_defectes = 'També coneguda com a poció somnífera o poció adormidora, és una poció que causa al bevedor, gairebé instantàniament, un son profund però temporal.'
WHERE nom = 'Pòcima per dormir';


UPDATE pocions
SET descripcio_defectes = 'És una poció i antídot que contraresta verins ordinaris, com els de mossegades i picades de criatures.'
WHERE nom = 'Antídot per verins comuns';

UPDATE pocions
SET descripcio_defectes = 'També coneguda com a poció somnífera o poció adormidora, és una poció que causa al bevedor, gairebé instantàniament, un son profund però temporal.'
WHERE nom = 'Pòcima per dormir';

 UPDATE pocions
SET descripcio_defectes = 'És una poció i antídot que contraresta verins ordinaris, com els de mossegades i picades de criatures.'
WHERE nom = 'Antídot per verins comuns';