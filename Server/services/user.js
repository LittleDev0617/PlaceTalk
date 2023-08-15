const conn = require("../utils/db");
const { AlreadyJoinError, TooManyJoinError, UnauthorizedError, BadRequestError } = require("../utils/error");
const { getPlaces } = require("./place");
const { errorWrapper, ADMIN_TOKEN } = require("../utils/util");

async function getUsers(user_id) {        
    return await conn.query('SELECT * FROM tb_user WHERE user_id = ?', [user_id]);    
}


async function createUser(user) {
    const { user_id, nickname, email } = user;
    return await conn.query('INSERT INTO tb_user(user_id, nickname, email) VALUES(?,?,?)', [user_id, nickname, email]);
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

async function exitPlace(user_id, place_id) {
    const places = await conn.query('SELECT place_id FROM tb_join WHERE user_id = ? AND place_id = ?', [user_id, place_id]);

    if(places.length == 0)
        throw new BadRequestError('not join');

    await conn.query('DELETE FROM tb_join WHERE user_id = ? AND place_id = ?', [user_id, place_id]);    
}

async function isOrganizerOfPlace(user_id, place_id) {
    const users = await conn.query('SELECT user_id FROM tb_organizer WHERE place_id = ? AND user_id = ?', [place_id, user_id]);    
    return users.length > 0;
}

async function grantAdminRole(user_id, place_id) {
    return await conn.query('INSERT INTO tb_organizer VALUES(?,?)', [place_id, user_id]);
}

async function removeAdminRole(user_id, place_id) {
    return await conn.query('DELETE FROM tb_organizer WHERE user_id = ? AND place_id = ?', [user_id, place_id]);
}

async function getNickname(user_id) {
    return await conn.query('SELECT nickname FROM tb_user WHERE user_id = ?', [user_id]);
}

async function changeNickname(user_id, nickname) {
    return await conn.query('UPDATE tb_user SET nickname = ? WHERE user_id = ?', [nickname, user_id]);
}

const isAdmin = function(user_id) {
    return user_id == ADMIN_TOKEN;
}
module.exports = {
    getUsers, createUser, getUserPlace, joinPlace, isOrganizerOfPlace, grantAdminRole, removeAdminRole, changeNickname, getNickname, exitPlace,
    
    isOrganizer : errorWrapper(async function (req, res, next) {
        let { place_id } = req.params;
        if(!place_id)
            place_id = req.query.place_id;
        if(!place_id)
            place_id = req.body.place_id;
        
        if(!isAdmin() && !(await isOrganizerOfPlace(req.user.uid, place_id)))
            throw new UnauthorizedError('Cannot acces');
        
        next();
    }),
    isAdmin,
    isAdminMW : errorWrapper(async function (req, res, next) {
        if(!isAdmin(req.user.uid))
            throw new UnauthorizedError('Cannot access.');

        next();
    })
};