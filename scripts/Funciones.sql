CREATE OR REPLACE FUNCTION func_registro_paciente(
	p_cui INT8,
	p_primer_nombre VARCHAR/*(25)*/,
	p_segundo_nombre VARCHAR/*(25)*/,
	p_primer_apellido VARCHAR/*(25)*/,
	p_segundo_apellido VARCHAR/*(25)*/,
	p_apellido_casada VARCHAR/*(25)*/,
	p_id_sexo INT4,
	p_fecha_nacimiento date,
	p_telefono INT4,
	p_email VARCHAR/*(75)*/,
	p_username VARCHAR/*(20)*/,
	p_contrasenia VARCHAR/*(150)*/
) RETURNS TABLE (
	mensaje TEXT,
	estado INTEGER
)
AS $$
        BEGIN
			IF EXISTS(SELECT 1 FROM persona WHERE cui = p_cui) THEN
				RETURN QUERY SELECT 'Los datos del Paciente ya existen!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF EXISTS(SELECT 1 FROM usuario WHERE username = p_username) THEN
				RETURN QUERY SELECT 'Nombre de usuario ya ha sido registrado!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_primer_nombre) > 25  THEN
				RETURN QUERY SELECT 'Primer nombre con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_segundo_nombre) > 25  THEN
				RETURN QUERY SELECT 'Segundo nombre con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_primer_apellido) > 25  THEN
				RETURN QUERY SELECT 'Primer apellido con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_segundo_apellido) > 25  THEN
				RETURN QUERY SELECT 'Segundo apellido con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_apellido_casada) > 25  THEN
				RETURN QUERY SELECT 'Apellido de casada con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_email) > 75  THEN
				RETURN QUERY SELECT 'Email con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_username) > 20  THEN
				RETURN QUERY SELECT 'Nombre de usuario con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_contrasenia) > 150  THEN
				RETURN QUERY SELECT 'Contraseña con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			INSERT INTO persona(cui, primer_nombre, segundo_nombre,
				                primer_apellido, segundo_apellido, apellido_casada,
				                id_sexo, fecha_nacimiento, telefono, email, estado)
			VALUES(p_cui, p_primer_nombre, p_segundo_nombre,
			       p_primer_apellido, p_segundo_apellido, p_apellido_casada,
			       p_id_sexo, p_fecha_nacimiento, p_telefono, p_email, 1);

            INSERT INTO ficha_clinica(cui, estado)
            VALUES(p_cui, 3);

			INSERT INTO usuario(username, cui, contrasenia, estado)
			VALUES(p_username, p_cui, p_contrasenia, 1);

			INSERT INTO usuario_rol(username, id_rol)
        	VALUES(p_username, 3);

        	RETURN QUERY SELECT 'Paciente registardo con exito!' AS mensaje, 200 AS estado;
        END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_agendar_cita(
	p_fecha_hora_inicio TIMESTAMP,
	p_cui_medico INT8,
	p_cui_paciente INT8,
	p_motivo VARCHAR/*(250)*/
) RETURNS TABLE (
	mensaje TEXT,
	estado INTEGER
) 
AS $$
        BEGIN
	        IF NOW()::TIMESTAMP >= p_fecha_hora_inicio THEN
				RETURN QUERY SELECT 'Horario invalido para agendar cita!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;
			IF 
				EXISTS(
					SELECT 1 
					FROM citas ci 
					WHERE cui_medico = p_cui_medico
					AND fecha_hora_inicio = p_fecha_hora_inicio
					AND ci.estado = 1
				) 
			THEN
				RETURN QUERY SELECT 'Cita ya ha sido registrada en ese horario!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;
	        IF
				EXISTS(
					SELECT 1
					FROM citas ci
					WHERE cui_paciente = p_cui_paciente
					AND fecha_hora_inicio = p_fecha_hora_inicio
					AND ci.estado = 1
				)
			THEN
				RETURN QUERY SELECT 'Paciente ya tiene cita en ese horario!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;
            IF LENGTH(p_motivo) > 250  THEN
				RETURN QUERY SELECT 'Motivo con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			INSERT INTO citas(id_cita, fecha_hora_inicio, fecha_hora_fin, motivo, cui_medico, cui_paciente, pago_bandera, aprobacion, estado)
            VALUES(
            	(SELECT COALESCE(MAX(id_cita) + 1, 1) FROM citas), 
                p_fecha_hora_inicio, 
                p_fecha_hora_inicio + interval '0.5 hour',
                p_motivo,
                p_cui_medico, p_cui_paciente, 1, 2, 1);
        
        	RETURN QUERY SELECT 'Cita agendada con exito!' AS mensaje, 200 AS estado;
        END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_reprogramar_cita(
	p_id_cita INT4,
	p_fecha_hora_inicio TIMESTAMP
) RETURNS TABLE (
	mensaje TEXT,
	estado INTEGER
) 
AS $$
        BEGIN
        	IF NOW()::TIMESTAMP >= p_fecha_hora_inicio THEN
				RETURN QUERY SELECT 'Horario invalido para agendar cita!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;
			IF 
				EXISTS(
					SELECT 1 
					FROM citas ci
					WHERE cui_medico = (SELECT c2.cui_medico FROM citas c2 WHERE c2.id_cita = p_id_cita) 
					AND fecha_hora_inicio = p_fecha_hora_inicio
					AND ci.estado = 1
				) 
			THEN
				RETURN QUERY SELECT 'Cita ya ha sido registrada en ese horario!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;
        	IF
				EXISTS(
					SELECT 1
					FROM citas ci
					WHERE cui_paciente = (SELECT c2.cui_paciente FROM citas c2 WHERE c2.id_cita = p_id_cita)
					AND fecha_hora_inicio = p_fecha_hora_inicio
					AND ci.estado = 1
				)
			THEN
				RETURN QUERY SELECT 'Paciente ya tiene cita en ese horario!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;
		
			UPDATE citas SET 
				fecha_hora_inicio = p_fecha_hora_inicio,
				fecha_hora_fin = p_fecha_hora_inicio + interval '0.5 hour'
			WHERE
				id_cita = p_id_cita;
        
        	RETURN QUERY SELECT 'Cita reprogramada con exito!' AS mensaje, 200 AS estado;
        END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_programar_reconsuta(
	p_username_medico VARCHAR,
	p_fecha_hora_inicio TIMESTAMP,
	p_cui_paciente INT8,
	p_pago_bandera INT4,
	p_motivo VARCHAR
) RETURNS TABLE (
	mensaje TEXT,
	estado INTEGER
) 
AS $$
        BEGIN
        	IF NOW()::TIMESTAMP >= p_fecha_hora_inicio THEN
				RETURN QUERY SELECT 'Horario invalido para agendar reconsulta!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;
			IF 
				EXISTS(
					SELECT 1 
					FROM citas ci
					WHERE cui_medico = (SELECT u2.cui FROM usuario u2 WHERE u2.username = p_username_medico) 
					AND fecha_hora_inicio = p_fecha_hora_inicio
					AND ci.estado = 1
				) 
			THEN
				RETURN QUERY SELECT 'Cita ya ha sido registrada en ese horario!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;
            IF
				EXISTS(
					SELECT 1
					FROM citas ci
					WHERE cui_paciente = p_cui_paciente
					AND fecha_hora_inicio = p_fecha_hora_inicio
					AND ci.estado = 1
				)
			THEN
				RETURN QUERY SELECT 'Paciente ya tiene cita en ese horario!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;
		    IF LENGTH(p_motivo) > 250  THEN
				RETURN QUERY SELECT 'Motivo con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			INSERT INTO citas(id_cita, fecha_hora_inicio, fecha_hora_fin, motivo, cui_medico, cui_paciente, pago_bandera, aprobacion, estado, reconsulta)
			VALUES(
                 	(SELECT COALESCE(MAX(id_cita) + 1, 1) FROM citas),
                 	p_fecha_hora_inicio,
					p_fecha_hora_inicio + interval '0.5 hour',
			        p_motivo,
					(SELECT cui FROM usuario WHERE username = p_username_medico),
					p_cui_paciente,
            	 	p_pago_bandera,
					1, 1, 1);
        
			IF p_pago_bandera = 2 THEN
				INSERT INTO consulta(id_consulta, id_cita, id_tipo_consulta, estado) 
                VALUES (
                    (SELECT COALESCE(MAX(id_consulta) + 1, 1) FROM consulta),
                    (SELECT MAX(id_cita) FROM citas WHERE cui_paciente = p_cui_paciente), 
                    2, 1);
			END IF;
					
        	RETURN QUERY SELECT 'Cita reprogramada con exito!' AS mensaje, 200 AS estado;
        END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_actualizar_menu(
    p_id_menu INT4,
    p_estado INT4
) RETURNS TABLE (
    mensaje TEXT,
    estado  INTEGER
)
AS $$
    BEGIN
        UPDATE menu
        SET
            estado = p_estado
        WHERE id_menu = p_id_menu;

        RETURN QUERY SELECT 'Menu actualizado con exito!' AS mensaje, 200 AS estado;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_aprobar_cita(
    p_id_cita INT4
) RETURNS TABLE (
    mensaje TEXT,
    estado  INTEGER
)
AS $$
    BEGIN
        UPDATE citas
        SET
            aprobacion = 1
        WHERE id_cita = p_id_cita;

        RETURN QUERY SELECT 'Cita aprobada con exito!' AS mensaje, 200 AS estado;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_rechazar_cita(
    p_id_cita INT4,
    p_motivo_rechazo VARCHAR
) RETURNS TABLE (
    mensaje TEXT,
    estado  INTEGER
)
AS $$
    BEGIN
        UPDATE citas
        SET
            aprobacion = 2,
            estado = 2,
            motivo_rechazo = p_motivo_rechazo
        WHERE id_cita = p_id_cita;

        RETURN QUERY SELECT 'Cita rechazada con exito!' AS mensaje, 200 AS estado;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_pagar_cita(
    p_id_cita INT4,
    p_id_tipo_pago INT4,
    p_monto INT4,
    p_no_transaccion INT8
) RETURNS TABLE (
    mensaje TEXT,
    estado INTEGER
)
AS $$
    BEGIN
        IF EXISTS(SELECT 1 FROM pago_consulta WHERE no_transaccion = p_no_transaccion ) THEN
            RETURN QUERY SELECT 'No. VL inválido. ya ha sido registrado!' AS mensaje, 404 AS estado;
            RETURN;
        END IF;
        IF p_monto IS NULL THEN
            RETURN QUERY SELECT 'Debe de ingresar el monto!' AS mensaje, 404 AS estado;
            RETURN;
        END IF;

        IF p_no_transaccion IS NULL THEN
            RETURN QUERY SELECT 'Debe de ingresar en numero de transferencia!' AS mensaje, 404 AS estado;
            RETURN;
        END IF;

        UPDATE citas
        SET
            pago_bandera = 2
        WHERE id_cita = p_id_cita;

        INSERT INTO pago_consulta(id_cita, id_tipo_pago, monto, no_transaccion)
        VALUES (p_id_cita, p_id_tipo_pago, p_monto, p_no_transaccion);

        INSERT INTO consulta(id_consulta, id_cita, id_tipo_consulta, estado)
        VALUES (
                (SELECT COALESCE(MAX(id_consulta) + 1, 1) FROM consulta),
                p_id_cita,
                (SELECT
                    CASE
                        WHEN cit.reconsulta IS NULL THEN 1
                        ELSE 2
                    END
                FROM citas cit
                WHERE cit.id_cita = p_id_cita),
                1);

        RETURN QUERY SELECT 'Cita pagada con exito!' AS mensaje, 200 AS estado;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION  func_actualizar_ficha_clinica(
    p_cui int8,
    p_quirurgico varchar,
    p_traumatico varchar,
    p_alergias varchar,
    p_menarquia date,
    p_fecha_ultima_regla date,
    p_partos int4,
    p_cesareas int4,
    p_aborto int4,
    p_hijos_vivos int4,
    p_hijos_muertos int4,
    p_lactancia_materna int4,
    p_ablactacion int4,
    p_inmunizacion int4
) RETURNS TABLE (
    mensaje TEXT,
    estado INTEGER
)
AS $$
    BEGIN

        IF LENGTH(p_quirurgico) > 150  THEN
            RETURN QUERY SELECT 'Datos quirurgicos con longitud invalida!' AS mensaje, 404 AS estado;
            RETURN;
        END IF;
        IF LENGTH(p_traumatico) > 150  THEN
            RETURN QUERY SELECT 'Datos traumáticos con longitud invalida!' AS mensaje, 404 AS estado;
            RETURN;
        END IF;
        IF LENGTH(p_alergias) > 150  THEN
            RETURN QUERY SELECT 'Datos de alergias con longitud invalida!' AS mensaje, 404 AS estado;
            RETURN;
        END IF;

        UPDATE ficha_clinica
        SET
            quirurgico = p_quirurgico,
            traumatico = p_traumatico,
            alergias = p_alergias,
            menarquia = p_menarquia,
            fecha_ultima_regla = p_fecha_ultima_regla,
            partos = p_partos,
            cesareas = p_cesareas,
            aborto = p_aborto,
            hijos_vivos = p_hijos_vivos,
            hijos_muertos = p_hijos_muertos,
            lactancia_materna = p_lactancia_materna,
            ablactacion = p_ablactacion,
            inmunizacion = p_inmunizacion,
            estado = 1
        WHERE cui = p_cui;

        RETURN QUERY SELECT 'Ficha clínica actualizada con exito!' AS mensaje, 200 AS estado;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION  func_eliminar_antecedentes_ficha_clinica(
    p_cui int8
) RETURNS TABLE (
    mensaje TEXT,
    estado INTEGER
)
AS $$
    BEGIN

        DELETE
        FROM ficha_antecedente
        WHERE cui = p_cui;

        RETURN QUERY SELECT 'Antecedentes ficha clínica eliminados con exito!' AS mensaje, 200 AS estado;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_insertar_antecedentes_ficha_clinica(
    p_cui int8,
    p_id_antecedente int4
) RETURNS TABLE (
    mensaje TEXT,
    estado INTEGER
)
AS $$
    BEGIN

        INSERT INTO ficha_antecedente(cui, id_antecedente)
        VALUES (p_cui, p_id_antecedente);

        RETURN QUERY SELECT 'Antecedente ficha clínica agregado con exito!' AS mensaje, 200 AS estado;
    END;
$$ LANGUAGE  plpgsql;

CREATE OR REPLACE FUNCTION func_cambiar_estado_paciente(
    p_cui int8,
    p_estado int4
) RETURNS TABLE (
    mensaje TEXT,
    estado INTEGER
)
AS $$
    BEGIN

        UPDATE persona SET
            estado = p_estado
        WHERE cui = p_cui;

        UPDATE usuario SET
            estado = p_estado
        WHERE cui = p_cui;

        IF
            NOT EXISTS(
                SELECT 1
                FROM ficha_clinica fc
                WHERE fc.cui = p_cui
                AND fc.estado = 3
            )
        THEN
            UPDATE ficha_clinica SET
                estado = p_estado
            WHERE cui = p_cui;
        END IF;

        RETURN QUERY SELECT 'Estado cambiado con exito!' AS mensaje, 200 AS estado;

    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_actualizar_datos_personales(
    p_cui INT8,
	p_primer_nombre VARCHAR,
	p_segundo_nombre VARCHAR,
	p_primer_apellido VARCHAR,
	p_segundo_apellido VARCHAR,
	p_apellido_casada VARCHAR,
	p_id_sexo INT4,
	p_fecha_nacimiento date,
	p_telefono INT4,
	p_email VARCHAR
) RETURNS TABLE (
    mensaje TEXT,
    estado INTEGER
)
AS $$
    BEGIN

        IF LENGTH(p_primer_nombre) > 25  THEN
				RETURN QUERY SELECT 'Primer nombre con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_segundo_nombre) > 25  THEN
				RETURN QUERY SELECT 'Segundo nombre con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_primer_apellido) > 25  THEN
				RETURN QUERY SELECT 'Primer apellido con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_segundo_apellido) > 25  THEN
				RETURN QUERY SELECT 'Segundo apellido con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_apellido_casada) > 25  THEN
				RETURN QUERY SELECT 'Apellido de casada con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_email) > 75  THEN
				RETURN QUERY SELECT 'Email con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

        UPDATE persona SET
            primer_nombre = p_primer_nombre,
            segundo_nombre = p_segundo_nombre,
            primer_apellido = p_primer_apellido,
            segundo_apellido = p_segundo_apellido,
            apellido_casada = p_apellido_casada,
            id_sexo = p_id_sexo,
            fecha_nacimiento = p_fecha_nacimiento,
            telefono = p_telefono,
            email = p_email
        WHERE cui = p_cui;

        RETURN QUERY SELECT 'Datos personales actualizados con exito!' AS mensaje, 200 AS estado;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_registro_medico(
	p_cui INT8,
	p_primer_nombre VARCHAR,
	p_segundo_nombre VARCHAR,
	p_primer_apellido VARCHAR,
	p_segundo_apellido VARCHAR,
	p_apellido_casada VARCHAR,
	p_id_sexo INT4,
	p_fecha_nacimiento date,
	p_telefono INT4,
	p_email VARCHAR,
	p_username VARCHAR,
	p_contrasenia VARCHAR,
	p_id_especialidad INT4,
	p_fecha_inicio DATE
) RETURNS TABLE (
	mensaje TEXT,
	estado INTEGER
)
AS $$
        BEGIN
			IF EXISTS(SELECT 1 FROM persona WHERE cui = p_cui) THEN
				RETURN QUERY SELECT 'Los datos del médico ya existen!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF EXISTS(SELECT 1 FROM usuario WHERE username = p_username) THEN
				RETURN QUERY SELECT 'Nombre de usuario ya ha sido registrado!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_primer_nombre) > 25  THEN
				RETURN QUERY SELECT 'Primer nombre con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_segundo_nombre) > 25  THEN
				RETURN QUERY SELECT 'Segundo nombre con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_primer_apellido) > 25  THEN
				RETURN QUERY SELECT 'Primer apellido con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_segundo_apellido) > 25  THEN
				RETURN QUERY SELECT 'Segundo apellido con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_apellido_casada) > 25  THEN
				RETURN QUERY SELECT 'Apellido de casada con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_email) > 75  THEN
				RETURN QUERY SELECT 'Email con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_username) > 20  THEN
				RETURN QUERY SELECT 'Nombre de usuario con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_contrasenia) > 150  THEN
				RETURN QUERY SELECT 'Contraseña con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			INSERT INTO persona(cui, primer_nombre, segundo_nombre,
				                primer_apellido, segundo_apellido, apellido_casada,
				                id_sexo, fecha_nacimiento, telefono, email, estado)
			VALUES(p_cui, p_primer_nombre, p_segundo_nombre,
			       p_primer_apellido, p_segundo_apellido, p_apellido_casada,
			       p_id_sexo, p_fecha_nacimiento, p_telefono, p_email, 1);

            INSERT INTO medicos(cui, id_especialidad, fecha_inicio, url, estado)
            VALUES(p_cui, p_id_especialidad, p_fecha_inicio, CONCAT('https://meet.hospitalasuncion.com/', p_username) , 1);

			INSERT INTO usuario(username, cui, contrasenia, estado)
			VALUES(p_username, p_cui, p_contrasenia, 1);

			INSERT INTO usuario_rol(username, id_rol)
        	VALUES(p_username, 2);

        	RETURN QUERY SELECT 'Médico registardo con exito!' AS mensaje, 200 AS estado;
        END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION  func_insertar_resultado_laboratorio(
    p_id_consulta_lab int4,
    p_resultado varchar/*(250)*/
) RETURNS TABLE (
    mensaje TEXT,
    estado INTEGER
)AS $$
    BEGIN

        UPDATE consulta_lab
        SET
            resultado = p_resultado,
            fecha_resultado = NOW()
        WHERE id_consulta_lab = p_id_consulta_lab;

        RETURN QUERY SELECT 'Resultado laboratorio agregado con exito!' AS mensaje, 200 AS estado;
    END;
$$ LANGUAGE  plpgsql;

CREATE OR REPLACE FUNCTION func_iniciar_consulta(
    p_id_consulta INT4
) RETURNS TABLE (
    mensaje TEXT,
    estado  INTEGER
)
AS $$
    BEGIN
        UPDATE citas
        SET
            estado = 4
        WHERE id_cita = (SELECT id_cita FROM consulta WHERE id_consulta = p_id_consulta);

        RETURN QUERY SELECT 'Consulta iniciada con exito!' AS mensaje, 200 AS estado;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_registro_tecnico(
	p_cui INT8,
	p_primer_nombre VARCHAR/*(25)*/,
	p_segundo_nombre VARCHAR/*(25)*/,
	p_primer_apellido VARCHAR/*(25)*/,
	p_segundo_apellido VARCHAR/*(25)*/,
	p_apellido_casada VARCHAR/*(25)*/,
	p_id_sexo INT4,
	p_fecha_nacimiento date,
	p_telefono INT4,
	p_email VARCHAR/*(75)*/,
	p_username VARCHAR/*(20)*/,
	p_contrasenia VARCHAR/*(150)*/
) RETURNS TABLE (
	mensaje TEXT,
	estado INTEGER
)
AS $$
        BEGIN
			IF EXISTS(SELECT 1 FROM persona WHERE cui = p_cui) THEN
				RETURN QUERY SELECT 'Los datos ya existen!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF EXISTS(SELECT 1 FROM usuario WHERE username = p_username) THEN
				RETURN QUERY SELECT 'Nombre de usuario ya ha sido registrado!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_primer_nombre) > 25  THEN
				RETURN QUERY SELECT 'Primer nombre con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_segundo_nombre) > 25  THEN
				RETURN QUERY SELECT 'Segundo nombre con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_primer_apellido) > 25  THEN
				RETURN QUERY SELECT 'Primer apellido con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_segundo_apellido) > 25  THEN
				RETURN QUERY SELECT 'Segundo apellido con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_apellido_casada) > 25  THEN
				RETURN QUERY SELECT 'Apellido de casada con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_email) > 75  THEN
				RETURN QUERY SELECT 'Email con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_username) > 20  THEN
				RETURN QUERY SELECT 'Nombre de usuario con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			IF LENGTH(p_contrasenia) > 150  THEN
				RETURN QUERY SELECT 'Contraseña con longitud invalida!' AS mensaje, 404 AS estado;
				RETURN;
			END IF;

			INSERT INTO persona(cui, primer_nombre, segundo_nombre,
				                primer_apellido, segundo_apellido, apellido_casada,
				                id_sexo, fecha_nacimiento, telefono, email, estado)
			VALUES(p_cui, p_primer_nombre, p_segundo_nombre,
			       p_primer_apellido, p_segundo_apellido, p_apellido_casada,
			       p_id_sexo, p_fecha_nacimiento, p_telefono, p_email, 1);

			INSERT INTO usuario(username, cui, contrasenia, estado)
			VALUES(p_username, p_cui, p_contrasenia, 1);

			INSERT INTO usuario_rol(username, id_rol)
        	VALUES(p_username, 4);

        	RETURN QUERY SELECT 'Técnico de laboratorio registardo con exito!' AS mensaje, 200 AS estado;
        END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_cambiar_estado_tecnico(
    p_cui int8,
    p_estado int4
) RETURNS TABLE (
    mensaje TEXT,
    estado INTEGER
)
AS $$
    BEGIN

        UPDATE persona SET
            estado = p_estado
        WHERE cui = p_cui;

        UPDATE usuario SET
            estado = p_estado
        WHERE cui = p_cui;

        RETURN QUERY SELECT 'Estado cambiado con exito!' AS mensaje, 200 AS estado;

    END;
$$ LANGUAGE plpgsql;
