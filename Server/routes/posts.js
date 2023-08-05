var express = require('express');
var conn = require('../utils/db');
const { auth } = require('../utils/auth');
var router = express.Router();

// place_id 핫플의 여러 게시글 조회
// offset 	   : 시작 페이지
// postPerPage : 페이지 당 게시글 수
// likeOrder   : bool / 좋아요 순 정렬 false -> 시간순 정렬
router.get('/:place_id', (req, res, next) => {
	const { token, offset, postPerPage, likeOrder } = req.query;
	const place_id = parseInt(req.params.place_id);

	if(!auth(token, 2))
		throw new UnauthorizedError('Cannot acces');

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

// place_id 핫플 게시판의 post_id 게시글 조회
// place_id : int
// post_id  : int
router.get('/:place_id/:post_id', (req, res, next) => {
	const { token } = req.query;
	const place_id = parseInt(req.params.place_id);
	const post_id = parseInt(req.params.post_id);

	if(!auth(token, 2))
		throw new UnauthorizedError('Cannot acces');

	conn.query('SELECT * FROM tb_post WHERE place_id = ? AND post_id = ?', [place_id, post_id], (err, rows) => {
		if(err)
			console.log(err);
		
		res.json(rows);
	});
});

// 게시글 추가
// board_id : int
// title 	: string
// content  : string
router.post('/:board_id', (req, res, next) => {
	const { token, title, content } = req.body;
	const board_id = parseInt(req.params.board_id);

	const user = auth(token, 2);
	if(!user)
		throw new UnauthorizedError('Cannot acces');

	if(!(typeof(title) === 'string' && typeof(content) == 'string'))
		throw new BadRequestError('Bad data.');
	
	conn.query('INSERT INTO tb_post(user_id, board_id, place_id, create_date, title, content) VALUES(?, ?, ?, NOW(), ?, ?)', 
				[user.uid, board_id, board_id, title, content], (err, rows) => {
		if(err)
			console.log(err);
	});
	res.send({ message : "Successful" });
});

module.exports = router;