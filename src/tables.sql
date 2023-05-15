CREATE  TABLE ciutat (
	idciutat             bigint  NOT NULL  ,
	nomciutat            text    ,
	CONSTRAINT pk_ciutat PRIMARY KEY ( idciutat ),
	CONSTRAINT unq_ciutat_nomciutat UNIQUE ( nomciutat )
 );

CREATE  TABLE hospital (
	idhospital           bigint  NOT NULL  ,
	nomhospital          text  NOT NULL  ,
	numllitsucilliures   bigint    ,
	idciutat             bigint    ,
	CONSTRAINT pk_hospital PRIMARY KEY ( idhospital ),
	CONSTRAINT unq_hospital_ciutat UNIQUE ( idciutat ) ,
	CONSTRAINT unq_hospital_nomhospital UNIQUE ( nomhospital )
 );

ALTER TABLE hospital ADD CONSTRAINT fk_hospital_ciutat_0 FOREIGN KEY ( idciutat ) REFERENCES ciutat( idciutat );

CREATE  TABLE persona (
	idpersona            bigint  NOT NULL  ,
	nom                  text  NOT NULL  ,
	cognom               text  NOT NULL  ,
	datanaixement        date    ,
	idhospital           bigint  NOT NULL  ,
	CONSTRAINT pk_persona PRIMARY KEY ( idpersona )
 );

ALTER TABLE persona ADD CONSTRAINT fk_persona_hospital FOREIGN KEY ( idhospital ) REFERENCES hospital( idhospital );

CREATE  TABLE pacient (
	idpacient            bigint  NOT NULL  ,
	idpersona            bigint  NOT NULL  ,
	planta               text    ,
	habitacio            text    ,
	ocupauci             boolean    ,
	estat                text    ,
	CONSTRAINT pk_pacient PRIMARY KEY ( idpacient ),
	CONSTRAINT unq_pacient_idpersona UNIQUE ( idpersona )
 );

ALTER TABLE pacient ADD CONSTRAINT fk_pacient_persona FOREIGN KEY ( idpersona ) REFERENCES persona( idpersona );

CREATE  TABLE cartillavacunes (
	idcartilla           bigint  NOT NULL  ,
	idpacient            bigint  NOT NULL  ,
	idvacuna             bigint  NOT NULL  ,
	datavacunacio        date  NOT NULL  ,
	CONSTRAINT pk_cartillavacunes PRIMARY KEY ( idcartilla )
 );

ALTER TABLE cartillavacunes ADD CONSTRAINT fk_cartillavacunes_pacient_0 FOREIGN KEY ( idpacient ) REFERENCES pacient( idpacient );

ALTER TABLE cartillavacunes ADD CONSTRAINT fk_cartillavacunes_vacuna_0 FOREIGN KEY ( idvacuna ) REFERENCES vacuna( idvacuna );


CREATE  TABLE virus (
	idvirus              bigint  NOT NULL  ,
	idvacuna             bigint  NOT NULL  ,
	nomvirus             text    ,
	numvariant           integer    ,
	CONSTRAINT pk_virus PRIMARY KEY ( idvirus ),
	CONSTRAINT unq_virus_idvacuna UNIQUE ( idvacuna )
 );

ALTER TABLE virus ADD CONSTRAINT fk_virus_vacuna_0 FOREIGN KEY ( idvacuna ) REFERENCES vacuna( idvacuna );

CREATE  TABLE vacuna (
	idvacuna             bigint  NOT NULL  ,
	nomvacuna            text  NOT NULL  ,
	laboratori           text    ,
	numdosis             decimal  NOT NULL  ,
	CONSTRAINT pk_vacuna PRIMARY KEY ( idvacuna ),
	CONSTRAINT unq_vacuna_nomvacuna UNIQUE ( nomvacuna )
 );

CREATE  TABLE stock (
	idvacuna             bigint  NOT NULL  ,
	idhospital           bigint  NOT NULL  ,
	qty                  bigint  NOT NULL
 );

ALTER TABLE stock ADD CONSTRAINT fk_stock_vacuna_0 FOREIGN KEY ( idvacuna ) REFERENCES vacuna( idvacuna );

ALTER TABLE stock ADD CONSTRAINT fk_stock_hospital_0 FOREIGN KEY ( idhospital ) REFERENCES hospital( idhospital );

CREATE  TABLE treballador (
	idtreballador        bigint  NOT NULL  ,
	idpersona            bigint  NOT NULL  ,
	CONSTRAINT pk_treballador PRIMARY KEY ( idtreballador )
 );

ALTER TABLE treballador ADD CONSTRAINT fk_treballador_persona_0 FOREIGN KEY ( idpersona ) REFERENCES persona( idpersona );

CREATE  TABLE doctor (
	iddoctor             bigint  NOT NULL  ,
	idtreballador        bigint  NOT NULL  ,
	idpacient            bigint    ,
	especialitat         text    ,
	CONSTRAINT pk_doctor PRIMARY KEY ( iddoctor )
 );

ALTER TABLE doctor ADD CONSTRAINT fk_doctor_treballador_0 FOREIGN KEY ( idtreballador ) REFERENCES treballador( idtreballador );

ALTER TABLE doctor ADD CONSTRAINT fk_doctor_pacient_0 FOREIGN KEY ( idpacient ) REFERENCES pacient( idpacient );

CREATE  TABLE enfermer (
	idenfermer           bigint  NOT NULL  ,
	idtreballador        bigint  NOT NULL  ,
	idpacient            bigint    ,
	especilitat          text    ,
	CONSTRAINT pk_enfermer PRIMARY KEY ( idenfermer ),
	CONSTRAINT unq_enfermer_idpacient UNIQUE ( idpacient )
 );

ALTER TABLE enfermer ADD CONSTRAINT fk_enfermer_treballador_0 FOREIGN KEY ( idtreballador ) REFERENCES treballador( idtreballador );

ALTER TABLE enfermer ADD CONSTRAINT fk_enfermer_pacient_0 FOREIGN KEY ( idpacient ) REFERENCES pacient( idpacient );

CREATE  TABLE administratiu (
	idadministratiu      bigint  NOT NULL  ,
	idtreballador        bigint  NOT NULL  ,
	carg                 text    ,
	CONSTRAINT pk_administratiu PRIMARY KEY ( idadministratiu )
 );

ALTER TABLE administratiu ADD CONSTRAINT fk_administratiu_treballador_0 FOREIGN KEY ( idtreballador ) REFERENCES treballador( idtreballador );
