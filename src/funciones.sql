-- INGRESA PACIENT --
CREATE OR REPLACE FUNCTION ingresaPacient(p_nom VARCHAR(100), p_cognom VARCHAR(100), p_estat VARCHAR(100))
RETURNS VARCHAR(100) AS $$
DECLARE
  v_mensaje VARCHAR(100);
BEGIN
  IF p_estat = 'molt greu' THEN
    -- Si la persona está en estat 'molt greu', ocuparà una UCI.
    INSERT INTO uci(nom, cognom, estat) VALUES (p_nom, p_cognom, p_estat);
    v_mensaje := 'La persona es troba a l\'UCI';
  ELSE
    -- Si la persona no es troba 'molt greu', es donarà d'alta.
    INSERT INTO hospital(nom, cognom, estat) VALUES (p_nom, p_cognom, p_estat);
    v_mensaje := 'La persona es queda a l\'hospital';
  END IF;

  RETURN v_mensaje;
END;
$$ LANGUAGE plpgsql;

-- REVISA PACIENT --
CREATE OR REPLACE FUNCTION revisaPacient(p_nom VARCHAR(100), p_cognom VARCHAR(100), p_estat VARCHAR(100))
RETURNS VARCHAR(100) AS $$
DECLARE
  v_mensaje VARCHAR(100);
BEGIN
  IF p_estat = 'molt greu' THEN
    -- Si la persona está en estat 'molt greu', ocuparà una UCI.
    INSERT INTO uci(nom, cognom, estat) VALUES (p_nom, p_cognom, p_estat);
    v_mensaje := 'La persona es troba a l\'UCI';
  ELSE IF p_estat = 'fora de perill' THEN
    -- Si la persona es troba 'fora de perill', se li pot donar d'alta i deixarà de ser pacient.
    v_mensaje := 'La persona es troba \'fora de perill, se li pot donar d\'alta';
  ELSE
    -- Si la persona no es troba 'molt greu', es donarà d'alta.
    INSERT INTO hospital(nom, cognom, estat) VALUES (p_nom, p_cognom, p_estat);
    v_mensaje := 'La persona es troba \'fora de perill\' donar d\'alta';
  END IF;

  RETURN v_mensaje;
END;
$$ LANGUAGE plpgsql;

-- FICAR STOCK --
CREATE OR REPLACE FUNCTION ficaStock(p_nombre_vacuna VARCHAR(100))
RETURNS INTEGER AS $$
DECLARE
  v_suma INTEGER;
BEGIN
  SELECT SUM(numdosis) INTO v_suma
  FROM vacuna
  WHERE nombre_de_vacuna = p_nombre_vacuna;

  RETURN v_suma;
END;
$$ LANGUAGE plpgsql;

-- POSA DOSIS 1 --
CREATE OR REPLACE FUNCTION posaDosis1(p_id_persona INTEGER, p_fecha_primera_dosis DATE)
RETURNS VOID AS $$
DECLARE
  v_fecha_segunda_dosis DATE;
  v_fecha_tercera_dosis DATE;
BEGIN
  v_fecha_segunda_dosis := p_fecha_primera_dosis + INTERVAL '120 days';
  v_fecha_tercera_dosis := v_fecha_segunda_dosis + INTERVAL '120 days';

  INSERT INTO cartillavacunes (idcartilla, idpacient, idvacuna, datavacunacio)
  VALUES (p_id_persona, p_fecha_primera_dosis, 1), (p_id_persona, v_fecha_segunda_dosis, 2), (p_id_persona, v_fecha_tercera_dosis, 3);

END;
$$ LANGUAGE plpgsql;

-- AVISA POC STOCK --
CREATE OR REPLACE FUNCTION avisaPocStock()
RETURNS TRIGGER AS $$
DECLARE
  v_tipo_vacuna TEXT;
  v_cantidad_vacuna INTEGER;
BEGIN
  IF TG_OP = 'INSERT' THEN -- Solo se activa el trigger en el caso de una inserción
    v_tipo_vacuna := NEW.tipo_vacuna;
    SELECT COUNT(*) INTO v_cantidad_vacuna FROM stock WHERE tipo_vacuna = v_tipo_vacuna;
    IF v_cantidad_vacuna < 5 THEN -- Si queda menos de 5 unidades de la vacuna, se envía una notificación
      PERFORM pg_notify('vacunas', 'Quedan menos de 5 unidades de la vacuna ' || v_tipo_vacuna);
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
