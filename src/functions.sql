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

SELECT * FROM ingresaPacient(1);
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

SELECT * FROM actualizaEstadoPaciente(123, 'fora de perill');

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

SELECT * FROM ficaStock('Terminator', 1000000);

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

-- AVISA POC STOCK -- PRINCIPIO FUNCIONA
CREATE OR REPLACE FUNCTION avisaPocStock()
RETURNS TRIGGER AS $$
DECLARE
  v_tipo_vacuna TEXT;
  v_cantidad_vacuna INTEGER;
BEGIN
  IF TG_OP = 'INSERT' THEN -- Solo se activa el trigger en el caso de una inserción
    v_tipo_vacuna := NEW.nomvacuna;
    SELECT qty INTO v_cantidad_vacuna FROM stock WHERE idvacuna = NEW.idvacuna;
    IF v_cantidad_vacuna < 5 THEN -- Si queda menos de 5 unidades de la vacuna, se envía una notificación
      PERFORM pg_notify('vacunas', 'Quedan menos de 5 unidades de la vacuna ' || v_tipo_vacuna);
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


 -- ES NECESARIO CREAR EL TRIGGER PARA QUE LA FUNCIÓN ESTE CORRECTA --
CREATE TRIGGER trigger_avisa_poc_stock
AFTER INSERT ON stock
FOR EACH ROW
EXECUTE FUNCTION avisaPocStock();

-- PARA ACTIVAR EL TRIGGER NECESITAMOS HACER UN INSERT O UPDATE --
UPDATE or INSERT

-- Llista Pacients Cartilla -- CORREGIDA
CREATE OR REPLACE FUNCTION mostrar_pacientes_hospitalizados()
  RETURNS TABLE (
    idpacient BIGINT,
    idpersona BIGINT,
    planta TEXT,
    ocupauci BOOLEAN,
    estat TEXT
  )
AS $$
BEGIN
  RETURN QUERY
  SELECT pc.idpacient, p.idpersona, pc.planta, pc.ocupauci, pc.estat
  FROM pacient AS pc
  INNER JOIN persona AS p ON pc.idpersona = p.idpersona;
END;
$$ LANGUAGE plpgsql;

-- PARA MOSTRAR LOS PACIENTES HOSPITALIZADOS --
SELECT * FROM mostrar_pacientes_hospitalizados();