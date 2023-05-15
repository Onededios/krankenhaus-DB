INSERT INTO ciutat ( idciutat, nomciutat ) VALUES
( 0, 'Oklahoma' ) ,
( 1, 'Rhode Island' ),
( 2, 'West Virginia' ),
( 3, 'Indiana' ) ,
( 4, 'California' ),
( 5, 'Masachusetts' ) ,
( 6, 'Ohio' ) ,
( 7, 'Connecticut' ),
( 8, 'New Hampshire' ),
( 9, 'Wisconsin' );

INSERT INTO hospital ( idhospital, nomhospital, numllitsucilliures, idciutat ) VALUES 
( 0, 'Rapzapin Direct Company', 730, 7 ) ,
( 1, 'Klibanollover WorldWide Company', 900, 5 ), 
( 2, 'Klierplar WorldWide Group', 496, 0 ) ;

INSERT INTO persona ( idpersona, nom, cognom, datanaixement, idhospital ) VALUES
( 0, 'Abel', 'Spencer', '2011-04-01', 2 ) ,
( 1, 'Erick', 'Leonard', NULL, 2 ) ,
( 2, 'Janice', 'Montes', '2001-05-05', 2 ) ,
( 3, 'Gretchen', 'Proctor', '2015-05-13', 2 ) ,
( 4, 'Lawanda', 'Velazquez', '2004-07-18', 2 ) ,
( 5, 'Robbie', 'Wilkins', '2013-03-16', 0 ) ,
( 6, 'Carla', 'Randall', '2016-02-18', 2 ) ,
( 7, 'Heath', 'Dickson', NULL, 0 ) ,
( 8, 'Kendra', 'Rodgers', NULL, 0 ) ,
( 9, 'Brandie', 'Finley', '2016-03-22', 1 ) ,
( 10, 'Rose', 'Escobar', '2018-11-28', 0 ) ,
( 11, 'Ernest', 'Robinson', '2003-01-20', 2 ) ,
( 12, 'Randal', 'Larsen', '2018-03-16', 2 ) ,
( 13, 'Ismael', 'Dickerson', '2019-12-25', 2 ) ,
( 14, 'Keri', 'Brennan', NULL, 2 ) ,
( 15, 'Cameron', 'Bass', '2002-10-07', 0 ) ,
( 16, 'Roberta', 'Morse', '2009-08-01', 0 ) ,
( 17, 'Colby', 'Boone', '2010-11-07', 1 ) ,
( 18, 'Cornelius', 'Herring', '2009-04-08', 2 ) ,
( 19, 'Teddy', 'Martin', NULL, 1 ) ;

INSERT INTO pacient ( idpacient, idpersona, planta, habitacio, estat, ocupauci ) VALUES
( 0, 0, 'Baixa', '023', 'molt greu', true ),
( 1, 1, 'Primera', '143', 'greu', true ),
( 2, 2, 'Segona', '246', 'moderat', false ),
( 3, 3, 'Tercera', '332', 'lleu', false ),
( 4, 4, 'Quarta', '419', 'fora de perill', true ),
( 5, 5, 'Cinquena', '503', 'greu', true ),
( 6, 6, 'Sisena', '602', 'lleu', false ),
( 7, 7, 'Segona', '215', 'moderat', true ),
( 8, 8, 'Primera', '108', 'molt greu', true ),
( 9, 9, 'Baixa', '016', 'moderat', false );

INSERT INTO cartillavacunes ( idcartilla, idpacient, idvacuna, datavacunacio ) VALUES
( 0, 7, 2, '2014-08-15' ) ,
( 1, 1, 0, '2011-04-01' ) ,
( 2, 4, 2, '2001-06-02' ) ,
( 3, 4, 0, '2016-02-08' ) ,
( 4, 2, 1, '2001-05-05' ) ,
( 5, 0, 2, '2011-08-21' ) ,
( 6, 3, 2, '2015-05-13' ) ,
( 7, 6, 0, '2011-07-03' ) ,
( 8, 9, 2, '2004-07-18' ) ,
( 9, 7, 2, '2017-01-17' ) ;

INSERT INTO treballador ( idtreballador, idpersona ) VALUES
( 0, 10 ),
( 1, 11 ),
( 2, 12 ),
( 3, 13 ),
( 4, 14 ),
( 5, 15 ),
( 6, 16 ),
( 7, 17 ),
( 8, 18 ),
( 9, 19 );

INSERT INTO administratiu ( idadministratiu, idtreballador, carg ) VALUES
( 0, 7, 'Technical Customer' ) ,
( 1, 1, 'National Marketing' ) ;

INSERT INTO doctor ( iddoctor, idtreballador, idpacient, especialitat ) VALUES 
( 0, 2, 2, 'Cardióleg' ),
( 1, 3, 0, 'Pediatra' ),
( 2, 4, 8, 'Psiquiatra' );

INSERT INTO enfermer ( idenfermer, idtreballador, idpacient, especilitat ) VALUES
( 0, 5, 2, 'Infermer mèdico-quirúrgic' ),
( 1, 6, 0, 'Infermer de cures intensives' ),
 ( 2, 7, 8, 'Infermer pediàtric' ),
( 3, 8, 1, 'Infermer geriàtric' ),
( 4, 9, 9, 'Infermer comunitàri' );

INSERT INTO vacuna ( idvacuna, nomvacuna, laboratori, numdosis ) VALUES
( 0, 'Latoya Spencer', 'Monfropepistor Holdings Company', 7.31057369148862E7 ),
( 1, 'Terminator', 'Skynet Labs', 7099203.475193139 ),
( 2, 'Lakeisha Montes', 'Barcador Holdings Group', 6712000.939049955 );

INSERT INTO virus ( idvirus, idvacuna, nomvirus, numvariant ) VALUES
 ( 0, 2, 'Alex Cremento', 379250082 ),
 ( 1, 1, 'Dolores Delano', 1049914525 ),
 ( 2, 0, 'Lola Mento', 1774486701 );

INSERT INTO stock ( idvacuna, idhospital, qty ) VALUES
 ( 0, 2, 73105736 ),
 ( 1, 0, 7099203 ),
 ( 2, 1, 6712000 ),
 ( 0, 1, 76815698 );