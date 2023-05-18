CREATE  TABLE ciutat (
	idciutat             SERIAL PRIMARY KEY  ,
	nomciutat            text    ,
	CONSTRAINT unq_ciutat_nomciutat UNIQUE ( nomciutat )
 );

CREATE  TABLE hospital (
	idhospital           SERIAL PRIMARY KEY  ,
	nomhospital          text  NOT NULL  ,
	numllitsucilliures   bigint    ,
	idciutat             bigint    ,
	CONSTRAINT unq_hospital_nomhospital UNIQUE ( nomhospital )  ,
    CONSTRAINT fk_hospital_ciutat FOREIGN KEY (idciutat) REFERENCES ciutat (idciutat) ON DELETE CASCADE
 );

ALTER TABLE hospital ADD CONSTRAINT fk_hospital_ciutat_0 FOREIGN KEY ( idciutat ) REFERENCES ciutat( idciutat );

CREATE  TABLE persona (
	idpersona            SERIAL PRIMARY KEY  ,
    idhospital           bigint  NOT NULL  ,
	nom                  text  NOT NULL  ,
	cognom               text  NOT NULL  ,
	datanaixement        date
 );

ALTER TABLE persona ADD CONSTRAINT fk_persona_hospital FOREIGN KEY ( idhospital ) REFERENCES hospital( idhospital );

CREATE  TABLE pacient (
	idpacient            SERIAL  PRIMARY KEY  ,
	idpersona            bigint  NOT NULL  ,
	planta               text    ,
	habitacio            text    ,
	ocupauci             boolean    ,
	estat                text    ,
	CONSTRAINT unq_pacient_idpersona UNIQUE ( idpersona ) ,
    CONSTRAINT fk_pacient_persona FOREIGN KEY (idpersona) REFERENCES persona (idpersona) ON DELETE CASCADE
 );

ALTER TABLE pacient ADD CONSTRAINT fk2_pacient_persona FOREIGN KEY ( idpersona ) REFERENCES persona ( idpersona );

CREATE  TABLE cartillavacunes (
	idcartilla           SERIAL  PRIMARY KEY  ,
	idpacient            bigint  NOT NULL  ,
	idvacuna             bigint  NOT NULL  ,
	datavacunacio        date  NOT NULL  ,
    CONSTRAINT fk_pacient_cartilla FOREIGN KEY (idpacient) REFERENCES pacient (idpacient) ON DELETE CASCADE
 );

ALTER TABLE cartillavacunes ADD CONSTRAINT fk_cartillavacunes_pacient_0 FOREIGN KEY ( idpacient ) REFERENCES pacient( idpacient );

CREATE  TABLE vacuna (
	idvacuna             SERIAL PRIMARY KEY  ,
	nomvacuna            text  NOT NULL  ,
	laboratori           text    ,
	numdosis             decimal  NOT NULL  ,
	CONSTRAINT unq_vacuna_nomvacuna UNIQUE ( nomvacuna )
 );

ALTER TABLE cartillavacunes ADD CONSTRAINT fk_cartillavacunes_vacuna_0 FOREIGN KEY ( idvacuna ) REFERENCES vacuna( idvacuna );

CREATE  TABLE virus (
	idvirus              SERIAL  PRIMARY KEY  ,
	idvacuna             bigint  NOT NULL  ,
	nomvirus             text    ,
	numvariant           integer    ,
    CONSTRAINT fk_virus_vacuna FOREIGN KEY (idvacuna) REFERENCES vacuna (idvacuna) ON DELETE CASCADE
 );

ALTER TABLE virus ADD CONSTRAINT fk_virus_vacuna_0 FOREIGN KEY ( idvacuna ) REFERENCES vacuna( idvacuna );

CREATE  TABLE stock (
	idvacuna             bigint  NOT NULL  ,
	idhospital           bigint  NOT NULL  ,
	qty                  bigint  NOT NULL
 );

ALTER TABLE stock ADD CONSTRAINT fk_stock_vacuna_0 FOREIGN KEY ( idvacuna ) REFERENCES vacuna( idvacuna );

ALTER TABLE stock ADD CONSTRAINT fk_stock_hospital_0 FOREIGN KEY ( idhospital ) REFERENCES hospital( idhospital );

CREATE  TABLE treballador (
	idtreballador        SERIAL  PRIMARY KEY  ,
	idpersona            bigint  NOT NULL  ,
    CONSTRAINT fk_treballador_persona FOREIGN KEY (idpersona) REFERENCES persona (idpersona) ON DELETE CASCADE
 );

ALTER TABLE treballador ADD CONSTRAINT fk_treballador_persona_0 FOREIGN KEY ( idpersona ) REFERENCES persona( idpersona );

CREATE  TABLE doctor (
	iddoctor             SERIAL PRIMARY KEY  ,
	idtreballador        bigint  NOT NULL  ,
	idpacient            bigint    ,
	especialitat         text    ,
    CONSTRAINT fk_doctor_treballador FOREIGN KEY (idtreballador) REFERENCES treballador (idtreballador) ON DELETE CASCADE
 );

ALTER TABLE doctor ADD CONSTRAINT fk_doctor_treballador_0 FOREIGN KEY ( idtreballador ) REFERENCES treballador( idtreballador );

ALTER TABLE doctor ADD CONSTRAINT fk_doctor_pacient_0 FOREIGN KEY ( idpacient ) REFERENCES pacient( idpacient );

CREATE  TABLE enfermer (
	idenfermer           SERIAL PRIMARY KEY  ,
	idtreballador        bigint  NOT NULL  ,
	idpacient            bigint    ,
	especilitat          text    ,
	CONSTRAINT unq_enfermer_idpacient UNIQUE ( idpacient )  ,
    CONSTRAINT fk_enfermer_treballador FOREIGN KEY (idtreballador) REFERENCES treballador (idtreballador) ON DELETE CASCADE
 );

ALTER TABLE enfermer ADD CONSTRAINT fk_enfermer_treballador_0 FOREIGN KEY ( idtreballador ) REFERENCES treballador( idtreballador );

ALTER TABLE enfermer ADD CONSTRAINT fk_enfermer_pacient_0 FOREIGN KEY ( idpacient ) REFERENCES pacient( idpacient );

CREATE  TABLE administratiu (
	idadministratiu      SERIAL PRIMARY KEY  ,
	idtreballador        bigint  NOT NULL  ,
	carg                 text    ,
    CONSTRAINT fk_administratiu_treballador FOREIGN KEY (idtreballador) REFERENCES treballador (idtreballador) ON DELETE CASCADE
 );

ALTER TABLE administratiu ADD CONSTRAINT fk_administratiu_treballador_0 FOREIGN KEY ( idtreballador ) REFERENCES treballador( idtreballador );
