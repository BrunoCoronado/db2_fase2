INSERT INTO sexo(id_sexo, descripcion) VALUES(1, 'Masculino');
INSERT INTO sexo(id_sexo, descripcion) VALUES(2, 'Femenino');

INSERT INTO rol(id_rol, descripcion) VALUES(1, 'Administrador');
INSERT INTO rol(id_rol, descripcion) VALUES(2, 'Médico');
INSERT INTO rol(id_rol, descripcion) VALUES(3, 'Paciente');
INSERT INTO rol(id_rol, descripcion) VALUES(4, 'Técnico de Laboratorio');

INSERT INTO accion VALUES(1, 'Ver');
INSERT INTO accion VALUES(2, 'Insertar');
INSERT INTO accion VALUES(3, 'Actualizar');
INSERT INTO accion VALUES(4, 'Eliminar');

INSERT INTO public.menu (id_menu,url,descripcion,grupo,etiqueta,estado) VALUES
(2,'/hospital/administracion/menu','Mantenimiento de los menus/módulos','Administración','Menus',1)
,(3,'/hospital/administracion/permisos','Mantenimiento de los permisos a los usuarios','Administración','Permisos',1)
,(4,'/hospital/paciente/ficha_clinica','Ficha Clínica del paciente','Paciente','Ficha Clínica',1)
,(5,'/hospital/administracion/medicos','Mantenimiento de los médicos','Administración','Médicos',1)
,(1,'/hospital/administracion/pacientes','Mantenimiento de los pacientes','Administración','Pacientes',1)
,(6,'/hospital/paciente/citas','Panel de citas para pacientes','Paciente','Citas',1)
,(7,'/hospital/medico/citas','Panel de citas para médico','Médico','Citas',1)
,(8,'/hospital/configuracion/calendario','Configuración del calendario','Configuración','Calendario',1)
,(9, '/hospital/reportes/consultas', 'Reportes de consultas general', 'Reportes', 'Consultas', 1);
/*INSERT INTO menu VALUES(10, '/hospital/medico/historial_consultas', 'Historial de consultas del Medico', 'Médico', 'Historial Consultas', 1);
INSERT INTO menu VALUES(11, '/hospital/medico/consultas', 'Panel de consultas activas del médico', 'Médico', 'Consultas', 1);
INSERT INTO menu VALUES(12, '/hospital/paciente/historial_consultas', 'Historial de consultas del Paciente', 'Paciente', 'Historial Consultas', 1);
INSERT INTO menu VALUES(13, '/hospital/paciente/consultas', 'Panel de consultas activas del paciente', 'Paciente', 'Consultas', 1);*/
INSERT INTO public.menu (id_menu,url,descripcion,grupo,etiqueta,estado) VALUES (10, '/hospital/medico/consultas/laboratorios', 'Laboratorios pendientes de Resultado', 'Médico', 'Laboratorios Pendientes', 1);
INSERT INTO public.menu (id_menu,url,descripcion,grupo,etiqueta,estado) VALUES (11, '/hospital/paciente/historial-medico', 'Historial médico del Paciente', 'Paciente', 'Historial Médico', 1);
INSERT INTO public.menu (id_menu,url,descripcion,grupo,etiqueta,estado) VALUES (12, '/hospital/administracion/tecnicos','Mantenimiento de los técnicos de laboratorio','Administración','Técnicos de Laboratorio',1);

INSERT INTO public.persona (cui,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,apellido_casada,id_sexo,fecha_nacimiento,telefono,email,estado) VALUES 
(305801459645,'Luisa',NULL,'Benitez',NULL,'Santa Fe',2,'1988-04-06',544654654,'luisa@medicos.com',1)
,(3058018640303,'Luis','Mario','Coti','Mendez',NULL,1,'1996-05-25',58963214,'luis@medico.com   ',1)
,(8596321478596,'Mario','Andres','Carcuz','Solorzano',NULL,1,'1997-01-01',52674952,'carcuz@medicos.com',1)
,(3058018640301,'Bruno','Marco','Coronado','Morales',NULL,1,'1997-11-23',51107613,'bcoronado@gmail.com',1)
,(2311,'paciente','paciente actualizado','paciente','paciente actualizado','casada',2,'1984-11-15',52859632,'paciente.actualizado@mail.com',1)
,(52639874,'prueba',NULL,'prueba',NULL,NULL,1,'2015-12-19',589623,'prueba@gmail.com',1)
,(2563987451532,'Usuario',NULL,'Usuario',NULL,'Usuario',2,'2020-01-01',85963214,'usuario@gmail.com',1)
,(25859674,'paciente_act','paciente_act','paciente_act','paciente_act',NULL,1,'1985-05-13',23578694,'paciente_act@actualizado.com',1)
,(305801459685,'Maria','Antonia','Lopez','Salazar','Juarez',2,'1996-10-15',52639874,'maria@medicos.com',1)
;

INSERT INTO public.accion_rol_menu (id_accion_rol_menu,id_rol,id_accion,id_menu) VALUES 
(46,1,1,1)
,(47,1,4,1)
,(48,1,2,1)
,(49,1,3,1)
,(50,3,3,6)
,(51,3,1,6)
,(52,3,2,6)
,(53,2,1,7)
,(54,2,2,7)
,(55,2,3,7)
,(56,2,4,7)
,(57,1,1,8)
,(58,1,2,8)
,(59,1,3,8)
,(60,1,4,8)
,(5,1,1,2)
,(6,1,2,2)
,(8,1,4,2)
,(9,1,1,3)
,(11,1,3,3)
,(13,3,1,4)
,(20,1,3,2)
,(23,1,4,3)
,(24,1,2,3)
,(25,3,3,4)
,(26,3,2,4)
,(33,1,4,5)
,(37,1,2,5)
,(41,1,1,5)
,(42,1,3,5)
;

INSERT INTO antecedente VALUES(1, 'Diabetes');
INSERT INTO antecedente VALUES(2, 'Hipertensión');
INSERT INTO antecedente VALUES(3, 'Tiroides');
INSERT INTO antecedente VALUES(4, 'Asma');
INSERT INTO antecedente VALUES(5, 'Otros');

INSERT INTO especialidad VALUES(1, 'Anestesiología');
INSERT INTO especialidad VALUES(2, 'Cardiología');
INSERT INTO especialidad VALUES(3, 'Gastroenterología');
INSERT INTO especialidad VALUES(4, 'Endocrinología');
INSERT INTO especialidad VALUES(5, 'Geriatría');
INSERT INTO especialidad VALUES(6, 'Infectología');

INSERT INTO configuracion_calendario VALUES(1, '7:00', '19:00', 30);

INSERT INTO tipo_consulta VALUES(1, 'Primera Cosulta');
INSERT INTO tipo_consulta VALUES(2, 'Reconsulta');

INSERT INTO tipo_pago VALUES(1, 'Desposito');
INSERT INTO tipo_pago VALUES(2, 'Transferencia');

INSERT INTO clasificacion_laboratorio VALUES(1, 'HEMATOLOGIA');
INSERT INTO laboratorio VALUES('HM00', 'Hematología Completa', 1);
INSERT INTO laboratorio VALUES('HM01', 'Recuento de Globulos Blancos', 1);
INSERT INTO laboratorio VALUES('HM02', 'Recuento de Globulos Rojos', 1);
INSERT INTO laboratorio VALUES('HM03', 'Fórmula Leucocitaria', 1);
INSERT INTO laboratorio VALUES('HM04', 'Eritosedimentación', 1);
INSERT INTO laboratorio VALUES('HM05', 'Hemoglobina ', 1);
INSERT INTO laboratorio VALUES('HM06', 'Hematrocrito', 1);
INSERT INTO laboratorio VALUES('HM07', 'Clasificación de Anemia', 1);
INSERT INTO laboratorio VALUES('HM08', 'Frote Perifético', 1);
INSERT INTO laboratorio VALUES('HM09', 'Recuento de Plaquetas', 1);
INSERT INTO laboratorio VALUES('HM10', 'Recuento de Reticulocitos', 1);
INSERT INTO laboratorio VALUES('HM11', 'Recuento de Eosinófilos', 1);
INSERT INTO laboratorio VALUES('HM12', 'Gota Gruesa (hematozoario)', 1);
INSERT INTO laboratorio VALUES('HM13', 'Grupo Sanguineo y RH', 1);
INSERT INTO laboratorio VALUES('HM14', 'Fragilidad Corpuscular', 1);
INSERT INTO laboratorio VALUES('HM15', 'Tiempo de Coagulación y Sangría', 1);
INSERT INTO laboratorio VALUES('HM16', 'Retracción de Coágulo', 1);
INSERT INTO laboratorio VALUES('HM17', 'Tiempo Parcial de Tromboplastina', 1);
INSERT INTO laboratorio VALUES('HM18', 'Tiempo de Protrombina', 1);
INSERT INTO laboratorio VALUES('HM19', 'Fibrinógeno', 1);
INSERT INTO laboratorio VALUES('HM20', 'Investigación Celular L.E.', 1);
INSERT INTO laboratorio VALUES('HM21', 'Recuento y Fórmula', 1);

INSERT INTO clasificacion_laboratorio VALUES(2, 'HECES');
INSERT INTO laboratorio VALUES('HE01', 'Exámen Cmpleto', 2);
INSERT INTO laboratorio VALUES('HE02', 'Exámen en fresco', 2);
INSERT INTO laboratorio VALUES('HE03', 'Sangre Oculta', 2);
INSERT INTO laboratorio VALUES('HE04', 'Enema Salino (CITA)', 2);

INSERT INTO clasificacion_laboratorio VALUES(3, 'ORINA');
INSERT INTO laboratorio VALUES('OR02', 'Exámen Sedimento', 3);
INSERT INTO laboratorio VALUES('OR01', 'Exámen Completo', 3);
INSERT INTO laboratorio VALUES('OR03', 'Exámen Químico de Orina en 24 Hrs. ', 3);
INSERT INTO laboratorio VALUES('OR04', 'Análisis de Cálculo Urinario / 24 Hrs.', 3);
INSERT INTO laboratorio VALUES('OR05', 'Dosificación Glucosa / 24 Hrs', 3);
INSERT INTO laboratorio VALUES('OR06', 'Dosificación de Ácido Úrico / 24 Hrs.', 3);
INSERT INTO laboratorio VALUES('OR07', 'Dosificación de Sodio / 24 Hrs.', 3);
INSERT INTO laboratorio VALUES('OR08', 'Dosificación de Potasio / 24 hrs. ', 3);
INSERT INTO laboratorio VALUES('OR09', 'Dosificación de Calcio / 24 hrs. ', 3);
INSERT INTO laboratorio VALUES('OR10', 'Dosificación de Albúmina / 24 hrs. ', 3);
INSERT INTO laboratorio VALUES('OR11', 'Dosificación de Proteína / 24 hrs. ', 3);
INSERT INTO laboratorio VALUES('OR12', 'Dosificación de Creatinina / 24 hrs. ', 3);

INSERT INTO clasificacion_laboratorio VALUES(4, 'QUÍMICA SANGUÍNEA');
INSERT INTO laboratorio VALUES('QS01', 'Glucosa Ayunas', 4);
INSERT INTO laboratorio VALUES('QS02', 'Glucosa Stat / 2H.P.C', 4);
INSERT INTO laboratorio VALUES('QS03', 'Curva de Tolerancia a la Glucosa', 4);

INSERT INTO clasificacion_laboratorio VALUES(5, 'PRUEBAS RENALES');
INSERT INTO laboratorio VALUES('PR01', 'Urea', 5);
INSERT INTO laboratorio VALUES('PR02', 'Nitrógeno de Urea', 5);
INSERT INTO laboratorio VALUES('PR03', 'Creatinina', 5);
INSERT INTO laboratorio VALUES('PR04', 'Ácido Úrico', 5);
INSERT INTO laboratorio VALUES('PR05', 'Excresión de Fenolsulftaleína', 5);
INSERT INTO laboratorio VALUES('PR06', 'Recuento de ADDIS', 5);
INSERT INTO laboratorio VALUES('PR07', 'Depuración Urea', 5);
INSERT INTO laboratorio VALUES('PR08', 'Depuración de Creatinina', 5);

INSERT INTO clasificacion_laboratorio VALUES(6, 'PRUEBAS HEPÁTICAS');
INSERT INTO laboratorio VALUES('PH01', 'Bilirrubina Total', 6);
INSERT INTO laboratorio VALUES('PH02', 'Bilirrubina Directa', 6);
INSERT INTO laboratorio VALUES('PH03', 'Proteína Total', 6);
INSERT INTO laboratorio VALUES('PH04', 'Relación A/G', 6);
INSERT INTO laboratorio VALUES('PH05', 'Albúmina', 6);
INSERT INTO laboratorio VALUES('PH06', 'Gana Glutamil Transferasa', 6);

INSERT INTO clasificacion_laboratorio VALUES(7, 'ENZIMAS');
INSERT INTO laboratorio VALUES('EZ01', 'Transaminasa Glutámico Oxalacetina', 7);
INSERT INTO laboratorio VALUES('EZ02', 'Transaminasa Glutámico Pirúvica', 7);
INSERT INTO laboratorio VALUES('EZ03', 'Fosfatasa Ácida', 7);
INSERT INTO laboratorio VALUES('EZ04', 'Fosfatasa Alcalina', 7);
INSERT INTO laboratorio VALUES('EZ05', 'DHL', 7);
INSERT INTO laboratorio VALUES('EZ06', 'CK Total CK-MB', 7);
INSERT INTO laboratorio VALUES('EZ07', 'Amilasa', 7);
INSERT INTO laboratorio VALUES('EZ08', 'Lipasa', 7);

INSERT INTO clasificacion_laboratorio VALUES(8, 'ELECTROLITOS');
INSERT INTO laboratorio VALUES('EL01', 'Sodio', 8);
INSERT INTO laboratorio VALUES('EL02', 'Potasio', 8);
INSERT INTO laboratorio VALUES('EL03', 'Cloruros', 8);
INSERT INTO laboratorio VALUES('EL04', 'Calcio', 8);
INSERT INTO laboratorio VALUES('EL05', 'Fosfóro', 8);
INSERT INTO laboratorio VALUES('EL06', 'Reserva Alcalina', 8);
INSERT INTO laboratorio VALUES('EL07', 'Litio', 8);
INSERT INTO laboratorio VALUES('EL08', 'Amonio', 8);

INSERT INTO clasificacion_laboratorio VALUES(9, 'LÍPIDOS');
INSERT INTO laboratorio VALUES('LI01', 'Lípidos Totales', 9);
INSERT INTO laboratorio VALUES('LI02', 'Colesterol Total', 9);
INSERT INTO laboratorio VALUES('LI03', 'Triglicéridos', 9);
INSERT INTO laboratorio VALUES('LI04', 'Fosfolipidos', 9);
INSERT INTO laboratorio VALUES('LI05', 'Fenotipo de lípidos', 9);
INSERT INTO laboratorio VALUES('LI06', 'Electroferesis de lipoproteínas', 9);
INSERT INTO laboratorio VALUES('LI07', 'Colesterol HDL', 9);
INSERT INTO laboratorio VALUES('LI08', 'Colesterol LDL', 9);

INSERT INTO clasificacion_laboratorio VALUES(10, 'BACTERIOLOGÍA');
INSERT INTO laboratorio VALUES('BA08', 'Coprocultivo', 10);
INSERT INTO laboratorio VALUES('BA09', 'Hemocultivo', 10);
INSERT INTO laboratorio VALUES('BA10', 'Orocultivo', 10);
INSERT INTO laboratorio VALUES('BA11', 'Urocultivo', 10);
INSERT INTO laboratorio VALUES('BA12', 'Cultivo de: ', 10);
INSERT INTO laboratorio VALUES('BA13', 'Cultivo Anaerobio de: ', 10);

INSERT INTO clasificacion_laboratorio VALUES(11, 'BACTERIOSCOPÍA');
INSERT INTO laboratorio VALUES('BAC01', 'Esputo', 11);
INSERT INTO laboratorio VALUES('BAC02', 'Exusado Faringeo', 11);
INSERT INTO laboratorio VALUES('BAC03', 'Nasal', 11);
INSERT INTO laboratorio VALUES('BAC04', 'Secretación Uretral', 11);
INSERT INTO laboratorio VALUES('BAC05', 'Secretación Vaginal', 11);
INSERT INTO laboratorio VALUES('BAC06', 'Lesiones', 11);
INSERT INTO laboratorio VALUES('BAC07', 'Secreción Ocular', 11);
INSERT INTO laboratorio VALUES('BAC08', 'Cuerpo de Inclusión ', 11);
INSERT INTO laboratorio VALUES('BAC12', 'BK - Frote', 11);
INSERT INTO laboratorio VALUES('BAC13', 'BK - Cultivo', 11);
INSERT INTO laboratorio VALUES('BAC14', 'Hongos - Directo', 11);
INSERT INTO laboratorio VALUES('BAC15', 'Hongos - Cultivo', 11);
INSERT INTO laboratorio VALUES('BAC16', 'Hongos - Autovacunas', 11);
INSERT INTO laboratorio VALUES('BAC17', 'Hongos - Susceptibilidad Antibiótica', 11);

INSERT INTO clasificacion_laboratorio VALUES(12, 'SEROLOGÍA');
INSERT INTO laboratorio VALUES('SE01', 'Cardiolipina (VDRL)', 12);
INSERT INTO laboratorio VALUES('SE02', 'Dosificación de Anticuerpo RH', 12);
INSERT INTO laboratorio VALUES('SE03', 'Antiestreptolisina O', 12);
INSERT INTO laboratorio VALUES('SE04', 'Factor Reumatoideo', 12);
INSERT INTO laboratorio VALUES('SE05', 'Letex Globulina', 12);
INSERT INTO laboratorio VALUES('SE06', 'Monotest-Paul Bennell', 12);
INSERT INTO laboratorio VALUES('SE07', 'Proteína "C" Reactiva', 12);
INSERT INTO laboratorio VALUES('SE08', 'Pruebas de Compatibilidad', 12);
INSERT INTO laboratorio VALUES('SE09', 'Pruebas de Coombs', 12);
INSERT INTO laboratorio VALUES('SE10', 'Reacción de Widal', 12);
INSERT INTO laboratorio VALUES('SE11', 'Reacción de Wel-Felix', 12);
INSERT INTO laboratorio VALUES('SE12', 'Reacción de Huddleson', 12);
INSERT INTO laboratorio VALUES('SE13', 'Sarameba', 12);

INSERT INTO clasificacion_laboratorio VALUES(13, 'PRUEBAS DE FERTILIDAD');
INSERT INTO laboratorio VALUES('PF01', 'Prueba de Embarazo', 13);
INSERT INTO laboratorio VALUES('PF02', 'Espermograma (Cita) Beta HCG Sangre', 13);

INSERT INTO clasificacion_laboratorio VALUES(14, 'HORMONAS');
INSERT INTO laboratorio VALUES('HO01', '17 Ketosteroides', 14);
INSERT INTO laboratorio VALUES('HO02', '17 Hidroxicorticosteroides', 14);
INSERT INTO laboratorio VALUES('HO03', 'Ácido Vanidil-Mandelico', 14);
INSERT INTO laboratorio VALUES('HO04', 'Prolactina', 14);
INSERT INTO laboratorio VALUES('HO05', 'FSH', 14);
INSERT INTO laboratorio VALUES('HO06', 'Progesterona', 14);
INSERT INTO laboratorio VALUES('HO07', 'LH', 14);
INSERT INTO laboratorio VALUES('HO08', 'TSH', 14);
INSERT INTO laboratorio VALUES('HO09', 'Testosterona', 14);

INSERT INTO clasificacion_laboratorio VALUES(15, 'VARIOS');
INSERT INTO laboratorio VALUES('VA01', 'Antígeno Prostático PSA', 15);
INSERT INTO laboratorio VALUES('VA02', 'H.I.V.', 15);
INSERT INTO laboratorio VALUES('VA03', 'LCR Químico', 15);
INSERT INTO laboratorio VALUES('VA04', 'LCR Citológico', 15);
INSERT INTO laboratorio VALUES('VA05', 'Hemoglobina Glicosilada', 15);
INSERT INTO laboratorio VALUES('VA06', 'T3, T4, Tiroxina Libre', 15);
INSERT INTO laboratorio VALUES('VA07', 'CEA', 15);
INSERT INTO laboratorio VALUES('VA08', 'Citología CX-Vaginal (Papanicolau)', 15);
INSERT INTO laboratorio VALUES('VA09', 'Alfafetoproteína', 15);
INSERT INTO laboratorio VALUES('VA10', 'Cortisol', 15);
INSERT INTO laboratorio VALUES('VA11', 'Torch IgM', 15);
INSERT INTO laboratorio VALUES('VA12', 'Torch IgM', 15);
INSERT INTO laboratorio VALUES('VA13', 'H. Pilory en Sangre', 15);
INSERT INTO laboratorio VALUES('VA14', 'H. Pilory en Heces', 15);
INSERT INTO laboratorio VALUES('OT', 'Otros', 15);

INSERT INTO public.medicos (cui,id_especialidad,fecha_inicio,fecha_fin,estado) VALUES 
(305801459685,6,'2020-07-11',NULL,1)
,(3058018640303,2,'2012-08-25',NULL,1)
,(8596321478596,4,'2020-01-01',NULL,1)
,(3058018640301,1,'2020-07-09',NULL,1)
,(305801459645,5,'2020-07-11',NULL,1)
;INSERT INTO public.usuario (username,cui,contrasenia,estado) VALUES 
('juarez_maria',305801459685,'81dc9bdb52d04dc20036dbd8313ed055',1)
,('luismedico',3058018640303,'81dc9bdb52d04dc20036dbd8313ed055',1)
,('carcuz',8596321478596,'81dc9bdb52d04dc20036dbd8313ed055',1)
,('luisa_med',305801459645,'8a7319dbf6544a7422c9e25452580ea5',1)
,('bruno.coronado',3058018640301,'046ddf96c233a273fd390c3d0b1a9aa4',1)
,('paciente',2311,'81dc9bdb52d04dc20036dbd8313ed055',1)
,('user01',2563987451532,'81dc9bdb52d04dc20036dbd8313ed055',1)
,('paciente_formulario',25859674,'81dc9bdb52d04dc20036dbd8313ed055',1)
,('prueba',52639874,'8b4cf0258846b23e0a8272bee22c38dd',1)
;INSERT INTO public.usuario_rol (username,id_rol) VALUES 
('bruno.coronado',1)
,('bruno.coronado',2)
,('paciente',3)
,('prueba',3)
,('user01',3)
,('luismedico',2)
,('juarez_maria',2)
,('luisa_med',2)
,('carcuz',2)
,('paciente_formulario',3)
;