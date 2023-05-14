CREATE ROLE pacient;
GRANT SELECT ON pacient, cartillavacunes, hospital, vacuna TO pacient;

CREATE ROLE doctor;
GRANT SELECT, UPDATE ON pacient, cartillavacunes TO doctor;
GRANT SELECT ON stock, enfermer TO doctor;

CREATE ROLE enfermer;
GRANT SELECT ON pacient, cartillavacunes, doctor, stock TO enfermer;

CREATE ROLE administratiu;
GRANT SELECT, UPDATE, INSERT, DELETE ON pacient, cartillavacunes, doctor, enfermer, stock, persona, treballador TO administratiu;
GRANT SELECT ON hospital, vacuna, virus TO administratiu;

CREATE ROLE admin;
GRANT ALL PRIVILEGES ON DATABASE krankenhaus TO admin;

CREATE USER jrodriguez WITH ENCRYPTED PASSWORD 'passwd' IN ROLE admin;
CREATE USER mmartinez WITH ENCRYPTED PASSWORD 'passwd' IN ROLE administratiu;
CREATE USER rlopez WITH ENCRYPTED PASSWORD 'passwd' IN ROLE administratiu;
CREATE USER fgonzalez WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER jgarcia WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER acastro WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER nfernandez WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER jortega WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER asanchez WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER mmoreno WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER eaguilar WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER jhernandez WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER lcortes WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER gmunoz WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER mlopez1 WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER jmartin WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER vcastillo WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER mmolina WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER pfernandez1 WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;
CREATE USER hruiz WITH ENCRYPTED PASSWORD 'passwd' IN ROLE ;