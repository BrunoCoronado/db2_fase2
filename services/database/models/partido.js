const mongoose = require('mongoose');

const partidoSchema = new mongoose.Schema({
    fecha: { type: String, required: true },
    id_equipo_local: { type: Number, required: true },
    id_equipo_visitante: { type: Number, required: true },
    id_jornada: { type: Number, required: true },
    goles_local: { type: Number, required: true },
    goles_visitante: { type: Number, required: true }
});

const collectionName = 'partido';

const Partido = mongoose.model('Partido', partidoSchema, collectionName);

module.exports = Partido;