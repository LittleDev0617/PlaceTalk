const conn = require("../utils/db");
const { getDistance } = require("../utils/util");
const { getLocations, createLocation } = require("./location");

async function getPosts(options) {    
	const { offset, postPerPage, likeOrder } = options;
    let query = `SELECT * FROM tb_post WHERE 1=1`;
    
    let obj = [];
	
    if(options.place_id) {
        query += ' AND place_id = ?';
        obj.push(options.place_id);
    }
        
    if(options.user_id) {
        query += ' AND user_id = ?';
        obj.push(options.user_id);
    }

    query += ` ORDER BY ${options.likeOrder ? 'likes' : 'view'} DESC LIMIT ?, ?`;
    obj.push(offset * postPerPage);
    obj.push(postPerPage);

    const posts = await conn.query(query, obj);

    return posts;
}

// place : placeName, category, state, startDate, endDate, locations
async function createPost(place) {
    const { title, content, place_id, user_id } = req.body;
    
    await conn.query('INSERT INTO tb_post(user_id, place_id, create_date, title, content) VALUES(?, ?, ?, NOW(), ?, ?)', 
				[user_id, place_id, title, content]);
}

async function editPost() {
    
}
async function deletePost() {
    
}

module.exports = {
    getPosts, createPost, editPost, deletePost
};