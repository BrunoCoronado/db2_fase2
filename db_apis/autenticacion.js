const database = require('../services/database')

/**
 * Busca a un usuario de la base de datos en la tabla usuarios
 * devuelve un objeto que puede contener o no la información
 * del usuario.
 * @param {*} credenciales contiene el usuario y clave para
 * acceder al sistema
 */

module.exports.iniciarSesionContratante = async function(credenciales){
    let query = `
                SELECT u.usuario, ue.uni_codigo, ue.uni_nombre 
                FROM usuario u
                JOIN unidad_ejecutora ue ON u.fk_unidad_ejecutora = ue.pk_unidad_ejecutora
                WHERE u.usuario = '${credenciales.usuario}'
                AND u.clave = '${credenciales.clave}'
                AND u.estado = 'ACT';
                `

    let result = await database.ejecutarQuery(query)

    return result.recordset
}

/**
 * Busca a un usuario de la base de datos en la tabla usuario_contratista
 * devuelve un objeto que puede contener o no la información
 * del usuario.
 * @param {*} credenciales contiene el cui y clave para
 * acceder al sistema
 */

module.exports.iniciarSesionContratista = async function(credenciales){
    let query = `
                SELECT u.cui
                FROM tc_usuario_contratista u
                WHERE u.cui = ${credenciales.cui}
                AND u.contrasenia= '${credenciales.clave}'
                AND u.estado_registro = 1;
                `

    let result = await database.ejecutarQuery(query)

    console.log(query)

    return result.recordset
}