\c postgres
DROP DATABASE krankenhaus;
CREATE DATABASE krankenhaus;
\c krankenhaus
\i 'src/roles.sql'
\i 'src/tables.sql'
\i 'src/inserts.sql'
\i 'src/views.sql'
\i 'src/functions.sql'