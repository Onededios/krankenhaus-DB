CREATE ROLE pacient;
GRANT SELECT ON pacient, cartillavacunes, hospital, vacuna TO pacient;
GRANT CONNECT ON DATABASE krankenhaus TO pacient;

CREATE ROLE doctor;
GRANT SELECT, UPDATE ON pacient, cartillavacunes TO doctor;
GRANT SELECT ON stock, enfermer TO doctor;
GRANT CONNECT ON DATABASE krankenhaus TO doctor;

CREATE ROLE enfermer;
GRANT SELECT ON pacient, cartillavacunes, doctor, stock TO enfermer;
GRANT CONNECT ON DATABASE krankenhaus TO enfermer;

CREATE ROLE administratiu;
GRANT SELECT, UPDATE, INSERT, DELETE ON pacient, cartillavacunes, doctor, enfermer, stock, persona, treballador TO administratiu;
GRANT SELECT ON hospital, vacuna, virus TO administratiu;
GRANT CONNECT ON DATABASE krankenhaus TO administratiu;

CREATE ROLE admin;
GRANT ALL PRIVILEGES ON DATABASE krankenhaus TO admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT CONNECT ON DATABASE krankenhaus TO admin;

CREATE USER jrodriguez WITH ENCRYPTED PASSWORD 'passwd' IN ROLE admin;

CREATE USER mhaynes WITH ENCRYPTED PASSWORD 'passwd' IN ROLE administratiu;
CREATE USER rgarrett WITH ENCRYPTED PASSWORD 'passwd' IN ROLE administratiu;

CREATE USER jrodgers WITH ENCRYPTED PASSWORD 'passwd' IN ROLE doctor;
CREATE USER dmoreno WITH ENCRYPTED PASSWORD 'passwd' IN ROLE doctor;
CREATE USER hellison WITH ENCRYPTED PASSWORD 'passwd' IN ROLE doctor;

CREATE USER lryan WITH ENCRYPTED PASSWORD 'passwd' IN ROLE enfermer;
CREATE USER smatthews WITH ENCRYPTED PASSWORD 'passwd' IN ROLE enfermer;
CREATE USER bnewman WITH ENCRYPTED PASSWORD 'passwd' IN ROLE enfermer;
CREATE USER sgeorge WITH ENCRYPTED PASSWORD 'passwd' IN ROLE enfermer;
CREATE USER ahoffman WITH ENCRYPTED PASSWORD 'passwd' IN ROLE enfermer;

CREATE USER lcisneros WITH ENCRYPTED PASSWORD 'passwd' IN ROLE pacient;
CREATE USER cblackburn WITH ENCRYPTED PASSWORD 'passwd' IN ROLE pacient;
CREATE USER lbyrd WITH ENCRYPTED PASSWORD 'passwd' IN ROLE pacient;
CREATE USER cmiles WITH ENCRYPTED PASSWORD 'passwd' IN ROLE pacient;
CREATE USER aingram WITH ENCRYPTED PASSWORD 'passwd' IN ROLE pacient;
CREATE USER bneal WITH ENCRYPTED PASSWORD 'passwd' IN ROLE pacient;
CREATE USER hwhite WITH ENCRYPTED PASSWORD 'passwd' IN ROLE pacient;
CREATE USER hdaniels WITH ENCRYPTED PASSWORD 'passwd' IN ROLE pacient;
CREATE USER vbarrera WITH ENCRYPTED PASSWORD 'passwd' IN ROLE pacient;
CREATE USER mmiddleton WITH ENCRYPTED PASSWORD 'passwd' IN ROLE pacient;