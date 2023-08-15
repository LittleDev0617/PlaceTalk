const conn = require("../utils/db");
const { BadRequestError } = require("../utils/error");
const { getDistance } = require("../utils/util");
const { getImages, createImage } = require("./image");
const { getLocations, createLocation } = require("./location");

async function getPlaces(options) {    
    let query = `SELECT p.*, (
        SELECT COUNT(*)
        FROM tb_join as j 
        WHERE p.place_id = j.place_id
        ) as \`count\` FROM tb_place as p WHERE 1=1`;
    
    let obj = [];

	// date false 설정하면 날짜 무시
    if(options.date != false){
        // 기본 날짜 : 오늘
        if(!options.date)
            options.date = '2023-01-01' // TODO: new Date().toISOString().substring(0, 10);
        
        query += ' AND DATE(end_date) > ?';
        obj.push(options.date);
    }

    if(options.name) {
        query += ' AND name LIKE ?';
        obj.push(`%${options.name}%`);
    }
    
    if(options.place_id) {
        query += ' AND place_id = ?';
        obj.push(options.place_id);
    }

    if(options.top10) {
        query += ' AND top10 = ?';
        obj.push(options.top10);
    }
        
    if(options.category) {
        query += ' AND category = ?';
        obj.push(options.category);
    }

    if(options.user_id) {
        query += ' AND place_id IN (SELECT place_id FROM tb_join WHERE user_id = ?)';
        obj.push(options.user_id);
    }

    let places = await conn.query(query, obj);    

    let results = [];
    for (let place of places) {
        place.locations = [];
        place.images = [];

        const images = await getImages({ id: 'image_id', value: place.image_id });
        Object.assign(place.images, images);

        const locations = await getLocations({ id: 'place_id', value: place.place_id });
        let isInDistance = false;

        Object.assign(place.locations, locations);

        // 한 장소에 2개 이상 위치가 있을 수 있음. ex) 건대 x 세종대 축제.
        // 반경 dist km 이내에 건대나 세종대 중 하나라도 있다면 표시
        for (let location of locations) {
            if(!options.dist || getDistance(options.lat, options.lon, location.lat, location.lon) <= options.dist * 1000) {
                isInDistance = true;
            }
        }

        if(isInDistance)
            results.push(place);
    }

    return results;
}

async function getTop10Places() {
    return await getPlaces({ top10: 1 });
}

async function addTop10Place(place_id) {
    const places = await getPlaces({ place_id });
    
    if(!places.length)
        throw new BadRequestError('Place not exist');

    return await conn.query('UPDATE tb_place SET top10 = 1 WHERE place_id = ?', [place_id]);
}

async function removeTop10Place(place_id) {
    const places = await getPlaces({ place_id });
    
    if(!places.length)
        throw new BadRequestError('Place not exist');

    return await conn.query('UPDATE tb_place SET top10 = 0 WHERE place_id = ?', [place_id]);
}


// place : placeName, category, state, startDate, endDate, locations
async function createPlace(place) {
    const { placeName, category, state, startDate, endDate, locations, image } = place;
    const place_id = (await conn.query('INSERT INTO tb_place(name, category, state, start_date, end_date) VALUES(?, ?, ?, ?, ?)', 
				[placeName, category, state, startDate, endDate])).insertId;

    if(image)
        await createImage({ id: 'place_id', value: place_id }, image.filename, i);

    for (let location of locations) {
        createLocation({ id: 'place_id', value: place_id }, location);
    }
}

async function editPlace() {
    
}
async function deletePlace() {
    
}

module.exports = {
    getPlaces, createPlace, editPlace, deletePlace, getTop10Places, addTop10Place, removeTop10Place
};