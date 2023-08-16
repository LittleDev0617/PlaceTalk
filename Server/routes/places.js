var express = require('express');
var conn = require('../utils/db');
const { auth } = require('../utils/auth');
const { BadRequestError, UnauthorizedError } = require('../utils/error');
const { errorWrapper, upload } = require('../utils/util');
const { getPlaces, createPlace, getTop10Places, addTop10Place, removeTop10Place, getSchedule, addSchedule } = require('../controllers/place');
const { joinPlace, isAdminMW, exitPlace } = require('../controllers/user');
var router = express.Router();

// jwt 인증 middleware
router.use(auth);

// 핫플 조회 / 아래 항목들은 모두 옵션
// category : 카테고리
// lat : 내 위도
// lon : 내 경도
// dist : 반경 dist km 이내
router.get('/', async (req, res, next) => {
	const { name, category, lat, lon, dist, user_id } = req.query;
	var date = req.query['date'];
	
	let places = await getPlaces({ name, category, date, lat, lon, dist, user_id });
	// console.log(places)
	res.json(places);
});

router.get('/top10', async (req, res, next) => {	
	const places = await getTop10Places();
	res.json(places);
});

router.post('/top10', async (req, res, next) => {
	const { place_id, order } = req.body;
	await addTop10Place(place_id, order);
	res.json({ message : "Successful" });
});

router.delete('/top10', async (req, res, next) => {
	const { place_id } = req.body;
	await removeTop10Place(place_id);
	res.json({ message : "Successful" });
});

// 핫플 추가		- 오직 어드민만
// placeName : string
// description : string
// state : 0 - 핫플 / 1 - 행사
// startDate : datetime
// endDate	 : dateTime
// locations : List<Location>
router.post('/', isAdminMW, upload.fields(
	[{ name: 'placeName' },
	{ name: 'category' },
	{ name: 'state' },
	{ name: 'startDate' },
	{ name: 'endDate' },
	{ name: 'locations' },
	{ name: 'image' }]), async (req, res, next) => {    
	let { placeName, category, state, startDate, endDate, locations } = req.body;	
	
	locations = JSON.parse(locations);
	console.log(locations)
	if(!(typeof(placeName) === 'string' && typeof(category) === 'string'))
		throw new BadRequestError('Bad data.');
	
	let image;
	if(req.files)
		image = req.files.image[0];

	await createPlace({ placeName, category, state, startDate, endDate, locations, image });

	res.json({ message : "Successful" });
});

// 특정 핫플 조회
// place_id : int
router.get('/:place_id(\\d+)', async (req, res, next) => {    
	const { place_id } = req.params;

	let places = await getPlaces({ date: false, place_id });
	res.json(places);
});


router.get('/:place_id(\\d+)/schedule', async (req, res, next) => {
	var { place_id } = req.params;
	let schedule_image = await getSchedule(place_id);
	res.json(schedule_image);
});

router.post('/:place_id(\\d+)/schedule', upload.single('image'), async (req, res, next) => {
	var { place_id } = req.params;	
	
	let schedule_image = await addSchedule(place_id, req.file ? req.file.filename : 'empty.png');
	res.json({ message: 'Successful' });
});

// 핫플 참가
router.get('/:place_id(\\d+)/join', errorWrapper(async (req, res, next) => {   
	const { place_id } = req.params;
    
	let result = await joinPlace(req.user.uid, place_id);
	res.json([{code:0, message:'asdf'}]);
}));

// 핫플 나가기
router.get('/:place_id(\\d+)/exit', errorWrapper(async (req, res, next) => {   
	const { place_id } = req.params;

    const places = await getPlaces({ user_id: req.user.uid });

    if(places.length == 0)
        throw new BadRequestError('not join');

	let result = await exitPlace(req.user.uid, place_id);
	res.json([]);
}));

module.exports = router;