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
	ciutat               text  NOT NULL  ,
	CONSTRAINT pk_hospital PRIMARY KEY ( idhospital ),
	CONSTRAINT unq_hospital_ciutat UNIQUE ( ciutat ) 
 );

CREATE  TABLE persona ( 
	idpersona            bigint  NOT NULL  ,
	idhospital           bigint  NOT NULL  ,
	nom                  text  NOT NULL  ,
	cognom               text  NOT NULL  ,
	datanaixement        date    ,
	CONSTRAINT pk_persona PRIMARY KEY ( idpersona )
 );

CREATE  TABLE treballador ( 
	idtreballador        bigint  NOT NULL  ,
	idpersona            bigint  NOT NULL  ,
	CONSTRAINT pk_treballador PRIMARY KEY ( idtreballador )
 );

CREATE  TABLE administratiu ( 
	idadministratiu      bigint  NOT NULL  ,
	idtreballador        bigint  NOT NULL  ,
	carg                 text    ,
	CONSTRAINT pk_administratiu PRIMARY KEY ( idadministratiu )
 );

CREATE  TABLE pacient ( 
	idpacient            bigint  NOT NULL  ,
	idpersona            bigint  NOT NULL  ,
	planta               text    ,
	habitacio            text    ,
	estat                text    ,
	ocupauci             boolean    ,
	CONSTRAINT pk_pacient PRIMARY KEY ( idpacient )
 );

CREATE  TABLE doctor ( 
	iddoctor             bigint  NOT NULL  ,
	idtreballador        bigint  NOT NULL  ,
	idpacient            bigint    ,
	especialitat         text    ,
	CONSTRAINT pk_doctor PRIMARY KEY ( iddoctor )
 );

CREATE  TABLE enfermer ( 
	idenfermer           bigint  NOT NULL  ,
	idtreballador        bigint  NOT NULL  ,
	idpacient            bigint    ,
	especilitat          text    ,
	CONSTRAINT pk_enfermer PRIMARY KEY ( idenfermer ),
	CONSTRAINT unq_enfermer_idpacient UNIQUE ( idpacient ) 
 );

CREATE  TABLE cartillavacunes ( 
	idcartilla           bigint  NOT NULL  ,
	idpacient            bigint  NOT NULL  ,
	idvacuna             bigint  NOT NULL  ,
	datavacunacio        date  NOT NULL  ,
	CONSTRAINT unq_cartillavacunes_idvacuna PRIMARY KEY ( idvacuna ) ,
	CONSTRAINT pk_cartillavacunes PRIMARY KEY ( idcartilla )
 );

CREATE  TABLE stock ( 
	idvacuna             bigint  NOT NULL  ,
	idhospital           bigint  NOT NULL  ,
	vacuna               text  NOT NULL  ,
	qty                  bigint  NOT NULL  ,
	CONSTRAINT pk_stock PRIMARY KEY ( idvacuna )
 );

CREATE  TABLE vacuna ( 
	idvacuna             bigint  NOT NULL  ,
	nomvacuna            text  NOT NULL  ,
	laboratori           text    ,
	numdosis             decimal  NOT NULL  ,
	CONSTRAINT pk_vacuna PRIMARY KEY ( idvacuna ),
	CONSTRAINT unq_vacuna_nomvacuna UNIQUE ( nomvacuna ) 
 );

CREATE  TABLE virus ( 
	idvirus              bigint  NOT NULL  ,
	idpacient            bigint  NOT NULL  ,
	idvacuna             bigint  NOT NULL  ,
	vacuna               text  NOT NULL  ,
	nomvirus             text    ,
	numvariant           integer    ,
	CONSTRAINT pk_virus PRIMARY KEY ( idvirus ),
 );

ALTER TABLE administratiu ADD CONSTRAINT fk_administratiu_treballador FOREIGN KEY ( idtreballador ) REFERENCES treballador( idtreballador );

ALTER TABLE cartillavacunes ADD CONSTRAINT fk_cartillavacunes_pacient FOREIGN KEY ( idpacient ) REFERENCES pacient( idpacient );

ALTER TABLE cartillavacunes ADD CONSTRAINT fk_cartillavacunes_vacuna FOREIGN KEY ( idvacuna ) REFERENCES vacuna( idvacuna );

ALTER TABLE doctor ADD CONSTRAINT fk_doctor_treballador FOREIGN KEY ( idtreballador ) REFERENCES treballador( idtreballador );

ALTER TABLE doctor ADD CONSTRAINT fk_doctor_pacient FOREIGN KEY ( idpacient ) REFERENCES pacient( idpacient );

ALTER TABLE enfermer ADD CONSTRAINT fk_enfermer_treballador FOREIGN KEY ( idtreballador ) REFERENCES treballador( idtreballador );

ALTER TABLE enfermer ADD CONSTRAINT fk_enfermer_pacient FOREIGN KEY ( idpacient ) REFERENCES pacient( idpacient );

ALTER TABLE hospital ADD CONSTRAINT fk_hospital_ciutat FOREIGN KEY ( ciutat ) REFERENCES ciutat( nomciutat );

ALTER TABLE pacient ADD CONSTRAINT fk_pacient_persona FOREIGN KEY ( idpersona ) REFERENCES persona( idpersona );

ALTER TABLE persona ADD CONSTRAINT fk_persona_hospital FOREIGN KEY ( idhospital ) REFERENCES hospital( idhospital );

ALTER TABLE stock ADD CONSTRAINT fk_stock_vacuna FOREIGN KEY ( idvacuna ) REFERENCES vacuna( idvacuna );

ALTER TABLE stock ADD CONSTRAINT fk_stock_hospital FOREIGN KEY ( idhospital ) REFERENCES hospital( idhospital );

ALTER TABLE treballador ADD CONSTRAINT fk_treballador_persona FOREIGN KEY ( idpersona ) REFERENCES persona( idpersona );

ALTER TABLE vacuna ADD CONSTRAINT fk_vacuna_virus FOREIGN KEY ( idvacuna ) REFERENCES virus( idvacuna );

ALTER TABLE virus ADD CONSTRAINT fk_virus_vacuna FOREIGN KEY ( vacuna ) REFERENCES vacuna( nomvacuna );

ALTER TABLE virus ADD CONSTRAINT fk_virus_pacient FOREIGN KEY ( idpacient ) REFERENCES pacient( idpacient );
