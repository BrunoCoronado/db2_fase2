const database = require('../services/database')

/**
 * Obtiene todos los registros de tipo de servicio
 * @returns {recordset} lista con todos los registros
 */

module.exports.catalogoTipoServicio = async function () {
    const result = await database.ejecutarQuery(`SELECT tipo_servicio, nombre FROM rh_tipo_servicio ORDER BY nombre;`);
    return result.recordset;
}

/**
 * Obtiene todos los registros de renglon presupuestario
 * @returns {recordset} lista con todos los registros
 */

module.exports.catalogoRenglonPresupuestario = async function () {
    const result = await database.ejecutarQuery(`SELECT no_renglon, nombre, descripcion FROM rh_renglon_presupuestario ORDER BY no_renglon;`);
    return result.recordset;
}

/**
 * Obtiene todos los registros de puesto
 * @returns {recordset} lista con todos los registros
 */

module.exports.catalogoPuesto = async function (renglon) {
    const result = await database.ejecutarQuery(`SELECT id_puesto, nombre_puesto FROM rh_puesto WHERE renglon = ${renglon} ORDER BY nombre_puesto;`);
    return result.recordset;
}