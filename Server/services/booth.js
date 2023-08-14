const conn = require("../utils/db");
const { getImages, createImage } = require("./image");
const { getLocations, createLocation } = require("./location");

async function getBooths(options) {
    let query = 'SELECT booth_id, name, content, on_time from tb_booth WHERE 1=1';
    let obj = [];

    if(options.location_id) {
        query += ' AND location_id = ?';
        obj.push(options.location_id);
    }

    if(options.booth_id) {
        query += ' AND booth_id = ?';
        obj.push(options.booth_id);
    }    

    const booths = await conn.query(query, obj);
    let res = [];

    for(let booth of booths) {
        booth.locations = [];
        booth.images = [];
        
        const locations = await getLocations({ id: 'booth_id', value: booth.booth_id });
        Object.assign(booth.locations, locations);

        const images = await getImages({ id: 'booth_id', value: booth.booth_id });
        Object.assign(booth.images, images);

        res.push(booth);
    }
    return res;
}

// booth : name, content, on_time, location
async function createBooth(boothInfo, location_id) {
    const { name, content, on_time, location, files } = boothInfo;	

    const booth_id = (await conn.query('INSERT INTO tb_booth(location_id, name, on_time, content) VALUES(?,?,?,?)', [location_id, name, on_time, content])).insertId;
    
    if(files.images) {
        for (let i = 0; i < files.images.length; i++) {
            await createImage({ id: 'booth_id', value: booth_id }, files.images[i].filename, i);
        }
    }

    await createLocation({ id: 'booth_id', value: booth_id }, location);
}

// TODO: Edit
async function editBooth(boothInfo) {    
    const { name, content, on_time, location, images } = boothInfo;	
    
    getBooths()
}
async function deleteBooth() {
    
}

module.exports = {
    getBooths, createBooth, editBooth, deleteBooth
};