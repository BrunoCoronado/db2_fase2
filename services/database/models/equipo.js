const { Int32 } = require('mongodb');
const mongoose = require('mongoose');

const equipoSchema = new mongoose.Schema({
    _id: {type: Number, required: true},
    nombre: { type: String, required: true }
});

const collectionName = 'equipo';

const Equipo = mongoose.model('Equipo', equipoSchema, collectionName);

module.exports = Equipo;