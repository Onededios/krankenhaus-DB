INSERT INTO ciutat ( idciutat, nomciutat ) VALUES
( 0, 'Rhode Island' ),
( 1, 'Indiana' ),
( 2, 'California' ),
( 3, 'Connecticut' ),
( 4, 'Wisconsin' ),
( 5, NULL ),
( 6, 'Louisiana' ),
( 7, 'Illinois' ),
( 8, 'Texas' ),
( 9, 'Washington' );
INSERT INTO hospital ( idhospital, nomhospital, numllitsucilliures, ciutat ) VALUES
( 0, 'Rapzapin Direct Company', 29337656, 'Illinois' ),
( 1, 'Klibanollover WorldWide Company', 8965434, 'Louisiana' ),
( 2, 'Klierplar WorldWide Group', 85468095, 'Rhode Island' );
INSERT INTO persona ( idpersona, idhospital, nom, cognom, datanaixement ) VALUES 
( 0, 2, 'Latoya', 'Cisneros', '2018-02-24' ),
( 1, 0, 'Casey', 'Blackburn', '2016-03-19' ) ,
( 2, 1, 'Lakeisha', 'Byrd', '2004-05-09' ) ,
( 3, 1, 'Colleen', 'Miles', '2005-09-08' ) ,
( 4, 0, 'Alice', 'Ingram', NULL ) ,
( 5, 0, 'Bernard', 'Neal', '2000-06-30' ) ,
( 6, 0, 'Howard', 'White', '2013-12-26' ) ,
( 7, 1, 'Hector', 'Daniels', '2016-02-06' ) ,
( 8, 2, 'Vernon', 'Barrera', '2003-01-09' ) ,
( 9, 2, 'Mike', 'Middleton', '2018-06-29' ) ,
( 10, 0, 'Marissa', 'Haynes', '2015-04-11' ) ,
( 11, 0, 'Ruby', 'Garrett', '2000-01-25' ) ,
( 12, 2, 'Joni', 'Rodgers', '2014-09-23' ) ,
( 13, 0, 'Duane', 'Moreno', '2019-02-15' ) ,
( 14, 2, 'Harry', 'Ellison', '2016-06-21' ) ,
( 15, 1, 'Luz', 'Ryan', '2003-10-10' ) ,
( 16, 2, 'Salvatore', 'Matthews', '2006-07-10' ) ,
( 17, 2, 'Byron', 'Newman', '2015-01-12' ) ,
( 18, 2, 'Sammy', 'George', '2005-08-10' ) ,
( 19, 1, 'Anthony', 'Hoffman', '2004-08-08' );
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
( 0, 0, 'Atenció al client' ), 
( 1, 1, 'Control de gestió' );
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
 INSERT INTO stock ( idvacuna, idhospital, vacuna, qty ) VALUES
 ( 0, 2, 'Latoya Spencer', 73105736 ),
 ( 1, 0, 'Terminator', 7099203 ),
 ( 2, 1, 'Lakeisha Montes', 6712000 ),
 ( 3, 1, 'Colleen Proctor', 76815698 );
 INSERT INTO virus ( idvirus, idpacient, idvacuna, vacuna, nomvirus, numvariant ) VALUES
 ( 0, 7, 0, 'Latoya Spencer', 'Alex Cremento', 379250082 ),
 ( 1, 1, 1, 'Terminator', 'Dolores Delano', 1049914525 ),
 ( 2, 4, 2, 'Lakeisha Montes', 'Lola Mento', 1774486701 );
INSERT INTO vacuna ( idvacuna, nomvacuna, laboratori, numdosis ) VALUES
( 0, 'Latoya Spencer', 'Monfropepistor Holdings Company', 7.31057369148862E7 ),
( 1, 'Terminator', 'Skynet Labs', 7099203.475193139 ),
( 2, 'Lakeisha Montes', 'Barcador Holdings Group', 6712000.939049955 );
INSERT INTO cartillavacunes ( idcartilla, idpacient, idvacuna, datavacunacio ) VALUES
 ( 0, 7, 0, '2014-08-15' ),
 ( 1, 1, 2, '2011-04-01' ),
 ( 2, 4, 1, '2001-06-02' ),
 ( 3, 4, 0, '2016-02-08' ),
 ( 4, 2, 1, '2001-05-05' ),
 ( 5, 0, 2, '2011-08-21' ),
 ( 6, 3, 0, '2015-05-13' ),
 ( 7, 6, 2, '2011-07-03' ),
 ( 8, 9, 2, '2004-07-18' ),
 ( 9, 7, 1, '2017-01-17' );