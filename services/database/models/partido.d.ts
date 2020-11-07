import { Document, Model } from 'mongoose'

interface Partido extends Document {
    fecha: string;
    equipo_local: string;
    equipo_visitante: string;
    jornada: number;
    temporada: number;
    goles_local: number;
    goles_visitante: number;
    puntos_local: number;
    puntos_visitante: number;
}

declare let partido: Model<Partido>;

export = partido;