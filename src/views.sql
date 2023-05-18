CREATE VIEW getAllWorkers AS
SELECT nom, cognom FROM persona
NATURAL JOIN treballador;