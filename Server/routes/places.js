var express = require('express');
var conn = require('../utils/db');
const jwt = require('../utils/jwt');
const { auth } = require('../utils/auth');
const { BadRequestError, UnauthorizedError } = require('../utils/error');
var router = express.Router();

// 핫플 모두 조회
router.get('/', (req, res, next) => {	
    const { token } = req.query;
	if(!auth(token, 2))
		throw new UnauthorizedError('Cannot acces');

	// TODO : 쿼리로 startDate, endDate 받아서 일정 기간 내의 핫플만 조회 기능
	conn.query(`SELCET p.*, (
				SELECT COUNT(*) 
				FROM tb_join as j 
				WHERE p.place_id = j.place_id
				) as cnt FROM tb_place as p `, (err, rows) => {
		res.json(rows);
	});
});

// 특정 핫플 조회
// user_id : int
router.get('/:user_id', (req, res, next) => {
    const { token } = req.query;
	const uid = parseInt(req.params.user_id);
	
	if(!auth(token, 2))
		throw new UnauthorizedError('Cannot acces');

	conn.query(`SELCET p.*, (
		SELECT COUNT(*) 
		FROM tb_join as j 
		WHERE p.place_id = j.place_id
		) as cnt FROM tb_place as p WHERE p.place_id = ?`, [uid], (err, rows) => {
		res.json(rows);
	});
});

// TODO : 핫플 검색 기능 - 제목



// 부스 조회
// place_id : int
router.get('/:place_id', (req, res, next) => {
    const { token } = req.query;
	const place_id = parseInt(req.params.place_id);
	
	if(!auth(token, 2))
		throw new UnauthorizedError('Cannot acces');

	conn.query('SELECT * from tb_booth WHERE place_id = ?', [place_id], (err, rows) => {
		res.json(rows);
	});
});

// 부스 등록
// name : string
// content : string
// latitude, longitude : double
router.post('/:place_id', (req, res, next) => {
	const { token, name, content, latitude, longitude } = req.body;

	const place_id = parseInt(req.params.place_id);
	
	if(!auth(token, 1))
		throw new UnauthorizedError('Cannot acces');

	conn.query('SELECT * from tb_booth WHERE place_id = ?', [place_id], (err, rows) => {
		if(!rows.length) {
			conn.query('UPDATE tb_booth SET latitude = ?, longtitude = ?, name = ?, content = ? WHERE place_id = ?', 
						[latitude, longitude, name, content, place_id]);
		}
		else {
			conn.query('INSERT INTO tb_booth(place_id, latitude, longitude, name, content) VALUES(?,?,?,?,?)', 
						[place_id, latitude, longitude, name, content]);
		}
	});
});

// 회원 핫플 참가
// place_id : int
router.post('/join', (req, res, next) => {
	const { user_id, place_id } = req.body;

	if(!(typeof(user_id) === 'number' && typeof(place_id) === 'number'))
		throw new BadRequestError('Bad data.');

	conn.query('SELECT COUNT(*) FROM tb_join WHERE user_id = ?', [user_id], (err, rows) => {
		if(!rows.length)
			res.json({ message : 'Empty' });

		// Check duplicate ?

		if(rows.length < 5) {
			conn.query('INSERT INTO tb_join VALUES(?, ?)', [user_id, place_id], (err, rows) => {
				if(err)
					console.log(err);
				res.json({ message : 'Successful' });
			});
		}
		else
			res.json({ message : 'User cannot join in more than 5 places.'});
	});
});

// 핫플 추가
// placeName : string
// startDate : datetime
// endDate	 : dateTime
// latitude, longitude : double
router.post('/add', (req, res, next) => {
	const { token, placeName, startDate, endDate, latitude, longitude } = req.body;

	if(!auth(token, 1))
		throw new UnauthorizedError('Cannot acces');

	if(!(typeof(placeName) === 'string' && typeof(startDate) == 'string' &&
		typeof(endDate) === 'string' && typeof(latitude) == 'number' && typeof(longitude) === 'number'))
		throw new BadRequestError('Bad data.');
	
	conn.query('INSERT INTO tb_place(name, start_date, end_date, latitude, longitude) VALUES(?, ?, ?, ?, ?)', 
				[placeName, startDate, endDate, latitude, longitude], (err, rows) => {
		if(err)
			console.log(err);
		else {
			conn.query('INSERT INTO tb_board(place_id) VALUES(?)', [place_id]);
		}
	});
	res.send({ message : "Successful" });
});

module.exports = router;