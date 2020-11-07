const mongoose = require('mongoose');

const userSchema = new Schema({
    name: { type: String, required: true },
    username: { type: String, required: true },
    email: { type: String, required: true },
    password: { type: String, required: true },
    photo: { type: String, required: false },
    botmode: { type: Boolean, required: true }
});

const collectionName = 'users';

const User = mongoose.model('User', userSchema, collectionName);

module.exports = User;