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

// TODO : 핫플 검색 기능 - 제목



// 부스 조회
// location_id : int
router.get('/:location_id(\\d+)/booth', async (req, res, next) => {    
	const { location_id } = req.params;
	let booths = await getBooths({ location_id });
	res.json(booths);
});

// 부스 등록
// name : string
// content : string
// on_time : string
// location
router.post('/:location_id(\\d+)/booth', isAdmin, 
	upload.fields([{ name: 'images', maxCount: 5 }, { name: 'name' }, { name: 'content' }, { name: 'on_time' }, { name: 'location' }]), async (req, res, next) => {    	
	let { name, content, on_time, location } = req.body;
	const { location_id } = req.params;
	location = JSON.parse(location);

	let result = createBooth({ name, content, on_time, location, files: req.files }, location_id);
	
	res.json({ message : "Successful" });
});

// 회원 핫플 참가
// place_id : int
router.get('/:place_id(\\d+)/join', errorWrapper(async (req, res, next) => {   
	const { place_id } = req.params;

	let result = await joinPlace(req.user.uid, place_id);
	res.json({ message : 'Success' });
}));


const getFeed = async function (req, res, next) {
	let { offset, feedPerPage } = req.query;

	if(!offset || typeof(offset) !== 'number')
		offset = 0
	
	if(!feedPerPage || typeof(feedPerPage) !== 'number')
		feedPerPage = 10

	const place_id = req.params.place_id;

	let feeds = await getFeeds({ place_id , offset, feedPerPage });
	res.json(feeds);
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
router.post('/:place_id(\\d+)/feed', isOrganizer, 
 upload.fields([{ name: 'images', maxCount: 5 }, { name: 'content' }]), async (req, res, next) => {
	const { content } = req.body;
	const { place_id } = req.params;	

	await createFeed({ content, images: req.files.images }, place_id, req.user.uid);
	res.json({ message: 'Successful'});
});


// 핫플 피드 수정 - 관리자
// place_id : int
router.put('/:place_id(\\d+)/feed/:feed_id(\\d+)', isOrganizer, async (req, res, next) => {    
	const { title, content } = req.body;
	const { place_id, feed_id } = req.params;	

	await editFeed({ title, content, feed_id }, place_id);
	res.json({ message: 'Successful'});
});


// 핫플 피드 삭제 - 관리자
// place_id : int
router.delete('/:place_id(\\d+)/feed/:feed_id(\\d+)', isOrganizer, async (req, res, next) => {    	
	const { place_id, feed_id } = req.params;	

	await deleteFeed({ feed_id });
	res.json({ message: 'Successful' });
});


// 행사/핫플 정보 조회
// place_id : int
router.get('/:place_id(\\d+)/info', async (req, res, next) => {    
	const { place_id } = req.params;
	var { is_schedule } = req.query;
	
	if(!is_schedule)
		is_schedule = 0;

	let infos = await getInfos({ place_id, is_schedule });
	res.json(infos);
});

// 행사/핫플 정보 추가 - 관리자
// place_id : int
// title : string
// content : string
router.post('/:place_id(\\d+)/info', isAdmin, async (req, res, next) => {    
	const { title, content } = req.body;
	var { is_schedule } = req.body;
	
	if(!is_schedule)
		is_schedule = 0;

	const { place_id } = req.params;

	await createInfo({ title, content, is_schedule }, place_id);
	res.json({ message: 'Successful' });
});


// 행사/핫플 정보 수정 - 관리자
// place_id : int
router.put('/:place_id(\\d+)/info/:info_id(\\d+)', isAdmin, async (req, res, next) => {    
	const { title, content } = req.body;
	const { place_id, info_id } = req.params;
	
	await editInfo({ title, content, info_id });
	res.json({ message: 'Successful' });	
});


// 행사/핫플 정보 삭제 - 관리자
// place_id : int
router.delete('/:place_id(\\d+)/info/:info_id(\\d+)', isAdmin, async (req, res, next) => {    
	const info_id = parseInt(req.params.info_id);
	const { place_id } = req.params;

	await deleteInfo({ info_id });
	res.json({ message: 'Successful' });
});

module.exports = router;