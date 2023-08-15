const conn = require("../utils/db");
const { getDistance } = require("../utils/util");
const { getLocations, createLocation } = require("./location");
const { getUsers } = require("./user");

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

    query += ` ORDER BY ${likeOrder ? 'likes' : 'create_date'} DESC LIMIT ?, ?`;
    obj.push(offset * postPerPage);
    obj.push(postPerPage);

    let posts = await conn.query(query, obj);
    console.log(posts);
    const user = await getUsers({ user_id: posts[0].user_id });

    posts[0].user = user[0];
    return posts;
}

// post : content, place_id, user_id
async function createPost(post) {
    const { content, place_id, user_id } = post;
    
    return await conn.query('INSERT INTO tb_post(user_id, place_id, create_date, content) VALUES(?, ?, NOW(), ?)', 
				[user_id, place_id, content]);
}

async function editPost(post) {
    const { content, post_id } = post;
    return await conn.query('UPDATE tb_post SET content = ? WHERE post_id = ?', [content, post_id]);
}

async function deletePost(post_id) {
    return await conn.query('DELETE FROM tb_post WHERE AND post_id = ?', [ post_id ]);
}

async function getPostLikes(post_id) {
    return (await conn.query('SELECT likes FROM tb_post WHERE post_id = ?', [post_id]))[0].likes;
}

async function isPressLike(post_id, user_id) {
    const { count } = (await conn.query('SELECT COUNT(*) as count FROM tb_post_likes WHERE post_id = ? AND user_id = ?', [post_id, user_id]))[0];
    return count > 0;
}

async function pressPostLike(post_id, user_id) {
    const isPressed = await isPressLike(post_id, user_id);    
    const likes = await getPostLikes(post_id);
    console.log(isPressed)
    // 좋아요 누른 상태면
    if(isPressed) {
        await conn.query('DELETE FROM tb_post_likes WHERE post_id = ?', [post_id]);
        await conn.query('UPDATE tb_post SET likes = ? WHERE post_id = ?', [likes - 1, post_id]);
    } else {
        // 안누르면 좋아요 추가
        await conn.query('INSERT INTO tb_post_likes VALUES(?, ?)', [post_id, user_id]);
        await conn.query('UPDATE tb_post SET likes = ? WHERE post_id = ?', [likes + 1, post_id]);
    }
}
module.exports = {
    getPosts, createPost, editPost, deletePost, getPostLikes, pressPostLike
};