-- INGRESA PACIENT -- CORREGIRLO
CREATE OR REPLACE FUNCTION ingresaPacient(p_idpacient INTEGER)
RETURNS VARCHAR(100) AS $$
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
    -- Si la persona está en estado 'molt greu', ocupará una UCI.
    UPDATE pacient SET ocupauci = true WHERE idpacient = p_idpacient;
    RAISE NOTICE 'La persona % % se encuentra en la UCI', p_nom, p_cognom;
  ELSE
    -- Si la persona no se encuentra en estado 'molt greu', se dará de alta en una habitación.
    UPDATE pacient SET ocupauci = false WHERE idpacient = p_idpacient;
    RAISE NOTICE 'La persona % % se queda en el hospital', p_nom, p_cognom;
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM ingresaPacient(1);
--------------------------------------------------------------------------------------
-- REVISA PACIENT -- CORREGIDA
CREATE OR REPLACE FUNCTION actualizaEstadoPaciente(p_idpacient BIGINT, p_nou_estat TEXT)
RETURNS VOID AS $$
BEGIN
  IF p_nou_estat = 'molt greu' THEN
    -- Actualizar el estado del paciente a 'molt greu' y asignarle una UCI
    UPDATE pacient SET estat = p_nou_estat, ocupauci = true WHERE idpacient = p_idpacient;
    RAISE NOTICE 'Este usuario % ocupa un espai en la uci',p_idpacient;
  ELSIF p_nou_estat = 'fora de perill' THEN
    -- Dar de alta al paciente y actualizar su estado a 'fora de perill'
    UPDATE pacient SET estat = p_nou_estat, ocupauci = false WHERE idpacient = p_idpacient;
    RAISE NOTICE 'Este usuario % no ocupa la uci',p_idpacient;
  ELSE
    -- Otro caso no especificado, no realizar ninguna acción
    RAISE NOTICE 'Estat no vàlid. No ha realitzat cap acció.';
  END IF;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM actualizaEstadoPaciente(123, 'fora de perill');

-- FICAR STOCK -- CORREGIDA
CREATE OR REPLACE FUNCTION ficaStock(p_nombre_vacuna TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_suma INTEGER;
BEGIN
  SELECT SUM(numdosis) INTO v_suma
  FROM vacuna
  WHERE nomvacuna = p_nombre_vacuna;

  RETURN v_suma;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM ficaStock('Terminator');

-- POSA DOSIS 1 --
CREATE OR REPLACE FUNCTION posaDosis1(p_id_persona INTEGER, p_fecha_primera_dosis DATE)
RETURNS VOID AS $$
DECLARE
  v_fecha_segunda_dosis DATE;
  v_fecha_tercera_dosis DATE;
BEGIN
  v_fecha_segunda_dosis := p_fecha_primera_dosis + INTERVAL '120 days';
  v_fecha_tercera_dosis := v_fecha_segunda_dosis + INTERVAL '120 days';

  UPDATE INTO cartillavacunes (idcartilla, idpacient, idvacuna, datavacunacio, data2vacunacio, data3vacunacio)
  VALUES (p_id_persona, p_fecha_primera_dosis, 1), (p_id_persona, v_fecha_segunda_dosis, 2), (p_id_persona, v_fecha_tercera_dosis, 3);

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