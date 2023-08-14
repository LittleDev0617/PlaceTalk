var express = require('express');
var conn = require('../utils/db');
const { auth } = require('../utils/auth');
const { BadRequestError, UnauthorizedError } = require('../utils/error');
const { getDistance, uploadMW, upload, errorWrapper } = require('../utils/util');
const { getPlaces, createPlace } = require('../services/places');
const { joinPlace, isOrganizer, isAdmin } = require('../services/user');
const { getBooths, createBooth } = require('../services/booth');
const { getFeeds, createFeed, editFeed, deleteFeed } = require('../services/feed');
const { getInfos, createInfo, editInfo, deleteInfo } = require('../services/info');
var router = express.Router();

// jwt 인증 middleware
router.use(auth);

// 핫플 조회 / 아래 항목들은 모두 옵션
// category : 카테고리
// lat : 내 위도
// lon : 내 경도
// dist : 반경 dist km 이내
router.get('/', async (req, res, next) => {
	const { name, category, lat, lon, dist } = req.query;
	var date = req.query['date'];
	
	let places = await getPlaces({ name, category, date, lat, lon, dist });
	// console.log(places)
	res.json(places);
});


// 핫플 추가		- 오직 어드민만
// placeName : string
// description : string
// state : 0 - 핫플 / 1 - 행사
// startDate : datetime
// endDate	 : dateTime
// locations : List<Location>
router.post('/', isAdmin, async (req, res, next) => {    
	const { placeName, category, state, startDate, endDate, locations } = req.body;	

	if(!(typeof(placeName) === 'string' && typeof(state) === 'number' && typeof(category) === 'string'))
		throw new BadRequestError('Bad data.');

	await createPlace({ placeName, category, state, startDate, endDate, locations });

	res.json({ message : "Successful" });
});

// 특정 핫플 조회
// place_id : int
router.get('/:place_id(\\d+)', isAdmin, async (req, res, next) => {    
	const { place_id } = req.params;

	let places = await getPlaces({ date: false, place_id });
	res.json(places);
});

// 회원 핫플 참가
// place_id : int
router.get('/:place_id(\\d+)/join', errorWrapper(async (req, res, next) => {   
	const { place_id } = req.params;

	let result = await joinPlace(req.user.uid, place_id);
	res.json({ message : 'Success' });
}));

module.exports = router;