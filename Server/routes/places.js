var express = require('express');
var conn = require('../utils/db');
const jwt = require('../utils/jwt');
const { auth } = require('../utils/auth');
const { BadRequestError, UnauthorizedError } = require('../utils/error');
const { getDistance, uploadMW } = require('../utils/util');
const { getPlaces, createPlace } = require('../services/places');
const { joinPlace } = require('../services/user');
const { getBooths, createBooth } = require('../services/booth');
var router = express.Router();

// jwt 인증 middleware
router.use(auth);


// 핫플 조회 / 아래 항목들은 모두 옵션
// category : 카테고리
// lat : 내 위도
// lon : 내 경도
// dist : 반경 dist km 이내
router.get('/', async (req, res, next) => {
	const { category, lat, lon, dist } = req.query;
	var date = req.query['date'];
	
	let places = await getPlaces({ category, date, lat, lon, dist });
	// console.log(places)
	res.json(places);
});


// TODO: 핫플 수정		- 오직 어드민만
// placeName : string
// description : string
// state : 0 - 핫플 / 1 - 행사
// startDate : datetime
// endDate	 : dateTime
// locations : List<Location>
// router.put('/', async (req, res, next) => {    
// 	const { placeName, category, state, startDate, endDate, locations } = req.body;
// 	if(req.user.level > 0)
// 		throw new UnauthorizedError('Cannot acces');	

// 	if(!(typeof(placeName) === 'string' && typeof(startDate) == 'string' && typeof(state) === 'number' && typeof(category) === 'string' &&
// 		typeof(endDate) === 'string'))
// 		throw new BadRequestError('Bad data.');
	
// 	conn.query('INSERT INTO tb_place(name, category, state, start_date, end_date) VALUES(?, ?, ?, ?, ?)', 
// 				[placeName, category, state, startDate, endDate], (err, rows) => {
// 		if(err)
// 			console.log(err);
// 		else {
// 			// insert 한 place 의 place_id
// 			conn.query('SELECT LAST_INSERT_ID() as place_id;', (err, rows2) => {
// 				conn.query('INSERT INTO tb_board(place_id) VALUES(?)', rows2[0].place_id);
// 				for (let i = 0; i < locations.length; i++) {									
// 					conn.query('INSERT INTO tb_location(place_id, loc_name, lat, lon) VALUES(?,?,?,?)', [rows2[0].place_id, locations[i].loc_name, locations[i].lat, locations[i].lon]);	
// 				}
// 			});
// 		}
// 	});
// 	res.send({ message : "Successful" });
// });


// 핫플 추가		- 오직 어드민만
// placeName : string
// description : string
// state : 0 - 핫플 / 1 - 행사
// startDate : datetime
// endDate	 : dateTime
// locations : List<Location>
router.post('/', async (req, res, next) => {    
	const { placeName, category, state, startDate, endDate, locations } = req.body;
	if(req.user.level > 0)
		throw new UnauthorizedError('Cannot acces');	

	if(!(typeof(placeName) === 'string' && typeof(state) === 'number' && typeof(category) === 'string'))
		throw new BadRequestError('Bad data.');

	await createPlace({ placeName, category, state, startDate, endDate, locations });

	res.json({ message : "Successful" });
});


// 특정 핫플 조회
// place_id : int
router.get('/:place_id(\\d+)', async (req, res, next) => {    
	const place_id = parseInt(req.params.place_id);

	let places = await getPlaces({ date: false, place_id });
	res.json(places);
});

// TODO : 핫플 검색 기능 - 제목



// 부스 조회
// location_id : int
router.get('/:location_id(\\d+)/booth', async (req, res, next) => {    
	const location_id = parseInt(req.params.location_id);
	let booths = await getBooths({ location_id });
	res.json(booths);
});

// 부스 등록
// name : string
// content : string
// on_time : string
// location
router.post('/:location_id(\\d+)/booth', uploadMW, async (req, res, next) => {    
	const { name, content, on_time, location } = req.body;
	const { lat, lon, loc_name } = location;
	const location_id = parseInt(req.params.location_id);
	
	if(req.user.level > 1)
		throw new UnauthorizedError('Cannot acces');

	if(!(typeof(name) === 'string' && typeof(content) === 'string' && typeof(on_time) == 'string' &&
		typeof(lat) == 'number' && typeof(lon) === 'number'))
		throw new BadRequestError('Bad data.');
	
	let result = createBooth({ name, content, on_time, location, images: req.files }, location_id);
	
	res.json({ message : "Successful" });
});

// 회원 핫플 참가
// place_id : int
router.get('/:place_id(\\d+)/join', async (req, res, next) => {   
	const place_id = parseInt(req.params.place_id);

	let result = await joinPlace(req.user.uid, place_id);
	console.log(res);
	res.json({ message : 'Success' });
});


const getFeed = function (req, res, next) {
	const { offset, feedPerPage } = req.query;

	if(!offset || typeof(offset) !== 'number')
		offset = 0
	
	if(!feedPerPage || typeof(feedPerPage) !== 'number')
		feedPerPage = 10

	const place_id = req.params.place_id;

	conn.query(`SELECT * from tb_feed` + (place_id ? 'WHERE place_id = ' + place_id.toString() : '') + ` \`order\` BY write_time LIMIT ?, ?`, [offset * feedPerPage, feedPerPage], (err, rows) => {	
		for (let i = 0; i < rows.length; i++) {
			rows[i]['images'] = [];
			conn.query('SELECT image_id, `order` FROM tb_image WHERE feed_id = ?', [rows[i]['feed_id']], (e, rows2) => {
				for (let j = 0; j < rows2.length; j++) {
					rows[i]['images'].push(rows2[j]);
				}
				if(i == rows.length - 1)
					res.json(rows);
			});	
		}			
	});
}

// 모든 핫플 피드 조회
// place_id : int
router.get('/feed', getFeed);

// 핫플 피드 조회
// place_id : int
router.get('/:place_id(\\d+)/feed', getFeed);

// 핫플 피드 추가 - 관리자
// place_id : int
// title : string
// content : string
router.post('/:place_id(\\d+)/feed', uploadMW, async (req, res, next) => {    
	const { title, content } = req.body;
	const place_id = parseInt(req.params.place_id);
	
	if(req.user.level > 1)
		throw new UnauthorizedError('Cannot acces');

	conn.query('SELECT user_id FROM tb_organizer WHERE place_id = ?', [place_id], (err, rows) => {
		for (let index = 0; index < rows.length; index++) {
			if(rows[index]['user_id'] == req.user.uid) {
				// 관리자 권한 O
				conn.query('INSERT INTO tb_feed(place_id, title, content, write_time) VALUES(?, ?, ?, NOW())', [place_id, title, content]);
				// 이미지 업로드
				conn.query('SELECT LAST_INSERT_ID() as feed_id', (err, rows2) => {
					for (let i = 0; i < req.files.length; i++) {
						conn.query('INSERT INTO tb_image(image_id, feed_id, `order`) VALUES(?,?,?)',
									[req.files[i].file_name, rows2[0]['feed_id'], i]);
					}
				});
			}			
		}
	});
});


// 핫플 피드 수정 - 관리자
// place_id : int
router.put('/:place_id(\\d+)/feed/:feed_id(\\d+)', async (req, res, next) => {    
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
					res.send({ message : "Successful" });
				});
			}			
		}
	});
});


// 핫플 피드 삭제 - 관리자
// place_id : int
router.delete('/:place_id(\\d+)/feed/:feed_id(\\d+)', async (req, res, next) => {    
	const feed_id = parseInt(req.params.feed_id);
	const place_id = parseInt(req.params.place_id);
	
	if(req.user.level > 1)
		throw new UnauthorizedError('Cannot acces');

	conn.query('SELECT user_id FROM tb_organizer WHERE place_id = ?', [place_id], (err, rows) => {
		for (let index = 0; index < rows.length; index++) {
			if(rows[index]['user_id'] == req.user.uid || req.user.level == 0) {
				// 관리자 권한 O
				conn.query('DELETE FROM tb_feed WHERE feed_id = ?', [feed_id], (err, rows) => {		
					res.send({ message : "Successful" });
				});
			}			
		}
	});
});


// 행사/핫플 정보 조회
// place_id : int
router.get('/:place_id(\\d+)/info', async (req, res, next) => {    
	const place_id = parseInt(req.params.place_id);
	var { is_schedule } = req.query;
	
	if(!is_schedule)
		is_schedule = 0;

	conn.query(`SELECT info_id, title, content FROM tb_info as f WHERE place_id = ? AND is_schedule = ?`, [place_id, is_schedule], (err, rows) => {		
		res.json(rows);
	});
});

// 행사/핫플 정보 추가 - 관리자
// place_id : int
// title : string
// content : string
router.post('/:place_id(\\d+)/info', async (req, res, next) => {    
	const { title, content } = req.body;
	var { is_schedule } = req.body;
	
	if(!is_schedule)
		is_schedule = 0;

	const place_id = parseInt(req.params.place_id);
	
	if(req.user.level > 1)
		throw new UnauthorizedError('Cannot acces');

	conn.query('SELECT user_id FROM tb_organizer WHERE place_id = ?', [place_id], (err, rows) => {
		for (let index = 0; index < rows.length; index++) {
			if(rows[index]['user_id'] == req.user.uid || req.user.level == 0) {
				// 관리자 권한 O
				conn.query('INSERT INTO tb_info(place_id, title, content, is_schedule) VALUES(?, ?, ?, ?)', [place_id, title, content, is_schedule], (err, rows) => {
					res.send({ message : "Successful" });
				});
			}			
		}
	});
});


// 행사/핫플 정보 수정 - 관리자
// place_id : int
router.put('/:place_id(\\d+)/info/:info_id(\\d+)', async (req, res, next) => {    
	const { title, content } = req.body;
	const place_id = parseInt(req.params.place_id);
	const info_id = parseInt(req.params.info_id);
	
	if(req.user.level > 1)
		throw new UnauthorizedError('Cannot acces');

	conn.query('SELECT user_id FROM tb_organizer WHERE place_id = ?', [place_id], (err, rows) => {
		for (let index = 0; index < rows.length; index++) {
			if(rows[index]['user_id'] == req.user.uid || req.user.level == 0) {
				// 관리자 권한 O
				conn.query('UPDATE tb_info SET title = ?, content = ? WHERE info_id = ?', [title, content, info_id], (err, rows) => {		
					res.send({ message : "Successful" });
				});
			}			
		}
	});
});


// 행사/핫플 정보 삭제 - 관리자
// place_id : int
router.delete('/:place_id(\\d+)/info/:info_id(\\d+)', async (req, res, next) => {    
	const info_id = parseInt(req.params.info_id);
	const place_id = parseInt(req.params.place_id);
	
	if(req.user.level > 1)
		throw new UnauthorizedError('Cannot acces');

	conn.query('SELECT user_id FROM tb_organizer WHERE place_id = ?', [place_id], (err, rows) => {
		for (let index = 0; index < rows.length; index++) {
			if(rows[index]['user_id'] == req.user.uid || req.user.level == 0) {
				// 관리자 권한 O
				conn.query('DELETE FROM tb_info WHERE info_id = ?', [info_id], (err, rows) => {		
					res.send({ message : "Successful" });
				});
			}			
		}
	});
});

module.exports = router;