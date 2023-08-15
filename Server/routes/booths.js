var express = require('express');
var conn = require('../utils/db');
const { auth } = require('../utils/auth');
const { upload, errorWrapper } = require('../utils/util');
const { isAdmin } = require('../services/user');
const { getBooths, createBooth } = require('../services/booth');
var router = express.Router();

// jwt 인증 middleware
router.use(auth);

const getBoothsC = async function (req, res, next) {
	const { booth_id } = req.params; 
    const { location_id } = req.query;
	let booths = await getBooths({ booth_id, location_id });
	res.json(booths);
}

// 부스 조회
// location_id : int
router.get('/', getBoothsC);

router.get('/:booth_id(\\d+)', getBoothsC);

// 부스 등록
// name : string
// content : string
// on_time : string
// location
router.post('/', isAdmin, 
	upload.fields([{ name: 'images', maxCount: 5 }, { name: 'name' }, { name: 'content' }, { name: 'on_time' }, { name: 'location' }]), 
   errorWrapper(async (req, res, next) => {    	
	let { name, content, on_time, location, location_id } = req.body;
	location = JSON.parse(location);

	let result = createBooth({ name, content, on_time, location, files: req.files }, location_id);
	
	res.json({ message : "Successful" });
}));

module.exports = router;