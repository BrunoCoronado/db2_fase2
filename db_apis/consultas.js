const database = require('../services/database')

const jornadaModel = require('../services/database/models/jornada')
const equipoModel = require('../services/database/models/equipo')
const partidoModel = require('../services/database/models/partido')

/**
 * Consulta 1
 */

module.exports.consulta1 = async function(){
    return []
}

/**
 * Consulta 2
 */

module.exports.consulta2 = async function(){
    return []
}

/**
 * Consulta 3
 */

module.exports.consulta3 = async function(){
    return []
}

/**
 * Consulta 4
 */

module.exports.consulta4 = async function(){
    return []
}

/**
 * Consulta 5
 */

module.exports.consulta5 = async function(){
    return []
}

/**
 * Consulta 6
 */

module.exports.consulta6 = async function(){
    return []
}

/**
 * Consulta 7
 */

module.exports.consulta7 = async function(){
    return []
}

/**
 * Consulta 8
 */

module.exports.consulta8 = async function(){
    return []
}

/**
 * Consulta 9
 */

module.exports.consulta9 = async function(){
    return []
}

/**
 * Consulta 10
 */

module.exports.consulta10 = async function(){

    const data = partidoModel.find({
        "fecha": /.*(1979|1980)-[0-9]+-[0-9]+.*/
    });

    var goles = 0;

    (await data).forEach(dato => {
        goles += dato.goles_local+dato.goles_visitante;
    })

    return goles;

}