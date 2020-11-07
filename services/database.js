const {MongoClient} = require('mongodb');
const dbConfig = require('../config/database');

const conexion = new MongoClient(dbConfig.uri)

async function initialize(){
    const result = await conexion.connect();
    databasesList = await conexion.db().admin().listDatabases();
 
    console.log("Databases:");
    databasesList.databases.forEach(db => console.log(` - ${db.name}`));
    console.log("Conexion establecida");
}

async function close(){
    await conexion.close();
}

function obtenerConexion(){
    return this.conexion;
}

module.exports.initialize = initialize;
module.exports.close = close;
module.exports.obtenerConexion = obtenerConexion;