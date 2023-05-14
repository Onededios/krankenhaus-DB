CREATE VIEW getAllWorkers AS
select nom, cognom from persona natural join treballador;

CREATE VIEW getAllPacients AS
