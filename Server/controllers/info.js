const conn = require("../utils/db");
const { getImages, createImage } = require("./image");

async function getInfos(options) {
    let query = 'SELECT * FROM tb_info WHERE 1=1';
    let obj = [];

    if(options.place_id) {
        query += ' AND place_id = ?';
        obj.push(options.place_id);
    }

    if(options.info_id) {
        query += ' AND info_id = ?';
        obj.push(options.info_id);
    }    

    if(options.is_schedule) {
        query += ' AND is_schedule = ?';
        obj.push(options.is_schedule);
    }    

    const infos = await conn.query(query, obj);
    
    return infos;
}

// Info : title, content, is_schedule
async function createInfo(infoInfo, place_id) {
    const { title, content } = infoInfo;

    const info_id = (await conn.query('INSERT INTO tb_info(place_id, title, content) VALUES(?, ?, ?, ?)', [place_id, title, content, is_schedule])).insertId;    
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