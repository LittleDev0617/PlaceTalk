var express = require('express');
var conn = require('../utils/db');
const { auth } = require('../utils/auth');
const { upload } = require('../utils/util');
const { isAdmin } = require('../services/user');
const { getBooths, createBooth } = require('../services/booth');
var router = express.Router();

// jwt 인증 middleware
router.use(auth);

// 부스 조회
// location_id : int
router.get('/', async (req, res, next) => {    
	let booths = await getBooths();
	res.json(booths);
});

router.get('/:location_id(\\d+)', async (req, res, next) => {    
	const { location_id } = req.params;
	let booths = await getBooths({ location_id });
	res.json(booths);
});

// 부스 등록
// name : string
// content : string
// on_time : string
// location
router.post('/', isAdmin, 
	upload.fields([{ name: 'images', maxCount: 5 }, { name: 'name' }, { name: 'content' }, { name: 'on_time' }, { name: 'location' }]), async (req, res, next) => {    	
	let { name, content, on_time, location, location_id } = req.body;
	location = JSON.parse(location);

	let result = createBooth({ name, content, on_time, location, files: req.files }, location_id);
	
	res.json({ message : "Successful" });
});

module.exports = router;