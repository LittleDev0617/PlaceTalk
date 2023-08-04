const mysql = require('mysql');
const fs = require('fs');

const conn = mysql.createConnection({
    host: '127.0.0.1',
    port: 3306,
    user: 'root',
    password: fs.readFileSync('./utils/db.config'),
    database: 'PlaceTalk',
});

module.exports = conn;