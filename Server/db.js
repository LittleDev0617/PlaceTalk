const mysql = require('mysql');

const conn = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: 'mysql-password',
    database: 'mysql-database',
  });

module.exports = conn;