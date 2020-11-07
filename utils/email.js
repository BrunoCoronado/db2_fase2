// const nodemailer = require("nodemailer");
// const fs = require('fs');
// const path = require('path');

// // create reusable transport method (opens pool of SMTP connections)
// const smtpTransport = nodemailer.createTransport({
//     service: "Gmail",
//     auth: {
//         user: "hospitalprivadolaasuncion@gmail.com",
//         pass: "@suncionZ5"
//     }
// });

// function enviarCorreo(destino, motivo, contenido){
//     const datos = {
//         from: `hospitalprivadolaasuncion@gmail.com`,
//         to: destino,
//         subject: motivo,
//         html: contenido
//     };
//     smtpTransport.sendMail(datos);
// }; 

// module.exports.enviarCorreoCitaAprobada = function(medico, fecha, destino){
//     try {
//         fs.readFile(path.join(__dirname, 'cita_aprobada_mail.html'), 'utf8', function(err, file){
//             if(!err){
//                 const html = file.replace('$medico$', medico).replace('$fecha$', fecha);
//                 enviarCorreo(destino, 'Tu cita ha sido aprobada!', html);
//             }
//         });
//     } catch (error) {
//         console.log(error)
//     }
// }

// module.exports.enviarCorreoRecuperarContrasenia = function(url, destino){
//     try {
//         fs.readFile(path.join(__dirname, 'cambiar_contrasenia_email.html'), 'utf8', function(err, file){
//             if(!err){
//                 const html = file.replace('$url$', url);
//                 enviarCorreo(destino, 'Recuperación de Contraseña', html);
//             }
//         });
//     } catch (error) {
//         console.log(error)
//     }
// }

// module.exports.enviarCorreoCitaProgramada = function(paciente, fecha, destino){
//     try {
//         fs.readFile(path.join(__dirname, 'cita_programada_mail.html'), 'utf8', function(err, file){
//             if(!err){
//                 const html = file.replace('$paciente$', paciente).replace('$fecha$', fecha);
//                 enviarCorreo(destino, 'Se ha programado una cita!', html);
//             }
//         });
//     } catch (error) {
//         console.log(error)
//     }
// }

// module.exports.enviarCorreoCitaRechazada = function(medico, fecha, motivo, destino){
//     try {
//         fs.readFile(path.join(__dirname, 'cita_rechazada_mail.html'), 'utf8', function(err, file){
//             if(!err){
//                 const html = file.replace('$medico$', medico).replace('$fecha$', fecha).replace('$motivo$', motivo);
//                 enviarCorreo(destino, 'Se ha rechazado tu cita!', html);
//             }
//         });
//     } catch (error) {
//         console.log(error)
//     }
// }

// module.exports.enviarCorreoReconsulta = function(medico, fecha, destino){
//     try {
//         fs.readFile(path.join(__dirname, 'reconsulta_mail.html'), 'utf8', function(err, file){
//             if(!err){
//                 const html = file.replace('$medico$', medico).replace('$fecha$', fecha)
//                 enviarCorreo(destino, 'Se ha programado una reconsulta!', html);
//             }
//         });
//     } catch (error) {
//         console.log(error)
//     }
// }

// module.exports.enviarCorreoRecordatorio = function(medico, fecha, destino){
//     try {
//         fs.readFile(path.join(__dirname, 'recoratorio_consulta_mail.html'), 'utf8', function(err, file){
//             if(!err){
//                 const html = file.replace('$medico$', medico).replace('$fecha$', fecha)
//                 enviarCorreo(destino, 'Recordatorio de Consulta!', html);
//             }
//         });
//     } catch (error) {
//         console.log(error)
//     }
// }