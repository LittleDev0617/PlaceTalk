const conn = require("../utils/db");
const { getDistance } = require("../utils/util");
const { getLocations } = require("./location");

async function getPlaces(options) {    
    let query = `SELECT p.*, (
        SELECT COUNT(*)
        FROM tb_join as j 
        WHERE p.place_id = j.place_id
        ) as \`count\` FROM tb_place as p WHERE DATE(end_date) > ?`;
    
	// 기본 날짜 : 오늘
    if(!options.date)
        options.date = '2023-01-01' // TODO: new Date().toISOString().substring(0, 10);

    let obj = [options.date];
        
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

        const locations = await getLocations('place_id', place.place_id);
        let isInDistance = false;

        // 한 장소에 2개 이상 위치가 있을 수 있음. ex) 건대 x 세종대 축제.
        // 반경 dist km 이내에 건대나 세종대 중 하나라도 있다면 표시
        for (let location of locations) {
            place['locations'].push(location);
            if(!options.dist || getDistance(options.lat, options.lon, location.lat, location.lon) <= options.dist * 1000) {
                isInDistance = true;
            }
        }

        if(isInDistance)
            results.push(place);
    }

    return results;
}

// place : placeName, category, state, startDate, endDate, locations
async function createPlace(place) {
    const { placeName, category, state, startDate, endDate, locations } = place;
    let res = await conn.query('INSERT INTO tb_place(name, category, state, start_date, end_date) VALUES(?, ?, ?, ?, ?)', 
				[placeName, category, state, startDate, endDate]);

    const place_id = res.insertId;
                // create board
    await conn.query('INSERT INTO tb_board(place_id) VALUES(?)', place_id);
    
    for (let i = 0; i < locations.length; i++) {
        await conn.query('INSERT INTO tb_location(place_id, loc_name, lat, lon) VALUES(?,?,?,?)', [place_id, locations[i].loc_name, locations[i].lat, locations[i].lon]);
    }
}

async function editPlace() {
    
}
async function deletePlace() {
    
}

module.exports = {
    getPlaces, createPlace, editPlace, deletePlace
};