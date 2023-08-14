var express = require('express');
var conn = require('../utils/db');
const { auth } = require('../utils/auth');
const { createPost } = require('../services/post');
var router = express.Router();

// jwt 인증 middleware
router.use(auth);

// place_id 핫플의 여러 게시글 조회
// offset 	   : 시작 페이지
// postPerPage : 페이지 당 게시글 수
// likeOrder   : bool / 좋아요 순 정렬 false -> 시간순 정렬
router.get('/:place_id(\\d+)', async (req, res, next) => {    
	const { offset, postPerPage, likeOrder } = req.query;
	const { place_id } = req.params;

	if(!offset || typeof(offset) !== 'number')
		offset = 0
	
	if(!postPerPage || typeof(postPerPage) !== 'number')
		postPerPage = 10

	if(!likeOrder || typeof(likeOrder) !== 'boolean')
		likeOrder = false;

	const posts = await getPosts({ offset, postPerPage, likeOrder, place_id });
	res.json(posts);
});

// 게시글 추가
// place_id : int
// title 	: string
// content  : string
router.post('/:place_id(\\d+)', async (req, res, next) => {    
	const { title, content } = req.body;
	const { place_id } = req.params;

	if(!(typeof(title) === 'string' && typeof(content) === 'string'))
		throw new BadRequestError('Bad data.');
	
	await createPost({ title, content, place_id, user_id: req.user.uid });
	res.send({ message : "Successful" });
});

// place_id 핫플 게시판의 post_id 게시글 조회
// place_id : int
// post_id  : int
router.get('/:post_id(\\d+)', async (req, res, next) => {    
	const post_id = parseInt(req.params.post_id);

	conn.query('SELECT * FROM tb_post WHERE post_id = ?', [post_id], (err, rows) => {
		if(err)
			console.log(err);
		
		res.json(rows);
	});
});

// 게시글 수정
// place_id : int
// post_id  : int
// title : string
// content : string
router.put('/:post_id(\\d+)', async (req, res, next) => {	    
	const { title, content } = req.body;
	const post_id = parseInt(req.params.post_id);

	conn.query('SELECT user_id FROM tb_post WHERE post_id = ?', [post_id], (err, rows) => {
		if(!rows.length) {
			throw new BadRequestError('Post does not exist.');
		}
		if(req.user.uid !== rows[0]['user_id']) {
			throw new UnauthorizedError('user_id does not match.');
		}
	});

	if(!(typeof(title) === 'string' && typeof(content) === 'string'))
		throw new BadRequestError('Bad data.');
	
	conn.query('UPDATE tb_post SET title = ?, content = ? WHERE post_id = ?', [title, content, post_id], (err, rows) => {
		if(err)
			console.log(err);
	});
	res.send({ message : "Successful" });
});

// 게시글 삭제
// post_id  : int
router.delete('/:post_id(\\d+)', async (req, res, next) => {	    
	const post_id = parseInt(req.params.post_id);

	conn.query('SELECT user_id FROM tb_post WHERE post_id = ?', [ post_id ], (err, rows) => {
		if(!rows.length) {
			throw new BadRequestError('Post does not exist.');
		}
		if(req.user.uid !== rows[0]['user_id']) {
			throw new UnauthorizedError('user_id does not match.');
		}
	});
	
	conn.query('DELETE FROM tb_post WHERE AND post_id = ?', [ post_id], (err, rows) => {
		if(err)
			console.log(err);
	});
});

// place_id 핫플 게시판 좋아요 누르기
// post_id  : int
router.get('/:post_id(\\d+)/like', async (req, res, next) => {
	const post_id = parseInt(req.params.post_id);

	// 좋아요 누른 상태인지 확인
	conn.query('SELECT COUNT(*) as count, (SELECT likes FROM tb_post WHERE post_id = ?) as likes FROM tb_likes WHERE post_id = ? AND user_id = ?', [post_id, post_id, req.uesr.uid], (err, rows) => {
		// 누른 상태 -> 좋아요 해제
		if(rows[0].count) {
			conn.query('DELETE FROM tb_likes WHERE post_id = ?', [post_id]);
			conn.query('UPDATE tb_post SET likes = ? WHERE post_id = ?', [rows[0]['likes'] - 1]);
		}
		// 안 누른 상태 -> 좋아요 추가
		else {
			conn.query('INSERT INTO tb_likes VALUES(?, ?)', [post_id, req.user.uid]);
			conn.query('UPDATE tb_post SET likes = ? WHERE post_id = ?', [rows[0]['likes'] + 1]);
		}
	});
	res.send({ message : "Successful" });
});

// 댓글 조회
// post_id  : int
// 게시글 작성자 본인 -> user_id = 0
// 이외 작성자 -> 1, 2, 3 ..
router.get('/:post_id(\\d+)/comments', async (req, res, next) => {
	const post_id = parseInt(req.params.post_id);

	conn.query('SELECT * FROM tb_comment WHERE post_id = ? ORDER BY create_time', [post_id], (err, rows) => {
		conn.query('SELECT user_id FROM tb_post WHERE post_id = ?', [post_id], (err, rows2) => {	
			users = {};
			for (let index = 0; index < rows.length; index++) {
				comment_user_id = rows[index]['user_id'];
				if(rows2[0]['user_id'] !== comment_user_id) {
					if(!users[comment_user_id])
						users[comment_user_id] = index + 1;

					rows[index]['user_id'] = users[comment_user_id];	
				}
				else
					rows[index]['user_id'] = 0;
			}
	
			res.json(rows);
		});
	});
});

// 댓글 추가
// post_id  : int
// is_reply : int - 0 or 1
// reply_id : int - 0 : 대댓 X / 0 제외 자연수 comment_id : comment_id 의 대댓
router.post('/:post_id(\\d+)/comments', async (req, res, next) => {
	const { is_reply, reply_id } = req.body;
	const post_id = parseInt(req.params.post_id);

	conn.query('INSERT INTO tb_comment(post_id, user_id, is_reply, reply_id, create_time) VALUES(?,?,?,?,NOW())',
				 [post_id, req.user.uid, is_reply, reply_id], (err, rows) => {
		if(err)
			console.log(err);
	});
	res.send({ message : "Successful" });
});

// 댓글 삭제	- 본인 or 어드민
// place_id : int
// post_id  : int
router.delete('/:post_id(\\d+)/comments/:comment_id(\\d+)', async (req, res, next) => {	
	const post_id = parseInt(req.params.post_id);
	const comment_id = parseInt(req.params.comment_id);
	
	conn.query('SELECT user_id FROM tb_comment WHERE comment_id = ?', [comment_id], (err, rows) => {		
		// 어드민 or 댓글 작성자 본인이면 삭제
		if(req.user.level == 0 || req.user.uid == rows[0]['user_id']) {
			conn.query('DELETE FROM tb_comment WHERE comment_id = ?', [comment_id], (err, rows) => {
				if(err)
					console.log(err);
			});
		}
	});
	res.send({ message : "Successful" });
});

module.exports = router;