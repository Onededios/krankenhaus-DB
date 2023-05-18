CREATE VIEW getAllWorkers AS
select nom, cognom from persona natural join treballador;

CREATE VIEW getAllPacients AS
SELECT nom, cognom from persona natural join pacient;

CREATE VIEW getSinEdad AS
SELECT nom, cognom from persona
Where datanaixement IS NULL;

CREATE VIEW getMENORES AS
SELECT nom, cognom from persona
where datanaixement BETWEEN '2005-05-18' and now();

CREATE VIEW getCapacidadHospital AS
SELECT idhospital, nomhospital
FROM hospitales
WHERE numllitsucilliures>500;

CREATE VIEW getAllHospitals AS
select nomciutat from ciutat natural right join hospital;

CREATE VIEW getFuturosHospitales AS
SELECT nomciutat
FROM ciutat
WHERE idciutat NOT IN (SELECT idciutat FROM hospital);

CREATE VIEW getEnfermeros AS
select nom, cognom from persona natural join treballador natural join enfermer;

CREATE VIEW getAdministratius AS
select nom, cognom from persona natural join treballador natural join administatiu;

CREATE VIEW getDoctores AS
select nom, cognom from persona natural join treballador natural join doctor;
(\df + nombre funcion)

CREATE VIEW getStockHospital1 AS
select SUM(qty) from stock where idhospital='1';

CREATE VIEW getStockHospital2 AS
select SUM(qty) from stock where idhospital='2';

CREATE VIEW getStockHospital0 AS
select SUM(qty) from stock where idhospital='0';

CREATE VIEW getVirus AS
SELECT nomvirus FROM virus
where numvariant>100000;



