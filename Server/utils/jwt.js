const jwt = require('jsonwebtoken');
const fs = require('fs');

jwt.secret = fs.readFileSync('./utils/secret');
jwt.options = {
    algorithm : 'HS256',
    expiresIn : '10'
}

module.exports = jwt;