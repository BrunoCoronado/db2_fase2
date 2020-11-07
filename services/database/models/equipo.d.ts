import { Document, Model } from 'mongoose'

interface Equipo extends Document {
    nombre: string;
}

declare let equipo: Model<Equipo>;

export = equipo;