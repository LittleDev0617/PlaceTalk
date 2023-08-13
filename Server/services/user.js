const { userInfo } = require("os");
const conn = require("../utils/db");
const { AlreadyJoinError, TooManyJoinError } = require("../utils/error");
const { getPlaces } = require("./places");

async function getUsers(user_id) {        
    return await conn.query('SELECT level FROM tb_user WHERE user_id = ?', [user_id]);    
}

async function createUser(user_id) {
    return await conn.query('INSERT INTO tb_user(user_id, level) VALUES(?, ?)', [user_id, 2]);
}

async function getUserPlace(user_id) {
    return await getPlaces({ user_id: user_id });
}

async function joinPlace(user_id, place_id) {
    const places = await conn.query('SELECT place_id FROM tb_join WHERE user_id = ?', [user_id]);

    if(places.length == 5)
        throw new TooManyJoinError();

    for(let place of places) {
        if(place.place_id == place_id)
            throw new AlreadyJoinError();
    }

    return await conn.query('INSERT INTO tb_join VALUES(?, ?)', [user_id, place_id]);
}

module.exports = {
    getUsers, createUser, getUserPlace, joinPlace
};