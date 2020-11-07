const database = require('../services/database')

const partidoModel = require('../services/database/models/partido')


async function golesYPuntosPorTemporada() {
    const comolocal = await partidoModel.aggregate([
        {
            $group: {
                _id: { temporada: '$temporada', equipo: '$equipo_local' },
                puntos: { $sum: "$puntos_local" },
                goles: { $sum: "$goles_local" }
            },
        },
    ]);

    const comovisitante = await partidoModel.aggregate([
        {
            $group: {
                _id: { temporada: '$temporada', equipo: '$equipo_visitante' },
                puntos: { $sum: "$puntos_visitante" },
                goles: { $sum: "$goles_visitante" }
            },
        },
    ]);

    comovisitante.forEach(data => {
        const index = comolocal.findIndex(local => local._id.temporada == data._id.temporada && local._id.equipo == data._id.equipo);
        comolocal[index].puntos += data.puntos;
        comolocal[index].goles += data.goles;
    })
    return comolocal;
}

async function soloGoles(temporada){
    const data = await partidoModel.find({
        "temporada": temporada
    });
    var goles = 0;
    data.forEach(dato => {
        goles += dato.goles_local+dato.goles_visitante;
    })

    return {temporada: temporada, goles: goles};
}

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
    var datos = [];
    
    datos.push(await soloGoles(197980));
    datos.push(await soloGoles(198081));
    datos.push(await soloGoles(198182));
    datos.push(await soloGoles(198283));
    datos.push(await soloGoles(198384));
    datos.push(await soloGoles(198485));
    datos.push(await soloGoles(198586));
    datos.push(await soloGoles(198687));
    datos.push(await soloGoles(198788));
    datos.push(await soloGoles(198889));
    datos.push(await soloGoles(198990));
    datos.push(await soloGoles(199091));
    datos.push(await soloGoles(199192));
    datos.push(await soloGoles(199293));
    datos.push(await soloGoles(199394));
    datos.push(await soloGoles(199495));
    datos.push(await soloGoles(199596));
    datos.push(await soloGoles(199798));
    datos.push(await soloGoles(199899));
    datos.push(await soloGoles(199900));
    datos.push(await soloGoles(200001));
    datos.push(await soloGoles(200102));
    datos.push(await soloGoles(200203));
    datos.push(await soloGoles(200304));
    datos.push(await soloGoles(200405));
    datos.push(await soloGoles(200506));
    datos.push(await soloGoles(200607));
    datos.push(await soloGoles(200708));
    datos.push(await soloGoles(200809));
    datos.push(await soloGoles(200910));
    datos.push(await soloGoles(201011));
    datos.push(await soloGoles(201112));
    datos.push(await soloGoles(201213));
    datos.push(await soloGoles(201314));
    datos.push(await soloGoles(201415));
    datos.push(await soloGoles(201516));
    datos.push(await soloGoles(201617));
    datos.push(await soloGoles(201718));
    datos.push(await soloGoles(201819));
    datos.push(await soloGoles(201920));
    

    return datos;
}