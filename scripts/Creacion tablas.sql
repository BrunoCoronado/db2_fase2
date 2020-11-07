
CREATE TABLE public.accion (
	id_accion int4 NOT NULL,
	descripcion varchar(10) NULL,
	CONSTRAINT accion_pk PRIMARY KEY (id_accion)
);

CREATE TABLE public.especialidad (
	id_especialidad int4 NOT NULL,
	descripcion varchar(25) NULL,
	CONSTRAINT especialidad_pk PRIMARY KEY (id_especialidad)
);


CREATE TABLE public.impresion_clinica (
	cie_10 varchar(15) NOT NULL, --cambio de tipo int8 a varchar(15)
	grupo varchar(5) NULL, --cambio de tipo int4 a varchar(5)
	diagnostico varchar(150) NULL, --cambio de tipo int4 a varchar(150)
	especifico varchar(50) NULL, --cambio de tipo int4 a varchar(50)
	descripcion varchar(250) NULL,  --cambio de tipo int4 a varchar(250)
	masculino int4 NULL,
	femenino int4 NULL,
	CONSTRAINT impresion_clinica_pk PRIMARY KEY (cie_10)
);

CREATE TABLE public.clasificacion_laboratorio (
	id_clasificacion_laboratorio int4 NOT NULL,
	descripcion varchar(25) NULL,
	CONSTRAINT clasificacion_laboratorio_pk PRIMARY KEY (id_clasificacion_laboratorio)
);

CREATE TABLE public.laboratorio (
	id_lab varchar(10) NOT NULL,
	descripcion varchar(100) NULL,
	id_clasificacion_laboratorio int4 NOT NULL,
	CONSTRAINT laboratorio_pk PRIMARY KEY (id_lab),
	CONSTRAINT clasificacion_laboratorio_laboratorio_fk FOREIGN KEY(id_clasificacion_laboratorio) REFERENCES clasificacion_laboratorio(id_clasificacion_laboratorio)
);

CREATE TABLE public.menu (
	id_menu int4 NOT NULL,
	url varchar(50) NULL,
	descripcion varchar(50) NULL,
	grupo varchar(25) NULL,
	etiqueta varchar(25) NULL,
	estado int4 NULL,
	CONSTRAINT menu_pk PRIMARY KEY (id_menu)
);

CREATE TABLE public.rol (
	id_rol int4 NOT NULL,
	descripcion varchar(25) NULL,
	CONSTRAINT rol_pk PRIMARY KEY (id_rol)
);

CREATE TABLE public.sexo (
	id_sexo int4 NOT NULL,
	descripcion varchar(10) NULL,
	CONSTRAINT sexo_pk PRIMARY KEY (id_sexo)
);

CREATE TABLE public.tipo_consulta (
	id_tipo_consulta int4 NOT NULL,
	descripcion varchar(15) NULL,
	CONSTRAINT tipo_consulta_pk PRIMARY KEY (id_tipo_consulta)
);

CREATE TABLE public.tipo_pago (
	id int4 NOT NULL,
	descripcion varchar(25) NULL,
	CONSTRAINT tipo_pago_pk PRIMARY KEY (id)
);

CREATE TABLE public.accion_rol_menu (
	id_accion_rol_menu int4 NOT NULL,
	id_rol int4 NULL,
	id_accion int4 NULL,
	id_menu int4 NULL,
	CONSTRAINT accion_rol_menu_pk PRIMARY KEY (id_accion_rol_menu),
	CONSTRAINT fk_accion FOREIGN KEY (id_accion) REFERENCES accion(id_accion) ,
	CONSTRAINT fk_menu FOREIGN KEY (id_menu) REFERENCES menu(id_menu) ,
	CONSTRAINT fk_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol) 
);
CREATE INDEX fki_accion_rol_menu_fk ON public.accion_rol_menu USING btree (id_accion);
CREATE INDEX fki_fk_menu ON public.accion_rol_menu USING btree (id_menu);
CREATE INDEX fki_fk_rol ON public.accion_rol_menu USING btree (id_rol);

CREATE TABLE public.antecedente (
	id_antecedente int4 NOT NULL,
	descripcion varchar(20) NULL,
	CONSTRAINT antecedente_pk PRIMARY KEY (id_antecedente)
);

CREATE TABLE public.persona (
	cui int8 NOT NULL,
	primer_nombre varchar(25) NOT NULL,
	segundo_nombre varchar(25) NULL,
	primer_apellido varchar(25) NOT NULL,
	segundo_apellido varchar(25) NULL,
	apellido_casada varchar(25) NULL,
	id_sexo int4 NOT NULL,
	fecha_nacimiento date NOT NULL,
	telefono int4 NOT NULL,
	email varchar(75) NOT NULL, --aumento a la longitud varchar,
	estado int4 NULL,
	CONSTRAINT persona_pk PRIMARY KEY (cui),
	CONSTRAINT fk_sexo_persona FOREIGN KEY (id_sexo) REFERENCES sexo(id_sexo) 
);
CREATE INDEX fki_fk_sexo_persona ON public.persona USING btree (id_sexo);

CREATE TABLE public.ficha_clinica (
	cui int8 NOT NULL,
	quirurgico varchar(150) NULL,
	traumatico varchar(150) NULL,
	alergias varchar(150) NULL,
	menarquia date NULL,
    fecha_ultima_regla date NULL,
    partos int4 NULL,
    cesareas int4 NULL,
    aborto int4 NULL,
    hijos_vivos int4 NULL,
    hijos_muertos int4 NULL,
    lactancia_materna int4 NULL,
    ablactacion int4 NULL,
    inmunizacion int4 NULL,
	estado int4 NULL,
	CONSTRAINT pk_ficha_clinica PRIMARY KEY (cui),
	CONSTRAINT fk_persona FOREIGN KEY (cui) REFERENCES persona(cui) 
);
CREATE INDEX fki_fk_persona ON public.ficha_clinica USING btree (cui);

CREATE TABLE public.ficha_antecedente (
	cui int8 NOT NULL,
	id_antecedente int4 NOT NULL,
	CONSTRAINT pk_ficha_antecedente PRIMARY KEY (cui, id_antecedente),
	CONSTRAINT fk_antecedente FOREIGN KEY (id_antecedente) REFERENCES antecedente(id_antecedente) ,
	CONSTRAINT fk_ficha_clinica FOREIGN KEY (cui) REFERENCES ficha_clinica(cui) 
);
CREATE INDEX fki_fk_antecedente ON public.ficha_antecedente USING btree (id_antecedente);

CREATE TABLE public.medicos (
	cui int8 NOT NULL,
	id_especialidad int4 NOT NULL,
	fecha_inicio date NOT NULL,
	fecha_fin date NULL,
	--email varchar(25) NOT NULL,
	estado int4 NULL,
	url VARCHAR(250),
	firma VARCHAR(25),
	sello VARCHAR(25),
	CONSTRAINT medicos_pk PRIMARY KEY (cui),
	--CONSTRAINT fk_persona_medico FOREIGN KEY (cui) REFERENCES medicos(cui) 
	CONSTRAINT fk_medico_persona FOREIGN KEY (cui) REFERENCES persona(cui) ,
	CONSTRAINT fk_especialidad FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad) 
);
CREATE INDEX fki_fk_especialidad ON public.medicos USING btree (id_especialidad);

CREATE TABLE public.usuario (
	username varchar(20) NOT NULL,
	cui int8 NOT NULL,
	contrasenia varchar(150) NOT NULL, --aumento a la longitud debido a encriptacion de la contrasenia
	estado int4 NULL,
	CONSTRAINT usuario_pk PRIMARY KEY (username),
	CONSTRAINT fk_usuario_persona FOREIGN KEY (cui) REFERENCES persona(cui) 
	--CONSTRAINT fk_usuario_rol FOREIGN KEY (username) REFERENCES usuario_rol(username)  --deberia ir en la tabla usuario_rol
);
CREATE INDEX fki_fk_usuario_persona ON public.usuario USING btree (cui);

CREATE TABLE public.usuario_rol (
	username varchar NOT NULL,
	id_rol int4 NOT NULL,
	CONSTRAINT usuario_rol_pk PRIMARY KEY (username, id_rol),
	CONSTRAINT fk_usuario_usuario_rol FOREIGN KEY (username) REFERENCES usuario(username) , --agregada
	CONSTRAINT fk_rol_usuario_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol) 
);
CREATE INDEX fki_fk_usuario_rol ON public.usuario_rol USING btree (id_rol);

CREATE TABLE public.citas (
	id_cita int4 NOT NULL,
	motivo VARCHAR(250) NOT NULL,
	fecha_hora_inicio timestamp NOT NULL,
	fecha_hora_fin timestamp NOT NULL,
	cui_medico int8 NOT NULL,
	cui_paciente int8 NOT NULL,
	pago_bandera int4 NOT NULL,
	aprobacion int4 NOT NULL,
	estado int4 NOT NULL,
	reconsulta int NOT NULL,
	motivo_rechazo VARCHAR(250)
	CONSTRAINT citas_pk PRIMARY KEY (id_cita),
	CONSTRAINT fk_ficha_clinica FOREIGN KEY (cui_paciente) REFERENCES ficha_clinica(cui) ,
	CONSTRAINT fk_medico FOREIGN KEY (cui_medico) REFERENCES medicos(cui) 
);
CREATE INDEX fki_fk_ficha_clinica ON public.citas USING btree (cui_paciente);
CREATE INDEX fki_fk_medico ON public.citas USING btree (cui_medico);

CREATE TABLE public.consulta (
	id_consulta int4 NOT NULL,
	id_cita int4 NOT NULL,
	id_tipo_consulta int4 NOT NULL,
	sintomas_generales varchar(150) NULL,
	sistema_respiratorio varchar(150) NULL,
	sistema_cardiovascular varchar(150) NULL,
	sistema_gastronitestinal varchar(150) NULL,
	sistema_genitourinario varchar(150) NULL,
	sistema_neurologico varchar(150) NULL,
	estado int4 NULL,
	CONSTRAINT consulta_pk PRIMARY KEY (id_consulta),
	UNIQUE(id_cita),
	CONSTRAINT fk_citas FOREIGN KEY (id_cita) REFERENCES citas(id_cita) ,
	CONSTRAINT kf_tipo_consulta FOREIGN KEY (id_tipo_consulta) REFERENCES tipo_consulta(id_tipo_consulta) 
);
CREATE INDEX fki_fk_citas ON public.consulta USING btree (id_cita);

CREATE INDEX fki_kf_tipo_consulta ON public.consulta USING btree (id_tipo_consulta);

CREATE TABLE public.configuracion_calendario (
	fines_de_semana int4 NOT NULL,
	hora_inicio time NOT NULL,
	hora_fin time NOT NULL,
	duracion_cita int4 NOT NULL,
	url_pago VARCHAR(250)
);

CREATE TABLE public.consulta_lab (
	id_consulta_lab int4 NOT NULL,
	id_consulta int4 NOT NULL,
	id_lab varchar(10) NOT NULL,
	descripcion_lab VARCHAR(250) NULL,
	fecha_resultado date NULL,
	resultado varchar(250) NULL,
	estado int4 NULL,
	CONSTRAINT consulta_lab_pk PRIMARY KEY (id_consulta_lab),
	CONSTRAINT fk_consulta_lab FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta) ,
	CONSTRAINT fk_laboratorio FOREIGN KEY (id_lab) REFERENCES laboratorio(id_lab) 
);
CREATE INDEX fki_fk_laboratorio ON public.consulta_lab USING btree (id_lab);

CREATE TABLE public.consulta_impresion (
	id_consulta int4 NOT NULL,
	cie_10 varchar(15) NOT NULL,
	estado int4 NULL,
	CONSTRAINT consulta_impresion_pk PRIMARY KEY (id_consulta, cie_10),
	CONSTRAINT fk_consulta_impresion FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta) ,
	CONSTRAINT fk_impresion_clinica FOREIGN KEY (cie_10) REFERENCES impresion_clinica(cie_10) 
);
CREATE INDEX fki_fk_impresion_clinica ON public.consulta_impresion USING btree (cie_10);

CREATE TABLE public.consulta_tratam (
	id_consulta_tratam int4 NOT NULL,
	id_consulta int4 NOT NULL,
	medicamento varchar(150) NOT NULL,
	dosis varchar(150) NOT NULL,
	horario varchar(150) NOT NULL,
	duracion VARCHAR(150) NOT NULL,
	estado int4 NULL,
	CONSTRAINT consulta_tratamiento_pk PRIMARY KEY (id_consulta_tratam),
	CONSTRAINT fk_consulta_tratamiento FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta) 
);
CREATE INDEX fki_fk_consulta_tratamiento ON public.consulta_tratam USING btree (id_consulta);

CREATE TABLE public.pago_consulta (
	id_cita int4 NOT NULL,
	id_tipo_pago int4 NOT NULL,
	monto int4 NOT NULL,
	no_transaccion int8 NOT NULL UNIQUE,
	CONSTRAINT pago_consulta_pk PRIMARY KEY (id_cita),
	CONSTRAINT fk_tipo_pago FOREIGN KEY (id_tipo_pago) REFERENCES tipo_pago(id) ,
	CONSTRAINT fk_pago_cita FOREIGN KEY (id_cita) REFERENCES citas(id_cita) 
);
CREATE INDEX fki_fk_tipo_pago ON public.pago_consulta USING btree (id_tipo_pago);