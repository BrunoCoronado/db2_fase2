const mongoose = require('mongoose');

const partidoSchema = new mongoose.Schema({
    fecha: { type: String, required: true },
    equipo_local: { type: String, required: true },
    equipo_visitante: { type: String, required: true },
    jornada: { type: Number, required: true },
    temporada: { type: Number, required: true },
    goles_local: { type: Number, required: true },
    goles_visitante: { type: Number, required: true },
    puntos_local: { type: Number, required: true },
    puntos_visitante: { type: Number, required: true }
});

const collectionName = 'partido';

const Partido = mongoose.model('Partido', partidoSchema, collectionName);

module.exports = Partido;