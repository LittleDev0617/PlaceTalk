const conn = require("../utils/db");
const { getImages, createImage } = require("./image");
const { getLocations, createLocation } = require("./location");
const { isOrganizerOfPlace, getNickname } = require("./user");

async function getInfos(options) {
    let query = 'SELECT info_id, title, content FROM tb_info as f WHERE is_schedule = ?';
    let obj = [options.is_schedule];

    if(options.place_id) {
        query += ' AND place_id = ?';
        obj.push(options.place_id);
    }

    if(options.info_id) {
        query += ' AND info_id = ?';
        obj.push(options.info_id);
    }    

    const infos = await conn.query(query, obj);
    
    return infos;
}

// Info : title, content, is_schedule
async function createInfo(infoInfo, place_id) {
    const { title, content, is_schedule } = infoInfo;

    const info_id = (await conn.query('INSERT INTO tb_info(place_id, title, content, is_schedule) VALUES(?, ?, ?, ?)', [place_id, title, content, is_schedule])).insertId;    
}

// TODO: Edit
async function editInfo(infoInfo) {    
    const { title, content, info_id } = infoInfo;
    
    return await conn.query('UPDATE tb_info SET title = ?, content = ? WHERE info_id = ?', [title, content, info_id]);
}

async function deleteInfo(infoInfo) {
    const { info_id } = infoInfo;
    return await conn.query('DELETE FROM tb_info WHERE info_id = ?', [info_id]);
}

module.exports = {
    getInfos, createInfo, editInfo, deleteInfo
};