INSERT INTO krankenhaus_schema.ciutat ( nomciutat ) VALUES
( 'Oklahoma' ) ,
( 'Rhode Island' ),
( 'West Virginia' ),
( 'Indiana' ) ,
( 'California' ),
( 'Masachusetts' ) ,
( 'Ohio' ) ,
( 'Connecticut' ),
( 'New Hampshire' ),
( 'Wisconsin' );

INSERT INTO krankenhaus_schema.hospital ( nomhospital, numllitsucilliures, idciutat ) VALUES
( 'Rapzapin Direct Company', 730, 7 ) ,
( 'Klibanollover WorldWide Company', 900, 5 ),
( 'Klierplar WorldWide Group', 496, 1 ) ;

INSERT INTO krankenhaus_schema.persona ( idhospital, nom, cognom, datanaixement ) VALUES
( 3, 'Abel', 'Spencer', '2011-04-01' ) ,
( 3, 'Erick', 'Leonard', NULL ) ,
( 3, 'Janice', 'Montes', '2001-05-05' ) ,
( 3, 'Gretchen', 'Proctor', '2015-05-13' ) ,
( 3, 'Lawanda', 'Velazquez', '2004-07-18' ) ,
( 1, 'Robbie', 'Wilkins', '2013-03-16' ) ,
( 3, 'Carla', 'Randall', '2016-02-18' ) ,
( 1, 'Heath', 'Dickson', NULL ) ,
( 1, 'Kendra', 'Rodgers', NULL ) ,
( 2, 'Brandie', 'Finley', '2016-03-22' ) ,
( 1, 'Rose', 'Escobar', '2018-11-28' ) ,
( 3, 'Ernest', 'Robinson', '2003-01-20' ) ,
( 1, 'Randal', 'Larsen', '2018-03-16' ) ,
( 2, 'Ismael', 'Dickerson', '2019-12-25' ) ,
( 3, 'Keri', 'Brennan', NULL ) ,
( 1, 'Cameron', 'Bass', '2002-10-07' ) ,
( 1, 'Roberta', 'Morse', '2009-08-01' ) ,
( 2, 'Colby', 'Boone', '2010-11-07' ) ,
( 3, 'Cornelius', 'Herring', '2009-04-08' ) ,
( 2, 'Teddy', 'Martin', NULL ) ;

INSERT INTO krankenhaus_schema.pacient ( idpersona, planta, habitacio, estat, ocupauci ) VALUES
( 1, 'Baixa', '023', 'molt greu', true ),
( 2, 'Primera', '143', 'greu', true ),
( 3, 'Segona', '246', 'moderat', false ),
( 4, 'Tercera', '332', 'lleu', false ),
( 5, 'Quarta', '419', 'fora de perill', true ),
( 6, 'Cinquena', '503', 'greu', true ),
( 7, 'Sisena', '602', 'lleu', false ),
( 8, 'Segona', '215', 'moderat', true ),
( 9, 'Primera', '108', 'molt greu', true ),
( 10, 'Baixa', '016', 'moderat', false );

INSERT INTO krankenhaus_schema.treballador ( idpersona ) VALUES
( 11 ),
( 12 ),
( 13 ),
( 14 ),
( 15 ),
( 16 ),
( 17 ),
( 18 ),
( 19 ),
( 20 );

INSERT INTO krankenhaus_schema.administratiu ( idtreballador, carg ) VALUES
( 1, 'Technical Customer' ) ,
( 2, 'National Marketing' ) ;

INSERT INTO krankenhaus_schema.doctor ( idtreballador, idpacient, especialitat ) VALUES
( 3, 2, 'Cardióleg' ),
( 4, 1, 'Pediatra' ),
( 5, 8, 'Psiquiatra' );

INSERT INTO krankenhaus_schema.enfermer ( idtreballador, idpacient, especilitat ) VALUES
( 6, 2, 'Infermer mèdico-quirúrgic' ),
( 7, 1, 'Infermer de cures intensives' ),
( 8, 8, 'Infermer pediàtric' ),
( 9, 3, 'Infermer geriàtric' ),
( 10, 9, 'Infermer comunitàri' );

INSERT INTO krankenhaus_schema.vacuna ( nomvacuna, laboratori, numdosis ) VALUES
( 'Latoya Spencer', 'Monfropepistor Holdings Company', 7.31057369148862E7 ),
( 'Terminator', 'Skynet Labs', 7099203.475193139 ),
( 'Lakeisha Montes', 'Barcador Holdings Group', 6712000.939049955 );

INSERT INTO krankenhaus_schema.cartillavacunes ( idpacient, idvacuna, datavacunacio ) VALUES
( 8, 3, '2014-08-15' ) ,
( 2, 1, '2011-04-01' ) ,
( 5, 3, '2001-06-02' ) ,
( 5, 1, '2016-02-08' ) ,
( 3, 2, '2001-05-05' ) ,
( 1, 3, '2011-08-21' ) ,
( 4, 3, '2015-05-13' ) ,
( 7, 1, '2011-07-03' ) ,
( 10, 3, '2004-07-18' ) ,
( 8, 2, '2017-01-17' ) ;

INSERT INTO krankenhaus_schema.virus ( idvacuna, nomvirus, numvariant ) VALUES
 ( 3, 'Alex Cremento', 379250082 ),
 ( 2, 'Dolores Delano', 1049914525 ),
 ( 1, 'Lola Mento', 1774486701 );

INSERT INTO krankenhaus_schema.stock ( idvacuna, idhospital, qty ) VALUES
 ( 1, 3, 1100 ),
 ( 2, 1, 5000 ),
 ( 3, 2, 2310 ),
 ( 1, 2, 1500 );