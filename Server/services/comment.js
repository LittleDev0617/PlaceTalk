const conn = require("../utils/db");
const { getDistance } = require("../utils/util");
const { getLocations, createLocation } = require("./location");

async function getComments(options) {
	const { offset, commentsPerPage, likeOrder } = options;
    let query = `SELECT * FROM tb_comment WHERE 1=1`;
    let obj = [];
	
    if(options.post_id) {
        query += ' AND post_id = ?';
        obj.push(options.post_id);
    }
        
    if(options.user_id) {
        query += ' AND user_id = ?';
        obj.push(options.user_id);
    }

    query += ` ORDER BY ${likeOrder ? 'likes' : 'create_time'} LIMIT ?, ?`;
    obj.push(offset * commentsPerPage);
    obj.push(commentsPerPage);

    const posts = await conn.query(query, obj);

    return posts;
}

async function createComment(comment) {
    const { post_id, content, is_reply, user_id, reply_id } = comment;
    
    return await conn.query('INSERT INTO tb_comment(post_id, user_id, is_reply, reply_id, content, create_time) VALUES(?,?,?,?,?,NOW())',
                [post_id, user_id, is_reply, reply_id, content]);
}

async function deleteComment(comment_id) {
    return await conn.query('DELETE FROM tb_comment WHERE comment_id = ?', [comment_id]);
}

async function getCommentLikes(comment_id) {
    return (await conn.query('SELECT likes FROM tb_comment WHERE comment_id = ?', [comment_id]))[0].likes;
}

async function isPressLike(comment_id, user_id) {
    const { count } = (await conn.query('SELECT COUNT(*) as count FROM tb_comment_likes WHERE comment_id = ? AND user_id = ?', [comment_id, user_id]))[0];
    return count > 0;
}

async function pressCommentLike(comment_id, user_id) {
    const isPressed = await isPressLike(comment_id, user_id);    
    const { likes } = await getCommentLikes(comment_id);
    // 좋아요 누른 상태면
    if(isPressed) {
        await conn.query('DELETE FROM tb_comment_likes WHERE comment_id = ?', [comment_id]);
        await conn.query('UPDATE tb_comment SET likes = ? WHERE comment_id = ?', [likes - 1]);
    } else {
        // 안누르면 좋아요 추가
        await conn.query('INSERT INTO tb_comment_likes VALUES(?, ?)', [comment_id, user_id]);
        await conn.query('UPDATE tb_comment SET likes = ? WHERE comment_id = ?', [likes + 1]);
    }
}

module.exports = {
    getComments, createComment, getCommentLikes, pressCommentLike, deleteComment
};