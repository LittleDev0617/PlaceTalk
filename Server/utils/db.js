const mysql = require('mysql2/promise');
const fs = require('fs');

const pool = mysql.createPool({
    host: '127.0.0.1',
    port: 3306,
    user: 'root',
    password: fs.readFileSync('./utils/db.config'),
    database: 'PlaceTalk',
    dateStrings: 'date'
});

const conn = {
    query: async function (query, obj) {        
        const connection = await pool.getConnection();            
        const [results, fields] = await connection.query(query, obj);
        connection.release();
        return results;
    }
};


module.exports = conn;