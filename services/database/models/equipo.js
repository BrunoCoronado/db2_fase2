const mongoose = require('mongoose');

const equipoSchema = new Schema({
    nombre: { type: String, required: true }
});

const collectionName = 'equipo';

const Equipo = mongoose.model('Equipo', equipoSchema, collectionName);

module.exports = Equipo;