const express = require('express');
const router = new express.Router();

const consultas = require('../controllers/consultas')

router.route('/consulta1').get(consultas.consulta1)
router.route('/consulta2').get(consultas.consulta2)
router.route('/consulta3').get(consultas.consulta3)
router.route('/consulta4').get(consultas.consulta4)
router.route('/consulta5').get(consultas.consulta5)
router.route('/consulta6').get(consultas.consulta6)
router.route('/consulta7').get(consultas.consulta7)
router.route('/consulta8').get(consultas.consulta8)
router.route('/consulta9').get(consultas.consulta9)
router.route('/consulta10').get(consultas.consulta10)

module.exports = router