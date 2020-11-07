const consultas = require('../db_apis/consultas')

module.exports.consulta1 = async function(request, response, next){
    response.status(200).json();
}

module.exports.consulta2 = async function(request, response, next){
    response.status(200).json(await consultas.consulta2());
}

module.exports.consulta3 = async function(request, response, next){
    response.status(200).json(await consultas.consulta3());
}

module.exports.consulta4 = async function(request, response, next){
    response.status(200).json();
}

module.exports.consulta5 = async function(request, response, next){
    response.status(200).json(await consultas.consulta5());
}

module.exports.consulta6 = async function(request, response, next){
    response.status(200).json(await consultas.consulta6());
}

module.exports.consulta7 = async function(request, response, next){
    response.status(200).json();
}

module.exports.consulta8 = async function(request, response, next){
    response.status(200).json();
}

module.exports.consulta9 = async function(request, response, next){
    response.status(200).json();
}

module.exports.consulta10 = async function(request, response, next){
    response.status(200).json(await consultas.consulta10());
}