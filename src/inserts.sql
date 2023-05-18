INSERT INTO ciutat ( nomciutat ) VALUES
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

INSERT INTO hospital ( nomhospital, numllitsucilliures, idciutat ) VALUES
( 'Rapzapin Direct Company', 730, 7 ) ,
( 'Klibanollover WorldWide Company', 900, 5 ),
( 'Klierplar WorldWide Group', 496, 1 ) ;

INSERT INTO persona ( idhospital, nom, cognom, datanaixement ) VALUES
( 2, 'Abel', 'Spencer', '2011-04-01' ) ,
( 2, 'Erick', 'Leonard', NULL ) ,
( 2, 'Janice', 'Montes', '2001-05-05' ) ,
( 2, 'Gretchen', 'Proctor', '2015-05-13' ) ,
( 2, 'Lawanda', 'Velazquez', '2004-07-18' ) ,
( 0, 'Robbie', 'Wilkins', '2013-03-16' ) ,
( 2, 'Carla', 'Randall', '2016-02-18' ) ,
( 0, 'Heath', 'Dickson', NULL ) ,
( 0, 'Kendra', 'Rodgers', NULL ) ,
( 1, 'Brandie', 'Finley', '2016-03-22' ) ,
( 0, 'Rose', 'Escobar', '2018-11-28' ) ,
( 2, 'Ernest', 'Robinson', '2003-01-20' ) ,
( 2, 'Randal', 'Larsen', '2018-03-16' ) ,
( 2, 'Ismael', 'Dickerson', '2019-12-25' ) ,
( 2, 'Keri', 'Brennan', NULL ) ,
( 0, 'Cameron', 'Bass', '2002-10-07' ) ,
( 0, 'Roberta', 'Morse', '2009-08-01' ) ,
( 1, 'Colby', 'Boone', '2010-11-07' ) ,
( 2, 'Cornelius', 'Herring', '2009-04-08' ) ,
( 1, 'Teddy', 'Martin', NULL ) ;

INSERT INTO pacient ( idpersona, planta, habitacio, estat, ocupauci ) VALUES
( 0, 'Baixa', '023', 'molt greu', true ),
( 1, 'Primera', '143', 'greu', true ),
( 2, 'Segona', '246', 'moderat', false ),
( 3, 'Tercera', '332', 'lleu', false ),
( 4, 'Quarta', '419', 'fora de perill', true ),
( 5, 'Cinquena', '503', 'greu', true ),
( 6, 'Sisena', '602', 'lleu', false ),
( 7, 'Segona', '215', 'moderat', true ),
( 8, 'Primera', '108', 'molt greu', true ),
( 9, 'Baixa', '016', 'moderat', false );

INSERT INTO cartillavacunes ( idpacient, idvacuna, datavacunacio ) VALUES
( 7, 2, '2014-08-15' ) ,
( 1, 0, '2011-04-01' ) ,
( 4, 2, '2001-06-02' ) ,
( 4, 0, '2016-02-08' ) ,
( 2, 1, '2001-05-05' ) ,
( 0, 2, '2011-08-21' ) ,
( 3, 2, '2015-05-13' ) ,
( 6, 0, '2011-07-03' ) ,
( 9, 2, '2004-07-18' ) ,
( 7, 2, '2017-01-17' ) ;

INSERT INTO treballador ( idpersona ) VALUES
( 10 ),
( 11 ),
( 12 ),
( 13 ),
( 14 ),
( 15 ),
( 16 ),
( 17 ),
( 18 ),
( 19 );

INSERT INTO administratiu ( idtreballador, carg ) VALUES
( 7, 'Technical Customer' ) ,
( 1, 'National Marketing' ) ;

INSERT INTO doctor ( idtreballador, idpacient, especialitat ) VALUES
( 2, 2, 'Cardióleg' ),
( 3, 0, 'Pediatra' ),
( 4, 8, 'Psiquiatra' );

INSERT INTO enfermer ( idtreballador, idpacient, especilitat ) VALUES
( 5, 2, 'Infermer mèdico-quirúrgic' ),
( 6, 0, 'Infermer de cures intensives' ),
( 7, 8, 'Infermer pediàtric' ),
( 8, 1, 'Infermer geriàtric' ),
( 9, 9, 'Infermer comunitàri' );

INSERT INTO vacuna ( nomvacuna, laboratori, numdosis ) VALUES
( 'Latoya Spencer', 'Monfropepistor Holdings Company', 7.31057369148862E7 ),
( 'Terminator', 'Skynet Labs', 7099203.475193139 ),
( 'Lakeisha Montes', 'Barcador Holdings Group', 6712000.939049955 );

INSERT INTO virus ( idvacuna, nomvirus, numvariant ) VALUES
 ( 2, 'Alex Cremento', 379250082 ),
 ( 1, 'Dolores Delano', 1049914525 ),
 ( 0, 'Lola Mento', 1774486701 );

INSERT INTO stock ( idvacuna, idhospital, qty ) VALUES
 ( 0, 2, 73105736 ),
 ( 1, 0, 7099203 ),
 ( 2, 1, 6712000 ),
 ( 0, 1, 76815698 );