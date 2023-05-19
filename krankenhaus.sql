\c postgres
DROP DATABASE krankenhaus;
CREATE DATABASE krankenhaus;
\c krankenhaus
CREATE SCHEMA krankenhaus_schema;
SET search_path TO krankenhaus_schema;
\i 'src/tables.sql'
\i 'src/inserts.sql'
\i 'src/roles.sql'
\i 'src/views.sql'
\i 'src/functions.sql'