function formarResponse(response, mensaje, estado){
    response.status(200).json({
        mensaje: mensaje,
        status: estado
    })
    return response;
}

module.exports.formarResponse = formarResponse