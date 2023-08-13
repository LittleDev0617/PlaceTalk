const conn = require("../utils/db");

async function getLocations(filter) {    
    return await conn.query(`SELECT location_id, loc_name, lat, lon FROM tb_location WHERE ${filter.id} = ?`, [filter.value]);
}

// location
// loc_name : string
// lat : number
// lon : number
async function createLocation(filter, location) {
    return await conn.query(`INSERT INTO tb_location(${filter.id}, loc_name, lat, lon) VALUES(?,?,?,?)`, [filter.value, location.loc_name, location.lat, location.lon]);
}

module.exports = {
    getLocations, createLocation
};