const database = require('../services/database');
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

    const data = await partidoModel.aggregate([
        { $match: { $expr: { $gt: ["$goles_local", "$goles_visitante"] } } },
        {
            $group: {
                _id: { id_equipo_local: '$id_equipo_local', id_equipo_visitante: '$id_equipo_visitante' },
                count: { $sum: 1 }
            },
        },
        // {
        //     $group: {
        //         _id: { id_equipo_local: '$_id.id_equipo_local' },
        //         max: { $max: '$count' }
        //     },
        //     // id: {visit: '$_id.id_equipo_visitante'}
        //     // Falta obtener el equipo_visitante.
        // }
    ]);

    /*
    [
    {
        "_id": {
            "id_equipo_local": 22,
            "id_equipo_visitante": 11
        },
        "count": 1
    },
    {
        "_id": {
            "id_equipo_local": 15,
            "id_equipo_visitante": 34
        },
        "count": 14
    },
    {
        "_id": {
            "id_equipo_local": 24,
            "id_equipo_visitante": 45
        },
        "count": 1
    },
]
    */


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

module.exports.consulta6 = async function (equipo) {
    return await posicionDeUnEquipoEnCadaTemporada(equipo);
}

async function posicionDeUnEquipoEnCadaTemporada(equipoBuscado) {
    const temporadas = await partidoModel.aggregate([
        {
            $group: {
                _id: { temporada: '$temporada' },
            }
        },
        {
            $sort: { "_id.temporada": 1 },
        }
    ])

    const posicionesEnCadaTemporada = [];

    for (const temporada of temporadas) {
        const equipos = await posicionCadaEquipoPorTemporada(temporada._id.temporada);
        posicionesEnCadaTemporada.push([
            ...equipos.filter(equipo => equipo.equipo == equipoBuscado)
        ])
    }

    return posicionesEnCadaTemporada;
}

async function posicionCadaEquipoPorTemporada(temporada) {
    const por_temporada = await golesYPuntosPorTemporada();

    const filt = por_temporada.filter(result => result._id.temporada == temporada);

    return filt.sort((a, b) => b.puntos - a.puntos).map((result, index) => ({
        equipo: result._id.equipo,
        temporada: result._id.temporada,
        puntos: result.puntos,
        goles: result.goles,
        posicion: index + 1
    }));
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


async function golesYPuntosPorJornada(temporada) {
    const comolocal = await partidoModel.aggregate([
        {
            $match: { temporada: temporada }
        },
        {
            $group: {
                _id: { jornada: '$jornada', equipo: '$equipo_local' },
                puntos: { $sum: "$puntos_local" },
                goles: { $sum: "$goles_local" }
            },
        },
    ]);

    const comovisitante = await partidoModel.aggregate([
        {
            $match: { temporada: temporada }
        },
        {
            $group: {
                _id: { jornada: '$jornada', equipo: '$equipo_visitante' },
                puntos: { $sum: "$puntos_visitante" },
                goles: { $sum: "$goles_visitante" }
            },
        },
    ]);

    comovisitante.forEach(data => {
        const index = comolocal.findIndex(local => local._id.jornada == data._id.jornada && local._id.equipo == data._id.equipo);
        if (index > -1) {
            comolocal[index].puntos += data.puntos;
            comolocal[index].goles += data.goles;
        } else {
            comolocal.push({ ...data });
        }
    })
    return comolocal;
}

async function primerosLugaresPorTemporada(temporada) {
    const por_jornada = await golesYPuntosPorJornada(temporada);

    const filt = por_jornada.filter(result => result._id.jornada == 1);
    const ordenMayorAMenor = filt.sort((a, b) => b.puntos - a.puntos);
    const punteoMasAlto = ordenMayorAMenor[0].puntos;
    return ordenMayorAMenor.filter(result => result.puntos == punteoMasAlto).map((result) => ({
        equipo: result._id.equipo,
        jornada: result._id.jornada,
        puntos: result.puntos,
        goles: result.goles,
        temporada
    }));
}

async function ultimosLugaresPorTemporada(temporada) {
    const por_jornada = await golesYPuntosPorJornada(temporada);

    const filt = por_jornada.filter(result => result._id.jornada == 1);
    const ordenMayorAMenor = filt.sort((a, b) => a.puntos - b.puntos);
    const punteoMasBajo = ordenMayorAMenor[0].puntos;
    return ordenMayorAMenor.filter(result => result.puntos == punteoMasBajo).map((result) => ({
        equipo: result._id.equipo,
        jornada: result._id.jornada,
        puntos: result.puntos,
        goles: result.goles,
        temporada
    }));
}
/**
 * Consulta 7
 */

module.exports.consulta7 = async function (temporada) {
    const result = await posicionCadaEquipoPorJornada(temporada);
    return result
}

/**
 * Consulta 8
 */

module.exports.consulta8 = async function (temporada) {
    const result = await ultimosLugaresPorTemporada(temporada);
    return result
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