-- Cambiar al esquema krankenhaus_schema
SET search_path TO krankenhaus_schema;

-- Crear la vista getAllWorkers
CREATE VIEW getAllWorkers AS
SELECT nom, cognom
FROM persona
NATURAL JOIN treballador;

-- Crear la vista getAllPacients
CREATE VIEW getAllPacients AS
SELECT nom, cognom
FROM persona
NATURAL JOIN pacient;

-- Crear la vista getSinEdad
CREATE VIEW getSinEdad AS
SELECT nom, cognom
FROM persona
WHERE datanaixement IS NULL;

-- Crear la vista getMENORES
CREATE VIEW getMENORES AS
SELECT nom, cognom
FROM persona
WHERE datanaixement BETWEEN '2005-05-18' AND NOW();

-- Crear la vista getCapacidadHospital
CREATE VIEW getCapacidadHospital AS
SELECT idhospital, nomhospital
FROM hospital
WHERE numllitsucilliures > 500;

-- Crear la vista getAllHospitals
CREATE VIEW getAllHospitals AS
SELECT nomciutat
FROM ciutat
NATURAL RIGHT JOIN hospital;

-- Crear la vista getFuturosHospitales
CREATE VIEW getFuturosHospitales AS
SELECT nomciutat
FROM ciutat
WHERE idciutat NOT IN (SELECT idciutat FROM hospital);

-- Crear la vista getEnfermeros
CREATE VIEW getEnfermeros AS
SELECT nom, cognom
FROM persona
NATURAL JOIN treballador
NATURAL JOIN enfermer;

-- Crear la vista getAdministratius
CREATE VIEW getAdministratius AS
SELECT nom, cognom
FROM persona
NATURAL JOIN treballador
NATURAL JOIN administratiu;

-- Crear la vista getDoctores
CREATE VIEW getDoctores AS
SELECT nom, cognom
FROM persona
NATURAL JOIN treballador
NATURAL JOIN doctor;

-- Crear la vista getStockHospital1
CREATE VIEW getStockHospital1 AS
SELECT SUM(qty)
FROM stock
WHERE idhospital = '1';

-- Crear la vista getStockHospital2
CREATE VIEW getStockHospital2 AS
SELECT SUM(qty)
FROM stock
WHERE idhospital = '2';

-- Crear la vista getStockHospital0
CREATE VIEW getStockHospital0 AS
SELECT SUM(qty)
FROM stock
WHERE idhospital = '0';

-- Crear la vista getVirus
CREATE VIEW getVirus AS
SELECT nomvirus
FROM virus
WHERE numvariant > 100000;

-- Crea la vista getAllPacientsInfo
CREATE VIEW getAllPacientsInfo AS
SELECT nom, cognom, estat, nomhospital, nomciutat, planta, habitacio, ocupauci
FROM persona natural join pacient natural join hospital natural join ciutat;
