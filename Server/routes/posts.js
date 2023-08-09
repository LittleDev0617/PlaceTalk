var express = require('express');
var conn = require('../utils/db');
const { auth } = require('../utils/auth');
var router = express.Router();

// place_id 핫플의 여러 게시글 조회
// offset 	   : 시작 페이지
// postPerPage : 페이지 당 게시글 수
// likeOrder   : bool / 좋아요 순 정렬 false -> 시간순 정렬
router.get('/:place_id', auth, (req, res, next) => {    
	const { offset, postPerPage, likeOrder } = req.query;
	const place_id = parseInt(req.params.place_id);

	if(!offset || typeof(offset) !== 'number')
		offset = 0
	
	if(!postPerPage || typeof(postPerPage) !== 'number')
		postPerPage = 10

	if(!likeOrder || typeof(likeOrder) !== 'boolean')
		likeOrder = false;

	conn.query('SELECT * FROM tb_post WHERE place_id = ? ORDER BY ' + (likeOrder ? 'likes' : 'view') + ' DESC LIMIT ?, ?',
				 [place_id, offset * postPerPage, postPerPage], (err, rows) => {
		if(err) 
			console.log(err);
		
		res.json(rows);
	});
});

// 게시글 추가
// place_id : int
// title 	: string
// content  : string
router.post('/:place_id', auth, (req, res, next) => {    
	const { title, content } = req.body;
	const place_id = parseInt(req.params.place_id);

	if(!(typeof(title) === 'string' && typeof(content) === 'string'))
		throw new BadRequestError('Bad data.');
	
	conn.query('INSERT INTO tb_post(user_id, board_id, place_id, create_date, title, content) VALUES(?, ?, ?, NOW(), ?, ?)', 
				[req.user.uid, place_id, place_id, title, content], (err, rows) => {
		if(err)
			console.log(err);
	});
	res.send({ message : "Successful" });
});

// place_id 핫플 게시판의 post_id 게시글 조회
// place_id : int
// post_id  : int
router.get('/:post_id', auth, (req, res, next) => {    
	const place_id = parseInt(req.params.place_id);
	const post_id = parseInt(req.params.post_id);

	if(req.user.level > 2)
		throw new UnauthorizedError('Cannot acces');

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
router.put('/:post_id', auth, (req, res, next) => {	    
	const { title, content } = req.body;
	const place_id = parseInt(req.params.place_id);
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
router.delete('/:post_id', auth, (req, res, next) => {	    
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
	res.send({ message : "Successful" });
});

// 댓글 조회
// post_id  : int
router.get('/:post_id/comments', auth, (req, res, next) => {
	const post_id = parseInt(req.params.post_id);

	conn.query('SELECT * FROM tb_comment WHERE post_id = ? ORDER BY create_time', [post_id], (err, rows) => {		
		for (let index = 0; index < rows.length; index++) {
			if(req.user.uid !== rows[index]['user_id'])
				rows[index]['user_id'] = index + 1;	
			else
				rows[index]['user_id'] = 'self';
		}
	});
	
	conn.query('DELETE FROM tb_post WHERE post_id = ?', [post_id], (err, rows) => {
		if(err)
			console.log(err);
	});
	res.send({ message : "Successful" });
});

// 댓글 추가
// post_id  : int
router.post('/:post_id/comments', auth, (req, res, next) => {
	const post_id = parseInt(req.params.post_id);

	conn.query('DELETE FROM tb_post WHERE AND post_id = ?', [post_id], (err, rows) => {
		if(err)
			console.log(err);
	});
	res.send({ message : "Successful" });
});

// 댓글 삭제
// place_id : int
// post_id  : int
router.delete('/:place_id/:post_id', auth, (req, res, next) => {	    
	const place_id = parseInt(req.params.place_id);
	const post_id = parseInt(req.params.post_id);

	conn.query('SELECT user_id FROM tb_post WHERE place_id = ? AND post_id = ?', [place_id, post_id], (err, rows) => {
		if(!rows.length) {
			throw new BadRequestError('Post does not exist.');
		}
		if(req.user.uid !== rows[0]['user_id']) {
			throw new UnauthorizedError('user_id does not match.');
		}
	});
	
	conn.query('DELETE FROM tb_post WHERE place_id = ? AND post_id = ?', [place_id, post_id], (err, rows) => {
		if(err)
			console.log(err);
	});
	res.send({ message : "Successful" });
});
module.exports = router;