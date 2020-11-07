const autenticacion = require('../db_apis/autenticacion')
const utils = require('../utils/utils')
const CryptoJS = require('crypto-js');

module.exports.iniciarSesionContratante = async function(request, response, next){
    try {
        const credenciales = {
            usuario: request.body.usuario,
            clave: CryptoJS.SHA1(request.body.clave).toString()
        }

        const rows = await autenticacion.iniciarSesionContratante(credenciales)

        response.status(200).json({
            registros: rows,
            status: 200
        })
        
    } catch (error) {
        console.log(error)
        utils.formarResponse(response, 'Error al iniciar sesión', 404)
    }
}

module.exports.iniciarSesionContratista = async function(request, response, next){
    try {
        const credenciales = {
            cui: request.body.cui,
            clave: CryptoJS.SHA1(request.body.clave).toString()
        }

        const rows = await autenticacion.iniciarSesionContratista(credenciales)

        response.status(200).json({
            registros: rows,
            status: 200
        })
        
    } catch (error) {
        console.log(error)
        utils.formarResponse(response, 'Error al iniciar sesión', 404)
    }
}