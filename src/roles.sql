CREATE ROLE pacient;
GRANT SELECT ON pacient, cartillavacunes, hospital, vacuna TO pacient;
GRANT CONNECT ON DATABASE krankenhaus TO pacient;
GRANT USAGE ON SCHEMA krankenhaus_schema TO pacient;
REVOKE EXECUTE ON FUNCTION ingresaPacient TO pacient;
REVOKE EXECUTE ON FUNCTION actualizaEstadoPaciente TO pacient;
REVOKE EXECUTE ON FUNCTION ficaStock TO pacient;
REVOKE EXECUTE ON FUNCTION posaDosis1 TO pacient;
REVOKE EXECUTE ON FUNCTION avisaPocStock TO pacient;
REVOKE EXECUTE ON FUNCTION LlistaPacientsCartilla TO pacient;

CREATE ROLE doctor;
GRANT SELECT, UPDATE ON pacient, cartillavacunes TO doctor;
GRANT SELECT ON stock, enfermer TO doctor;
GRANT CONNECT ON DATABASE krankenhaus TO doctor;
GRANT USAGE ON SCHEMA krankenhaus_schema TO doctor;
GRANT EXECUTE ON FUNCTION ingresaPacient TO doctor;
GRANT EXECUTE ON FUNCTION actualizaEstadoPaciente TO doctor;
REVOKE EXECUTE ON FUNCTION ficaStock TO doctor;
GRANT EXECUTE ON FUNCTION posaDosis1 TO doctor;
GRANT EXECUTE ON FUNCTION avisaPocStock TO doctor;
REVOKE EXECUTE ON FUNCTION LlistaPacientsCartilla TO doctor;

CREATE ROLE enfermer;
GRANT SELECT ON pacient, cartillavacunes, doctor, stock TO enfermer;
GRANT CONNECT ON DATABASE krankenhaus TO enfermer;
GRANT USAGE ON SCHEMA krankenhaus_schema TO enfermer;
REVOKE EXECUTE ON FUNCTION ingresaPacient TO enfermer;
GRANT EXECUTE ON FUNCTION actualizaEstadoPaciente TO enfermer;
REVOKE EXECUTE ON FUNCTION ficaStock TO enfermer;
GRANT EXECUTE ON FUNCTION posaDosis1 TO enfermer;
GRANT EXECUTE ON FUNCTION avisaPocStock TO enfermer;
REVOKE EXECUTE ON FUNCTION LlistaPacientsCartilla TO enfermer;

CREATE ROLE administratiu;
GRANT SELECT, UPDATE, INSERT, DELETE ON pacient, cartillavacunes, doctor, enfermer, stock, persona, treballador TO administratiu;
GRANT SELECT ON hospital, vacuna, virus TO administratiu;
GRANT CONNECT ON DATABASE krankenhaus TO administratiu;
GRANT USAGE ON SCHEMA krankenhaus_schema TO administratiu;
GRANT EXECUTE ON FUNCTION ingresaPacient TO administratiu;
GRANT EXECUTE ON FUNCTION actualizaEstadoPaciente TO administratiu;
GRANT EXECUTE ON FUNCTION ficaStock TO administratiu;
GRANT EXECUTE ON FUNCTION posaDosis1 TO administratiu;
GRANT EXECUTE ON FUNCTION avisaPocStock TO administratiu;
GRANT EXECUTE ON FUNCTION LlistaPacientsCartilla TO administratiu;

CREATE ROLE admin;
GRANT ALL PRIVILEGES ON DATABASE krankenhaus TO admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT CONNECT ON DATABASE krankenhaus TO admin;
GRANT USAGE ON SCHEMA krankenhaus_schema TO admin;
GRANT EXECUTE ON FUNCTION ingresaPacient TO admin;
GRANT EXECUTE ON FUNCTION actualizaEstadoPaciente TO admin;
GRANT EXECUTE ON FUNCTION ficaStock TO admin;
GRANT EXECUTE ON FUNCTION posaDosis1 TO admin;
GRANT EXECUTE ON FUNCTION avisaPocStock TO admin;
GRANT EXECUTE ON FUNCTION LlistaPacientsCartilla TO admin;

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