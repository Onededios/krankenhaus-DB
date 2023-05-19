-- Crear tabla ciutat
CREATE TABLE krankenhaus_schema.ciutat (
    idciutat SERIAL PRIMARY KEY,
    nomciutat TEXT,
    CONSTRAINT unq_ciutat_nomciutat UNIQUE (nomciutat)
);

-- Crear tabla hospital
CREATE TABLE krankenhaus_schema.hospital (
    idhospital SERIAL PRIMARY KEY,
    nomhospital TEXT NOT NULL,
    numllitsucilliures BIGINT,
    idciutat BIGINT,
    CONSTRAINT unq_hospital_nomhospital UNIQUE (nomhospital),
    CONSTRAINT fk_hospital_ciutat FOREIGN KEY (idciutat) REFERENCES krankenhaus_schema.ciutat (idciutat) ON DELETE CASCADE
);

-- Crear tabla persona
CREATE TABLE krankenhaus_schema.persona (
    idpersona SERIAL PRIMARY KEY,
    idhospital BIGINT NOT NULL,
    nom TEXT NOT NULL,
    cognom TEXT NOT NULL,
    datanaixement DATE,
    CONSTRAINT fk_persona_hospital FOREIGN KEY (idhospital) REFERENCES krankenhaus_schema.hospital (idhospital) ON DELETE CASCADE
);

-- Crear tabla pacient
CREATE TABLE krankenhaus_schema.pacient (
    idpacient SERIAL PRIMARY KEY,
    idpersona BIGINT NOT NULL,
    planta TEXT,
    habitacio TEXT,
    ocupauci BOOLEAN,
    estat TEXT,
    CONSTRAINT unq_pacient_idpersona UNIQUE (idpersona),
    CONSTRAINT fk_pacient_persona FOREIGN KEY (idpersona) REFERENCES krankenhaus_schema.persona (idpersona) ON DELETE CASCADE
);

-- Crear tabla vacuna
CREATE TABLE krankenhaus_schema.vacuna (
    idvacuna SERIAL PRIMARY KEY,
    nomvacuna TEXT NOT NULL,
    laboratori TEXT,
    numdosis DECIMAL NOT NULL,
    CONSTRAINT unq_vacuna_nomvacuna UNIQUE (nomvacuna)
);

-- Crear tabla cartillavacunes
CREATE TABLE krankenhaus_schema.cartillavacunes (
    idcartilla SERIAL PRIMARY KEY,
    idpacient BIGINT NOT NULL,
    idvacuna BIGINT NOT NULL,
    datavacunacio DATE NOT NULL,
    data2vacunacio DATE,
    date3vacunacio DATE,
    CONSTRAINT fk_cartillavacunes_pacient FOREIGN KEY (idpacient) REFERENCES krankenhaus_schema.pacient (idpacient) ON DELETE CASCADE,
    CONSTRAINT fk_cartillavacunes_vacuna FOREIGN KEY (idvacuna) REFERENCES krankenhaus_schema.vacuna (idvacuna) ON DELETE CASCADE
);

-- Crear tabla virus
CREATE TABLE krankenhaus_schema.virus (
    idvirus SERIAL PRIMARY KEY,
    idvacuna BIGINT NOT NULL,
    nomvirus TEXT,
    numvariant INTEGER,
    CONSTRAINT fk_virus_vacuna FOREIGN KEY (idvacuna) REFERENCES krankenhaus_schema.vacuna (idvacuna) ON DELETE CASCADE
);

-- Crear tabla stock
CREATE TABLE krankenhaus_schema.stock (
    idvacuna BIGINT NOT NULL,
    idhospital BIGINT NOT NULL,
    qty BIGINT NOT NULL,
    CONSTRAINT fk_stock_vacuna FOREIGN KEY (idvacuna) REFERENCES krankenhaus_schema.vacuna (idvacuna),
    CONSTRAINT fk_stock_hospital FOREIGN KEY (idhospital) REFERENCES krankenhaus_schema.hospital (idhospital)
);

-- Crear tabla treballador
CREATE TABLE krankenhaus_schema.treballador (
    idtreballador SERIAL PRIMARY KEY,
    idpersona BIGINT NOT NULL,
    CONSTRAINT fk_treballador_persona FOREIGN KEY (idpersona) REFERENCES krankenhaus_schema.persona (idpersona) ON DELETE CASCADE
);

-- Crear tabla doctor
CREATE TABLE krankenhaus_schema.doctor (
    iddoctor SERIAL PRIMARY KEY,
    idtreballador BIGINT NOT NULL,
    idpacient BIGINT,
    especialitat TEXT,
    CONSTRAINT fk_doctor_treballador FOREIGN KEY (idtreballador) REFERENCES krankenhaus_schema.treballador (idtreballador) ON DELETE CASCADE,
    CONSTRAINT fk_doctor_pacient FOREIGN KEY (idpacient) REFERENCES krankenhaus_schema.pacient (idpacient) ON DELETE CASCADE
);

-- Crear tabla enfermer
CREATE TABLE krankenhaus_schema.enfermer (
    idenfermer SERIAL PRIMARY KEY,
    idtreballador BIGINT NOT NULL,
    idpacient BIGINT,
    especilitat TEXT,
    CONSTRAINT unq_enfermer_idpacient UNIQUE (idpacient),
    CONSTRAINT fk_enfermer_treballador FOREIGN KEY (idtreballador) REFERENCES krankenhaus_schema.treballador (idtreballador) ON DELETE CASCADE,
    CONSTRAINT fk_enfermer_pacient FOREIGN KEY (idpacient) REFERENCES krankenhaus_schema.pacient (idpacient) ON DELETE CASCADE
);

-- Crear tabla administratiu
CREATE TABLE krankenhaus_schema.administratiu (
    idadministratiu SERIAL PRIMARY KEY,
    idtreballador BIGINT NOT NULL,
    carg TEXT,
    CONSTRAINT fk_administratiu_treballador FOREIGN KEY (idtreballador) REFERENCES krankenhaus_schema.treballador (idtreballador) ON DELETE CASCADE
);