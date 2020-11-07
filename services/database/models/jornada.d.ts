import { Document, Model } from 'mongoose'

interface Jornada extends Document {
    num_jornada: number;
    anio: number;
    inicio_temporada: number;
    fin_temporada: number;
}

declare let jornada: Model<Jornada>;

export = jornada;