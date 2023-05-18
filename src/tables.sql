CREATE  TABLE krankenhaus_schema.ciutat (
	idciutat             SERIAL PRIMARY KEY  ,
	nomciutat            text    ,
	CONSTRAINT unq_ciutat_nomciutat UNIQUE ( nomciutat )
 );

CREATE  TABLE krankenhaus_schema.hospital (
	idhospital           SERIAL PRIMARY KEY  ,
	nomhospital          text  NOT NULL  ,
	numllitsucilliures   bigint    ,
	idciutat             bigint    ,
	CONSTRAINT unq_hospital_nomhospital UNIQUE ( nomhospital )  ,
    CONSTRAINT fk_hospital_ciutat FOREIGN KEY (idciutat) REFERENCES krankenhaus_schema.ciutat (idciutat) ON DELETE CASCADE
 );

ALTER TABLE krankenhaus_schema.hospital ADD CONSTRAINT fk_hospital_ciutat_0 FOREIGN KEY ( idciutat ) REFERENCES krankenhaus_schema.ciutat ( idciutat );

CREATE  TABLE krankenhaus_schema.persona (
	idpersona            SERIAL PRIMARY KEY  ,
    idhospital           bigint  NOT NULL  ,
	nom                  text  NOT NULL  ,
	cognom               text  NOT NULL  ,
	datanaixement        date
 );

ALTER TABLE krankenhaus_schema.persona ADD CONSTRAINT fk_persona_hospital FOREIGN KEY ( idhospital ) REFERENCES krankenhaus_schema.hospital ( idhospital );

CREATE  TABLE krankenhaus_schema.pacient (
	idpacient            SERIAL  PRIMARY KEY  ,
	idpersona            bigint  NOT NULL  ,
	planta               text    ,
	habitacio            text    ,
	ocupauci             boolean    ,
	estat                text    ,
	CONSTRAINT unq_pacient_idpersona UNIQUE ( idpersona ) ,
    CONSTRAINT fk_pacient_persona FOREIGN KEY (idpersona) REFERENCES krankenhaus_schema.persona (idpersona) ON DELETE CASCADE
 );

ALTER TABLE krankenhaus_schema.pacient ADD CONSTRAINT fk2_pacient_persona FOREIGN KEY ( idpersona ) REFERENCES krankenhaus_schema.persona ( idpersona );

CREATE  TABLE krankenhaus_schema.cartillavacunes (
	idcartilla           SERIAL  PRIMARY KEY  ,
	idpacient            bigint  NOT NULL  ,
	idvacuna             bigint  NOT NULL  ,
	datavacunacio        date  NOT NULL  ,
	data2vacunacio       date ,
	date3vacunacio       date ,
    CONSTRAINT fk_pacient_cartilla FOREIGN KEY (idpacient) REFERENCES krankenhaus_schema.pacient (idpacient) ON DELETE CASCADE
 );

ALTER TABLE krankenhaus_schema.cartillavacunes ADD CONSTRAINT fk_cartillavacunes_pacient_0 FOREIGN KEY ( idpacient ) REFERENCES krankenhaus_schema.pacient ( idpacient );

CREATE  TABLE krankenhaus_schema.vacuna (
	idvacuna             SERIAL PRIMARY KEY  ,
	nomvacuna            text  NOT NULL  ,
	laboratori           text    ,
	numdosis             decimal  NOT NULL  ,
	CONSTRAINT unq_vacuna_nomvacuna UNIQUE ( nomvacuna )
 );

ALTER TABLE krankenhaus_schema.cartillavacunes ADD CONSTRAINT fk_cartillavacunes_vacuna_0 FOREIGN KEY ( idvacuna ) REFERENCES krankenhaus_schema.vacuna ( idvacuna );

CREATE  TABLE krankenhaus_schema.virus (
	idvirus              SERIAL  PRIMARY KEY  ,
	idvacuna             bigint  NOT NULL  ,
	nomvirus             text    ,
	numvariant           integer    ,
    CONSTRAINT fk_virus_vacuna FOREIGN KEY (idvacuna) REFERENCES krankenhaus_schema.vacuna (idvacuna) ON DELETE CASCADE
 );

ALTER TABLE krankenhaus_schema.virus ADD CONSTRAINT fk_virus_vacuna_0 FOREIGN KEY ( idvacuna ) REFERENCES krankenhaus_schema.vacuna ( idvacuna );

CREATE  TABLE krankenhaus_schema.stock (
	idvacuna             bigint  NOT NULL  ,
	idhospital           bigint  NOT NULL  ,
	qty                  bigint  NOT NULL
 );

ALTER TABLE krankenhaus_schema.stock ADD CONSTRAINT fk_stock_vacuna_0 FOREIGN KEY ( idvacuna ) REFERENCES krankenhaus_schema.vacuna ( idvacuna );

ALTER TABLE krankenhaus_schema.stock ADD CONSTRAINT fk_stock_hospital_0 FOREIGN KEY ( idhospital ) REFERENCES krankenhaus_schema.hospital ( idhospital );

CREATE  TABLE treballador (
	idtreballador        SERIAL  PRIMARY KEY  ,
	idpersona            bigint  NOT NULL  ,
    CONSTRAINT fk_treballador_persona FOREIGN KEY (idpersona) REFERENCES krankenhaus_schema.persona (idpersona) ON DELETE CASCADE
 );

ALTER TABLE krankenhaus_schema.treballador ADD CONSTRAINT fk_treballador_persona_0 FOREIGN KEY ( idpersona ) REFERENCES krankenhaus_schema.persona ( idpersona );

CREATE  TABLE krankenhaus_schema.doctor (
	iddoctor             SERIAL PRIMARY KEY  ,
	idtreballador        bigint  NOT NULL  ,
	idpacient            bigint    ,
	especialitat         text    ,
    CONSTRAINT fk_doctor_treballador FOREIGN KEY (idtreballador) REFERENCES krankenhaus_schema.treballador (idtreballador) ON DELETE CASCADE
 );

ALTER TABLE krankenhaus_schema.doctor ADD CONSTRAINT fk_doctor_treballador_0 FOREIGN KEY ( idtreballador ) REFERENCES krankenhaus_schema.treballador ( idtreballador );

ALTER TABLE krankenhaus_schema.doctor ADD CONSTRAINT fk_doctor_pacient_0 FOREIGN KEY ( idpacient ) REFERENCES krankenhaus_schema.pacient ( idpacient );

CREATE  TABLE enfermer (
	idenfermer           SERIAL PRIMARY KEY  ,
	idtreballador        bigint  NOT NULL  ,
	idpacient            bigint    ,
	especilitat          text    ,
	CONSTRAINT unq_enfermer_idpacient UNIQUE ( idpacient )  ,
    CONSTRAINT fk_enfermer_treballador FOREIGN KEY (idtreballador) REFERENCES krankenhaus_schema.treballador (idtreballador) ON DELETE CASCADE
 );

ALTER TABLE krankenhaus_schema.enfermer ADD CONSTRAINT fk_enfermer_treballador_0 FOREIGN KEY ( idtreballador ) REFERENCES krankenhaus_schema.treballador ( idtreballador );

ALTER TABLE krankenhaus_schema.enfermer ADD CONSTRAINT fk_enfermer_pacient_0 FOREIGN KEY ( idpacient ) REFERENCES krankenhaus_schema.pacient ( idpacient );

CREATE  TABLE administratiu (
	idadministratiu      SERIAL PRIMARY KEY  ,
	idtreballador        bigint  NOT NULL  ,
	carg                 text    ,
    CONSTRAINT fk_administratiu_treballador FOREIGN KEY (idtreballador) REFERENCES krankenhaus_schema.treballador (idtreballador) ON DELETE CASCADE
 );

ALTER TABLE krankenhaus_schema.administratiu ADD CONSTRAINT fk_administratiu_treballador_0 FOREIGN KEY ( idtreballador ) REFERENCES krankenhaus_schema.treballador( idtreballador );
