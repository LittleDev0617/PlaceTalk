const { userInfo } = require("os");
const conn = require("../utils/db");
const { AlreadyJoinError, TooManyJoinError, UnauthorizedError } = require("../utils/error");
const { getPlaces } = require("./places");

async function getUsers(user_id) {        
    return await conn.query('SELECT * FROM tb_user WHERE user_id = ?', [user_id]);    
}

async function createUser(user_id) {
    return await conn.query('INSERT INTO tb_user(user_id) VALUES(?)', [user_id]);
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

async function isOrganizerOfPlace(user_id, place_id) {
    const users = await conn.query('SELECT user_id FROM tb_organizer WHERE place_id = ? AND user_id = ?', [place_id, user_id]);
    return users.length > 0;
}

async function grantAdminRole(user_id, place_id) {
    return await conn.query('INSERT INTO tb_organizer VALUES(?,?,"관리자")', [place_id, user_id]);
}

async function removeAdminRole(user_id, place_id) {
    return await conn.query('DELETE FROM tb_organizer WHERE user_id = ? AND place_id = ?', [user_id, place_id]);
}

async function getNickname(user_id, place_id) {
    return await conn.query('SELECT nickname FROM tb_organizer WHERE user_id = ? AND place_id = ?', [user_id, place_id]);
}

async function changeNickname(user_id, place_id, nickname) {
    console.log(nickname)
    return await conn.query('UPDATE tb_organizer SET nickname = ? WHERE user_id = ? AND place_id = ?', [nickname, user_id, place_id]);
}

module.exports = {
    getUsers, createUser, getUserPlace, joinPlace, isOrganizerOfPlace, grantAdminRole, removeAdminRole, changeNickname, getNickname,
    
    isOrganizer : async function (req, res, next) {
        let { place_id } = req.params;
        if(!place_id)
            place_id = req.query.place_id;

        if(req.user.uid != 0 && !(await isOrganizerOfPlace(req.user.uid, place_id)))
            throw new UnauthorizedError('Cannot acces');
        
        next();
    },
    isAdmin : async function (req, res, next) {
        if(req.user.uid != 0)
            throw new UnauthorizedError('Cannot access.');

        next();
    }
};