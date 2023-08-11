var express = require('express');
var conn = require('../utils/db');
const jwt = require('../utils/jwt');
const { auth } = require('../utils/auth');
const { BadRequestError, UnauthorizedError } = require('../utils/error');
var router = express.Router();

// jwt 인증 middleware
router.use(auth);

// 핫플 모두 조회
router.get('/', (req, res, next) => {
	if(req.user.level > 2)
		throw new UnauthorizedError('Cannot acces');

	// TODO : 쿼리로 startDate, endDate 받아서 일정 기간 내의 핫플만 조회 기능
	conn.query(`SELECT p.*, (
				SELECT COUNT(*) 
				FROM tb_join as j 
				WHERE p.place_id = j.place_id
				) as \`count\` FROM tb_place as p `, (err, rows) => {
		res.json(rows);
	});
});

// 핫플 추가		- 오직 어드민만
// placeName : string
// description : string
// state : 0 or 1
// startDate : datetime
// endDate	 : dateTime
// latitude, longitude : double
router.post('/', (req, res, next) => {    
	const { placeName, description, state, startDate, endDate, latitude, longitude } = req.body;
	if(req.user.level > 0)
		throw new UnauthorizedError('Cannot acces');	

	if(!(typeof(placeName) === 'string' && typeof(startDate) == 'string' && typeof(state) === 'number' && typeof(description) === 'string' &&
		typeof(endDate) === 'string' && typeof(latitude) == 'number' && typeof(longitude) === 'number'))
		throw new BadRequestError('Bad data.');
	
	conn.query('INSERT INTO tb_place(name, description, state, start_date, end_date, latitude, longitude) VALUES(?, ?, ?, ?, ?, ?, ?)', 
				[placeName, description, state, startDate, endDate, latitude, longitude], (err, rows) => {
		if(err)
			console.log(err);
		else {
			conn.query('INSERT INTO tb_board(place_id) VALUES(1)');
		}
	});
	res.send({ message : "Successful" });
});


// 특정 핫플 조회
// place_id : int
router.get('/:place_id(\\d+)', (req, res, next) => {    
	const pid = parseInt(req.params.place_id);
	
	if(req.user.level > 2)
		throw new UnauthorizedError('Cannot acces');

	conn.query(`SELECT p.*, (
		SELECT COUNT(*) 
		FROM tb_join as j 
		WHERE p.place_id = j.place_id
		) as \`count\` FROM tb_place as p WHERE p.place_id = ?`, [pid], (err, rows) => {
		res.json(rows);
	});
});

// TODO : 핫플 검색 기능 - 제목



// 부스 조회
// place_id : int
router.get('/:place_id(\\d+)/booth', (req, res, next) => {    
	const place_id = parseInt(req.params.place_id);
	
	if(req.user.level > 2)
		throw new UnauthorizedError('Cannot acces');

	conn.query('SELECT * from tb_booth WHERE place_id = ?', [place_id], (err, rows) => {
		res.json(rows);
	});
});

// 부스 등록
// name : string
// content : string
// detail  : string  - 근처 위치 설명 ex) XX대 앞
// latitude, longitude : double
router.post('/:place_id(\\d+)/booth', (req, res, next) => {    
	const { name, content, detail, latitude, longitude } = req.body;

	const place_id = parseInt(req.params.place_id);
	
	if(req.user.level > 1)
		throw new UnauthorizedError('Cannot acces');

	if(!(typeof(name) === 'string' && typeof(content) == 'string' &&
		typeof(detail) === 'string' && typeof(latitude) == 'number' && typeof(longitude) === 'number'))
		throw new BadRequestError('Bad data.');
	
	conn.query('SELECT * from tb_booth WHERE place_id = ?', [place_id], (err, rows) => {
		if(!rows.length) {
			conn.query('UPDATE tb_booth SET latitude = ?, longtitude = ?, name = ?, content = ?, detail = ? WHERE place_id = ?', 
						[latitude, longitude, name, content, detail, place_id]);
		}
		else {
			conn.query('INSERT INTO tb_booth(place_id, latitude, longitude, name, content, detail) VALUES(?,?,?,?,?,?)', 
						[place_id, latitude, longitude, name, content, detail]);
		}
	});
});

// 회원 핫플 참가
// place_id : int
router.post('/:place_id(\\d+)/join', (req, res, next) => {   

	const place_id = parseInt(req.params.place_id);

	if(req.user.level > 2)
		throw new UnauthorizedError('Cannot acces');

	if(!(typeof(user_id) === 'number' && typeof(place_id) === 'number'))
		throw new BadRequestError('Bad data.');

	conn.query('SELECT COUNT(*) FROM tb_join WHERE user_id = ?', [req.user.uid], (err, rows) => {
		if(!rows.length)
			res.json({ message : 'Empty' });

		// Check duplicate ?

		if(rows.length < 5) {
			conn.query('INSERT INTO tb_join VALUES(?, ?)', [req.user.uid, place_id], (err, rows) => {
				if(err)
					console.log(err);
				res.json({ message : 'Successful' });
			});
		}
		else
			res.json({ message : 'User cannot join in more than 5 places.'});
	});
});

// 모든 핫플 피드 조회
// place_id : int
router.get('/feed', (req, res, next) => {    
	if(req.user.level > 2)
		throw new UnauthorizedError('Cannot acces');

	conn.query(`SELECT f.*, (
						SELECT image_id FROM tb_image as i WHERE i.feed_id = f.feed_id
					) as image_id from tb_feed as f`, (err, rows) => {		
		res.json(rows);
	});
});

// 핫플 피드 조회
// place_id : int
router.get('/:place_id(\\d+)/feed', (req, res, next) => {    
	const place_id = parseInt(req.params.place_id);
	
	if(req.user.level > 2)
		throw new UnauthorizedError('Cannot acces');

	conn.query(`SELECT f.*, (
						SELECT image_id FROM tb_image as i WHERE i.feed_id = f.feed_id
					) as image_id from tb_feed as f WHERE place_id = ?`, [place_id], (err, rows) => {		
		res.json(rows);
	});
});

// 핫플 피드 추가 - 관리자		TODO : 이미지 업로드
// place_id : int
// title : string
// content : string
router.post('/:place_id(\\d+)/feed', (req, res, next) => {    
	const { title, content } = req.body;
	const place_id = parseInt(req.params.place_id);
	
	if(req.user.level > 1)
		throw new UnauthorizedError('Cannot acces');

	conn.query('SELECT user_id FROM tb_organizer WHERE place_id = ?', [place_id], (err, rows) => {
		for (let index = 0; index < rows.length; index++) {
			if(rows[index]['user_id'] == req.user.uid) {
				// 관리자 권한 O
				conn.query('INSERT INTO tb_feed(place_id, title, content) VALUES(?, ?, ?)', [place_id, title, content], (err, rows) => {		
					res.json(rows);
				});
			}			
		}
	});
});


// 핫플 피드 수정 - 관리자		TODO : 이미지 업로드
// place_id : int
router.put('/:place_id(\\d+)/feed/:feed_id(\\d+)', (req, res, next) => {    
	const { title, content } = req.body;
	const place_id = parseInt(req.params.place_id);
	const feed_id = parseInt(req.params.feed_id);
	
	if(req.user.level > 1)
		throw new UnauthorizedError('Cannot acces');

	conn.query('SELECT user_id FROM tb_organizer WHERE place_id = ?', [place_id], (err, rows) => {
		for (let index = 0; index < rows.length; index++) {
			if(rows[index]['user_id'] == req.user.uid) {
				// 관리자 권한 O
				conn.query('UPDATE tb_feed SET title = ?, content = ? WHERE feed_id = ?', [title, content, feed_id], (err, rows) => {		
					res.json(rows);
				});
			}			
		}
	});
});


// 핫플 피드 삭제 - 관리자		TODO : 이미지 업로드
// place_id : int
router.delete('/:place_id(\\d+)/feed/:feed_id(\\d+)', (req, res, next) => {    
	const feed_id = parseInt(req.params.feed_id);
	const place_id = parseInt(req.params.place_id);
	
	if(req.user.level > 1)
		throw new UnauthorizedError('Cannot acces');

	conn.query('SELECT user_id FROM tb_organizer WHERE place_id = ?', [place_id], (err, rows) => {
		for (let index = 0; index < rows.length; index++) {
			if(rows[index]['user_id'] == req.user.uid) {
				// 관리자 권한 O
				conn.query('DELETE FROM tb_feed WHERE feed_id = ?', [feed_id], (err, rows) => {		
					res.json(rows);
				});
			}			
		}
	});
});


module.exports = router;