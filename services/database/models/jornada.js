const mongoose = require('mongoose');

const jornadaSchema = new Schema({
    num_jornada: { type: Number, required: true },
    anio: { type: Number, required: true },
    inicio_temporada: { type: Number, required: true },
    fin_temporada: { type: Number, required: true }
});

const collectionName = 'jornada';

const Jornada = mongoose.model('Jornada', jornadaSchema, collectionName);

module.exports = Jornada;