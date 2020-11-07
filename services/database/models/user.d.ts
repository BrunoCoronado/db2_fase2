import { Document, Model } from 'mongoose'

interface User extends Document {
    title: string;
}

let blog: Model<User>;

export = blog;