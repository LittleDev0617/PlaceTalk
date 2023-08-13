const conn = require("../utils/db");

async function getBooths() {
    const booths = await conn.query('SELECT booth_id, name, content, on_time from tb_booth WHERE location_id = ?', [location_id]);

    for(let booth of booths) {
        
    }
}
async function createBooth() {
    
}
async function editBooth() {
    
}
async function deleteBooth() {
    
}

module.exports = {
    getBooths, createBooth, editBooth, deleteBooth
};