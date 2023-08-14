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

// post : title, content, place_id, user_id
async function createPost(post) {
    const { title, content, place_id, user_id } = post;
    
    return await conn.query('INSERT INTO tb_post(user_id, place_id, create_date, title, content) VALUES(?, ?, ?, NOW(), ?, ?)', 
				[user_id, place_id, title, content]);
}

async function editPost(post) {
    const { title, content, post_id } = post;
    return await conn.query('UPDATE tb_post SET title = ?, content = ? WHERE post_id = ?', [title, content, post_id]);
}

async function deletePost(post_id) {
    return await conn.query('DELETE FROM tb_post WHERE AND post_id = ?', [ post_id ]);
}

async function getPostLikes(post_id) {
    return (await conn.query('SELECT likes FROM tb_post WHERE post_id = ?', [post_id]))[0].likes;
}

async function pressLike(post_id, user_id) {
    
}
module.exports = {
    getPosts, createPost, editPost, deletePost, getPostLikes
};