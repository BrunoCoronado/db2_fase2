const database = require('../services/database');
const equipoModel = require('../services/database/models/equipo');
const jornadaModel = require('../services/database/models/jornada');
const partidoModel = require('../services/database/models/partido');

/**
 * Consulta 1
 */

module.exports.consulta1 = async function () {
    return []
}

/**
 * Consulta 2
 */

module.exports.consulta2 = async function () {
    return []
}

/**
 * Consulta 3
 */

module.exports.consulta3 = async function () {
    return []
}

/**
 * Consulta 4
 */

module.exports.consulta4 = async function () {
    return []
}


/*
e) Realizar una vista que devuelva las victimas favoritas de un equipo, en otras
palabras, a quien han derrotado más veces.
*/
/*
CREATE OR REPLACE VIEW vista_victimas_favoritas AS

# Debido a que se hizo aparte el analisis de local y visitante, pueden haber mas de una victima favorita, por lo que se toma el que tiene mas derrotas
SELECT E.nombre equipo, V.nombre victima_favorita, MAX(victimas.veces_derrotado) veces_derrotado
FROM (
    # Dado que se hizo aparte el analisis de local y visitante, se suma de nuevo para unir los que son iguales
    SELECT equipo_vencedor, equipo_derrotado, SUM(veces_derrotado) veces_derrotado
    FROM
        (# Se obtiene el equipo visitante al que más ha derrotado un equipo local
        SELECT 	derrotas_por_equipo.equipo_vencedor,
                derrotas_por_equipo.equipo_derrotado,
                MAX(derrotas_por_equipo.veces_derrotado) veces_derrotado
        FROM (
            # Se obtienen cuantas veces un equipo local a derrotado a un equipo visitante
            SELECT equipo_local equipo_vencedor, equipo_visitante equipo_derrotado, COUNT(equipo_visitante) veces_derrotado
            FROM PARTIDO
            WHERE (goles_local - goles_visitante) > 0
            GROUP BY equipo_local, equipo_visitante
            ORDER BY equipo_local, equipo_visitante) derrotas_por_equipo
        GROUP BY derrotas_por_equipo.equipo_vencedor
        UNION ALL
        # Se obtiene el equipo local al que más ha derrotado un equipo visitante
        SELECT 	derrotas_por_equipo.equipo_vencedor,
                derrotas_por_equipo.equipo_derrotado,
                MAX(derrotas_por_equipo.veces_derrotado) veces_derrotado
        FROM (  
            # Se obtienen cuantas veces un equipo visitante a derrotado a un equipo local
            SELECT equipo_visitante equipo_vencedor, equipo_local equipo_derrotado, COUNT(equipo_local) veces_derrotado
            FROM PARTIDO
            WHERE (goles_visitante - goles_local) > 0
            GROUP BY equipo_visitante, equipo_local
            ORDER BY equipo_visitante, equipo_local) derrotas_por_equipo
        GROUP BY derrotas_por_equipo.equipo_vencedor) unionlocalvisit
    GROUP BY equipo_vencedor, equipo_derrotado) victimas
JOIN EQUIPO E ON E.CODIGO = victimas.equipo_vencedor
JOIN EQUIPO V ON V.CODIGO = victimas.equipo_derrotado
GROUP BY victimas.equipo_vencedor
ORDER BY victimas.veces_derrotado DESC;

SELECT * FROM vista_victimas_favoritas;

*/
/**
 * Consulta 5
 */

module.exports.consulta5 = async function () {

    /*
    SELECT 	derrotas_por_equipo.equipo_vencedor,
                derrotas_por_equipo.equipo_derrotado,
                MAX(derrotas_por_equipo.veces_derrotado) veces_derrotado
        FROM (
            # Se obtienen cuantas veces un equipo local a derrotado a un equipo visitante
            SELECT equipo_local equipo_vencedor, equipo_visitante equipo_derrotado, COUNT(equipo_visitante) veces_derrotado
            FROM PARTIDO
            WHERE (goles_local - goles_visitante) > 0
            GROUP BY equipo_local, equipo_visitante
            ORDER BY equipo_local, equipo_visitante) derrotas_por_equipo
        GROUP BY derrotas_por_equipo.equipo_vencedor
    */
    
    const data = partidoModel.aggregate([
        { $match: { $expr: { $gt: [ "$goles_local" , "$goles_visitante" ] } }  },
        {
            $group: {
                _id: { id_equipo_local: '$id_equipo_local', id_equipo_visitante: '$id_equipo_visitante' },
                count: { $sum: 1 }
            },
        },
        {
            $group: {
                _id: { id_equipo_local: '$_id.id_equipo_local' },
                max: { $max: '$count' }
            },
            // id: {visit: '$_id.id_equipo_visitante'}
            // Falta obtener el equipo_visitante.
        }
    ])


    // const data = await partidoModel.find({
    // $where: function () {
    //     return (this.goles_local - this.goles_visitante) > 0
    // },

    // })


    /*
    SELECT equipo_local equipo_vencedor, equipo_visitante equipo_derrotado, COUNT(equipo_visitante) veces_derrotado
            FROM PARTIDO
            WHERE (goles_local - goles_visitante) > 0
            GROUP BY equipo_local, equipo_visitante
            ORDER BY equipo_local, equipo_visitante) derrotas_por_equipo
    */
    /*
SELECT 	derrotas_por_equipo.equipo_vencedor,
                derrotas_por_equipo.equipo_derrotado,
                MAX(derrotas_por_equipo.veces_derrotado) veces_derrotado
        FROM (
            # Se obtienen cuantas veces un equipo local a derrotado a un equipo visitante
            
        GROUP BY derrotas_por_equipo.equipo_vencedor
    */
    return data
}

/**
 * Consulta 6
 */

module.exports.consulta6 = async function () {
    return golesYPuntosPorTemporada()
}

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
/**
 * Consulta 7
 */

module.exports.consulta7 = async function () {
    return []
}

/**
 * Consulta 8
 */

module.exports.consulta8 = async function () {
    return []
}

/**
 * Consulta 9
 */

module.exports.consulta9 = async function () {
    return []
}

/**
 * Consulta 10
 */

module.exports.consulta10 = async function () {
    return []
}