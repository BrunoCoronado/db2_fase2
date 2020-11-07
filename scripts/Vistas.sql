CREATE OR REPLACE VIEW vw_cat_antecedentes AS
    SELECT id_antecedente AS id_antecedente,
           descripcion AS descripcion
    FROM antecedente
    ORDER BY id_antecedente;

CREATE OR REPLACE VIEW vw_cat_especialidad AS
    SELECT id_especialidad AS id_especialidad,
           descripcion AS descripcion
    FROM especialidad
    ORDER BY descripcion;

CREATE OR REPLACE VIEW vw_cat_tipo_pago AS
    SELECT id AS id_tipo_pago,
           descripcion AS descripcion
    FROM tipo_pago
    ORDER BY descripcion;

CREATE OR REPLACE VIEW vw_cat_impresion_clinica AS
    SELECT cie_10 AS cie_10, grupo AS grupo,
           diagnostico AS diagnostico, especifico AS especifico,
           descripcion AS descripcion,masculino AS masculino,
           femenino AS femenino
    FROM impresion_clinica;

CREATE OR REPLACE VIEW vw_cat_clasificacion_laboratorio AS
    SELECT id_clasificacion_laboratorio AS id_clasificacion_laboratorio,
           descripcion AS descripcion
    FROM clasificacion_laboratorio
    ORDER BY descripcion;

CREATE OR REPLACE VIEW vw_cat_laboratorio AS
    SELECT id_lab AS id_laboratorio, descripcion AS descripcion,
           id_clasificacion_laboratorio AS id_clasificacion_laboratorio
    FROM laboratorio
    ORDER BY descripcion;

CREATE OR REPLACE VIEW vw_tc_menu AS
    SELECT id_menu AS id_menu, url AS url,
           descripcion AS descripcion,
           grupo AS grupo, etiqueta AS etiqueta,
           estado AS estado
    FROM menu
    ORDER BY id_menu;

CREATE OR REPLACE VIEW vw_citas_calendario AS
    SELECT id_cita AS id_cita, cui_medico AS cui_medico,
           cui_paciente AS cui_paciente, pago_bandera AS pago_bandera,
           aprobacion AS aprobacion, estado AS estado,
           TO_CHAR(fecha_hora_inicio :: TIMESTAMP, 'YYYY-MM-DD HH24:MI') AS fecha_hora_inicio,
           TO_CHAR(fecha_hora_fin :: TIMESTAMP, 'YYYY-MM-DD HH24:MI') AS fecha_hora_fin
     FROM citas
     WHERE estado IN (1, 4)
     AND fecha_hora_fin >= NOW()::TIMESTAMP;

CREATE OR REPLACE VIEW vw_ficha_clinica AS
    SELECT p.id_sexo AS sexo, date_part('years', age(P.fecha_nacimiento)) AS edad, f.cui AS cui,
       f.quirurgico AS quirurgico, f.traumatico AS traumatico, f.alergias AS alergias,
       TO_CHAR(f.menarquia :: DATE, 'DD-MM-YYYY') AS menarquia,
       TO_CHAR(f.fecha_ultima_regla :: DATE, 'DD-MM-YYYY') AS fecha_ultima_regla,
       f.partos AS partos, f.cesareas AS cesareas, f.aborto AS aborto,
       f.hijos_vivos AS hijos_vivos, f.hijos_muertos AS hijos_muertos,
       f.lactancia_materna AS lactancia_materna, f.ablactacion AS ablactacion,
       f.inmunizacion AS inmunizacion, f.estado AS estado,
       a.id_antecedente AS id_antecedente, a.descripcion AS antecedente
    FROM ficha_clinica f
    LEFT JOIN ficha_antecedente fa on f.cui = fa.cui
    LEFT JOIN antecedente a on fa.id_antecedente = a.id_antecedente
    JOIN persona p on f.cui = p.cui;

CREATE OR REPLACE VIEW vw_tc_pacientes AS
    SELECT p.cui AS cui, p.primer_nombre AS primer_nombre, p.segundo_nombre AS segundo_nombre,
           p.primer_apellido AS primer_apellido, p.estado AS estado, p.segundo_apellido AS segundo_apellido,
           p.id_sexo AS id_sexo, p.apellido_casada AS apellido_casada,
           TO_CHAR(p.fecha_nacimiento :: DATE, 'YYYY-MM-DD') AS fecha_nacimiento,
           p.telefono AS telefono, p.email AS email, u.username AS username, u.contrasenia AS contrasenia
    FROM usuario u
    JOIN usuario_rol ur ON u.username = ur.username
    JOIN persona p ON u.cui = p.cui
    WHERE ur.id_rol = 3
    ORDER BY p.primer_nombre || p.primer_apellido;

CREATE OR REPLACE VIEW vw_datos_personales AS
    SELECT p.cui AS cui, p.primer_nombre AS primer_nombre, p.segundo_nombre AS segundo_nombre,
           p.primer_apellido AS primer_apellido, p.segundo_apellido AS segundo_apellido,
           p.id_sexo AS id_sexo, p.apellido_casada AS apellido_casada, p.telefono AS telefono,
           p.email AS email, TO_CHAR(fecha_nacimiento :: DATE, 'YYYY-MM-DD') AS fecha_nacimiento
    FROM persona p;

CREATE OR REPLACE VIEW vw_consultas_laboratorios_pendientes AS
    SELECT DISTINCT cl.id_consulta AS id_consulta, tc.descripcion AS tipo_consulta,
           CONCAT(p.primer_nombre, ' ', p.primer_apellido) AS medico,
           CONCAT(p2.primer_nombre, ' ', p2.primer_apellido) AS paciente,
           TO_CHAR(fecha_hora_inicio :: TIMESTAMP, 'YYYY-MM-DD HH24:MI') AS fecha_hora_inicio,
           TO_CHAR(fecha_hora_inicio :: TIMESTAMP, 'MM/DD/YYYY') AS fecha_filtro,
           p.cui AS cui_medico, tc.id_tipo_consulta AS id_tipo_consulta
    FROM consulta con
    JOIN consulta_lab cl on con.id_consulta = cl.id_consulta AND con.estado = 3
    JOIN tipo_consulta tc on con.id_tipo_consulta = tc.id_tipo_consulta
    JOIN citas c on con.id_cita = c.id_cita
    JOIN persona p on c.cui_medico = p.cui
    JOIN persona p2 on c.cui_paciente = p2.cui
    WHERE cl.resultado IS NULL
    ORDER BY fecha_hora_inicio;

CREATE OR REPLACE VIEW vw_tc_tecnicos AS
    SELECT p.cui AS cui, p.primer_nombre AS primer_nombre, p.segundo_nombre AS segundo_nombre,
           p.primer_apellido AS primer_apellido, p.estado AS estado, p.segundo_apellido AS segundo_apellido,
           p.id_sexo AS id_sexo, p.apellido_casada AS apellido_casada,
           TO_CHAR(p.fecha_nacimiento :: DATE, 'YYYY-MM-DD') AS fecha_nacimiento,
           p.telefono AS telefono, p.email AS email, u.username AS username, u.contrasenia AS contrasenia
    FROM usuario u
    JOIN usuario_rol ur ON u.username = ur.username
    JOIN persona p ON u.cui = p.cui
    WHERE ur.id_rol = 4
    ORDER BY p.primer_nombre || p.primer_apellido;

CREATE OR REPLACE VIEW vw_recordatorio_consultas AS
    SELECT TO_CHAR(cit.fecha_hora_inicio :: TIMESTAMP, 'DD/MM/YYYY a las HH24:MI horas') AS fecha_hora_inicio , CONCAT(m.primer_nombre, ' ', m.primer_apellido) AS medico,
           p.email AS email_paciente
    FROM citas cit
    JOIN consulta c on cit.id_cita = c.id_cita AND c.estado = 1
    JOIN persona m on cit.cui_medico = m.cui
    JOIN persona p ON cit.cui_paciente = p.cui
    WHERE fecha_hora_inicio < NOW()::TIMESTAMP + INTERVAL '1 day'
    AND fecha_hora_inicio >= NOW()::TIMESTAMP;


SELECT CONCAT(p.primer_nombre, ' ', p.primer_apellido) AS medico,
       e.descripcion AS especialidad,
        (SELECT COUNT(*)
            FROM citas ci
            JOIN consulta c on ci.id_cita = c.id_cita
            WHERE c.estado = 3
            AND c.id_tipo_consulta = 1
            AND ci.cui_medico = m.cui
            AND ci.fecha_hora_inicio BETWEEN '2020-10-01' AND '2020-10-08') AS primeras_consultas,
        (SELECT COUNT(*)
            FROM citas ci
            JOIN consulta c on ci.id_cita = c.id_cita
            WHERE c.estado = 3
            AND c.id_tipo_consulta = 2
            AND ci.cui_medico = m.cui
            AND ci.fecha_hora_inicio BETWEEN '2020-10-01' AND '2020-10-08') AS reconsultas
FROM medicos m
JOIN persona p ON m.cui = p.cui
JOIN especialidad e ON m.id_especialidad = e.id_especialidad;