import { Document, Model } from 'mongoose'

interface Partido extends Document {
    fecha: string;
    id_equipo_local: number;
    id_equipo_visitante: number;
    id_jornada: number;
    goles_local: number;
    goles_visitante: number;
}

declare let partido: Model<Partido>;

export = partido;