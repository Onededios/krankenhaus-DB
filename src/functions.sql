--------------------------------------------------------------------------------------
-- INGRESA PACIENT -- FUNCIONA
CREATE OR REPLACE FUNCTION ingresaPacient(p_idpacient INTEGER, inp_iddoctor INTEGER)
RETURNS void AS $$
DECLARE
  p_nom TEXT;
  p_cognom TEXT;
  inp_idpersona INTEGER;
  v_estat TEXT;
  inp_doctorHosp INTEGER;
  inp_nomHosp TEXT;
BEGIN
  SELECT nom INTO p_nom FROM persona NATURAL JOIN pacient WHERE idpacient = p_idpacient;
  SELECT cognom INTO p_cognom FROM persona NATURAL JOIN pacient WHERE idpacient = p_idpacient;
  SELECT estat INTO v_estat FROM persona NATURAL JOIN pacient WHERE idpacient = p_idpacient;
  IF v_estat = 'molt greu' THEN
    -- Si la persona está en estado 'molt greu', ocupará una UCI.
    SELECT idhospital INTO inp_doctorHosp FROM persona NATURAL JOIN treballador NATURAL JOIN doctor WHERE iddoctor=inp_iddoctor;
    SELECT idpersona INTO inp_idpersona FROM persona NATURAL JOIN pacient WHERE idpacient = p_idpacient;

    SELECT nomhospital INTO inp_nomHosp FROM hospital WHERE idhospital = inp_doctorHosp;

    UPDATE persona SET idhospital = inp_doctorHosp WHERE idpersona = inp_idpersona;
    UPDATE pacient SET ocupauci = true WHERE idpacient = p_idpacient;

    RAISE NOTICE 'El pacient % % es troba assignat a la UCI i se li ha assignat al hospital %.', p_nom, p_cognom, inp_nomHosp;
  ELSE
    -- Si la persona no se encuentra en estado 'molt greu', se dará de alta en una habitación.
    UPDATE pacient SET ocupauci = false WHERE idpacient = p_idpacient;
    RAISE NOTICE 'El pacient % % no necessita estar assignat a la UCI.', p_nom, p_cognom;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM ingresaPacient(1);

--------------------------------------------------------------------------------------
-- REVISA PACIENT -- FUNCIONA
CREATE OR REPLACE FUNCTION actualizaEstadoPaciente(p_idpacient INTEGER)
RETURNS VOID AS $$
DECLARE
  v_idhospital bigint;
  p_nom TEXT;
  p_cognom TEXT;
  v_estat TEXT;
BEGIN
  SELECT nom INTO p_nom FROM persona NATURAL JOIN pacient WHERE idpacient = p_idpacient;
  SELECT cognom INTO p_cognom FROM persona NATURAL JOIN pacient WHERE idpacient = p_idpacient;
  SELECT estat INTO v_estat FROM persona NATURAL JOIN pacient WHERE idpacient = p_idpacient;
  IF v_estat = 'molt greu' THEN
    -- Actualizar el estado del paciente a 'molt greu' y asignarle una UCI
    UPDATE pacient SET estat = v_estat, ocupauci = true WHERE idpacient = p_idpacient;
    RAISE NOTICE 'El pacient % % es troba assignat a la UCI.', p_nom, p_cognom;
  ELSE
    -- Dar de alta al paciente y actualizar su estado a 'fora de perill'
    UPDATE pacient SET estat = v_estat, ocupauci = false WHERE idpacient = p_idpacient;
    RAISE NOTICE 'El pacient % % no necessita estar assignat a la UCI.', p_nom, p_cognom;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM actualizaEstadoPaciente(123, 'fora de perill');

--------------------------------------------------------------------------------------
-- FICAR STOCK -- FUNCIONA
CREATE OR REPLACE FUNCTION ficaStock(p_nombre_vacuna TEXT, addQTY BIGINT)
RETURNS BIGINT AS $$
DECLARE
  actQTY INTEGER;
BEGIN
    SELECT stock.qty INTO actQTY
    FROM stock NATURAL JOIN vacuna
    WHERE vacuna.nomvacuna = p_nombre_vacuna;

    UPDATE stock SET qty = actQTY + addQTY;

    SELECT stock.qty INTO actQTY
    FROM stock NATURAL JOIN vacuna
    WHERE nomvacuna = p_nombre_vacuna;

    RAISE NOTICE 'El stock de la vacuna % ha sigut incrementat a %', p_nombre_vacuna, actQTY;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM ficaStock('Terminator', 1000000);

--------------------------------------------------------------------------------------
-- POSA DOSIS 1 -- FUNCIONA
CREATE OR REPLACE FUNCTION posaDosis1(inp_idpacient INTEGER, inp_idvacuna INTEGER)
RETURNS VOID AS $$
DECLARE
  fecha_primera_dosis DATE;
  inp_idcartilla INTEGER;
BEGIN
  SELECT idcartilla INTO inp_idcartilla FROM cartillavacunes WHERE idpacient=inp_idpacient;
  SELECT datavacunacio INTO fecha_primera_dosis FROM pacient NATURAL JOIN cartillavacunes WHERE idpacient=inp_idpacient AND idvacuna=inp_idvacuna;

  UPDATE cartillavacunes SET data2vacunacio = fecha_primera_dosis + INTERVAL '120 days' WHERE idcartilla = inp_idcartilla;
  UPDATE cartillavacunes SET data3vacunacio = fecha_primera_dosis + INTERVAL '240 days' WHERE idcartilla = inp_idcartilla;

  RAISE NOTICE 'El pacient té programades la data % per a la segona vacuna i la data % per a la tercera.', fecha_primera_dosis + INTERVAL '120 days', fecha_primera_dosis + INTERVAL '240 days';
END;
$$ LANGUAGE plpgsql;

--------------------------------------------------------------------------------------
-- AVISA POC STOCK -- FUNCIONA
CREATE OR REPLACE FUNCTION avisaPocStock()
RETURNS TRIGGER AS $$
DECLARE
  min_QTY INTEGER = 1000;
BEGIN
  IF NEW.qty < min_QTY THEN
    RAISE NOTICE 'La quantitat de stock de aquesta vacuna es inferior a %.', min_QTY;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------------
 -- ES NECESARIO CREAR EL TRIGGER PARA QUE LA FUNCIÓN SALTE --
CREATE TRIGGER trigger_avisa_poc_stock
AFTER UPDATE ON krankenhaus_schema.stock
FOR EACH ROW
EXECUTE FUNCTION avisaPocStock();

-- PARA ACTIVAR EL TRIGGER NECESITAMOS HACER UN UPDATE --
-- update stock set qty=500 where idvacuna=1;

--------------------------------------------------------------------------------------
-- Llista Pacients Cartilla -- FUNCIONA
CREATE OR REPLACE FUNCTION LlistaPacientsCartilla()
  RETURNS TABLE (
    idpacient INTEGER,
    idcartilla INTEGER,
    nom TEXT,
    cognom TEXT,
    nomhospital TEXT,
    planta TEXT,
    habitacio TEXT,
    nomvacuna TEXT,
    datavacunacio DATE,
    data2vacunacio DATE,
    data3vacunacio DATE
  )
AS $$
BEGIN
  RETURN QUERY
  SELECT pacient.idpacient, cartillavacunes.idcartilla, persona.nom, persona.cognom, hospital.nomhospital, pacient.planta, pacient.habitacio, vacuna.nomvacuna, cartillavacunes.datavacunacio, cartillavacunes.data2vacunacio, cartillavacunes.data3vacunacio
  FROM persona
  NATURAL JOIN pacient
  NATURAL JOIN hospital
  NATURAL JOIN cartillavacunes
  NATURAL JOIN vacuna
  WHERE ocupauci
  ORDER BY idpacient;
END;
$$ LANGUAGE plpgsql;

-- PARA MOSTRAR LOS PACIENTES HOSPITALIZADOS --
-- SELECT * FROM mostrar_pacientes_hospitalizados();