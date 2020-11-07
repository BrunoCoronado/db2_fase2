const mongoose = require('mongoose');
const dburi = require('../../config/database').uri

async function initialize() {
    mongoose.connect(dburi, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    }, (err) => {
        if (err) {
            console.log("No se pudo conectar a la base de datos", err);
        } else {
            console.log("Base de datos conectada");
        }
    });
}

async function close() {
    mongoose.disconnect(() => { console.log('Base de datos desconectada') })
}

module.exports.initialize = initialize;
module.exports.close = close;