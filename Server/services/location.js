const conn = require("../utils/db");

async function getLocations(filter, find) {    
    return await conn.query(`SELECT location_id, loc_name, lat, lon FROM tb_location WHERE ${filter} = ?`, [find]);    
}

async function createLocation(option, id, loc_name, lat, lon) {
    conn.query(`INSERT INTO tb_location(${option}, loc_name, lat, lon) VALUES(?,?,?,?)`, [id, locations[i].loc_name, locations[i].lat, locations[i].lon]);
}
module.exports = {
    getLocations
};