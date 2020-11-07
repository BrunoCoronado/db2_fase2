const catalogo = require('../db_apis/catalogo')
const utils = require('../utils/utils')

module.exports.catalogoTipoServicio = async function (request, response, next) {
    try {
        const rows = await catalogo.catalogoTipoServicio()

        response.status(200).json({
            registros: rows,
            status: 200
        })
        
    } catch (error) {
        console.log(error)
        response = utils.formarResponse(response, 'Error al obtener registros.', 404)
    }
}

module.exports.catalogoRenglonPresupuestario = async function (request, response, next) {
    try {
        const rows = await catalogo.catalogoRenglonPresupuestario()

        response.status(200).json({
            registros: rows,
            status: 200
        })
        
    } catch (error) {
        console.log(error)
        response = utils.formarResponse(response, 'Error al obtener registros.', 404)
    }
}

module.exports.catalogoPuesto = async function (request, response, next) {
    try {
        const rows = await catalogo.catalogoPuesto(request.params.renglon)

        response.status(200).json({
            registros: rows,
            status: 200
        })
        
    } catch (error) {
        console.log(error)
        response = utils.formarResponse(response, 'Error al obtener registros.', 404)
    }
}