var express = require('express');
var conn = require('../utils/db');
const { auth } = require('../utils/auth');
const { isAdminMW } = require('../controllers/user');
const { getInfos, createInfo, editInfo, deleteInfo, getSchedule, addSchedule } = require('../controllers/info');
const { upload } = require('../utils/util');
var router = express.Router();

// jwt 인증 middleware
router.use(auth);

const getInfosC = async function(req, res, next) {
	var { place_id, is_schedule } = req.query;
	const { info_id } = req.params;

	let infos = await getInfos({ place_id, info_id, is_schedule });
	console.log(infos)
	res.json(infos);
}

// 행사/핫플 정보 조회
// place_id : int
router.get('/', getInfosC);

router.get('/:info_id(\\d+)', getInfosC);


// 행사/핫플 정보 추가 - 관리자
// place_id : int
// title : string
// content : string
router.post('/', isAdminMW, async (req, res, next) => {    
	const { title, content, place_id } = req.body;
	var { is_schedule } = req.body;
	
	if(!is_schedule)
		is_schedule = 0;

	await createInfo({ title, content, is_schedule }, place_id);
	res.json({ message: 'Successful' });
});


// 행사/핫플 정보 수정 - 관리자
// place_id : int
router.put('/:info_id(\\d+)', isAdminMW, async (req, res, next) => {    
	const { title, content } = req.body;
	const { info_id } = req.params;
	
	await editInfo({ title, content, info_id });
	res.json({ message: 'Successful' });	
});


// 행사/핫플 정보 삭제 - 관리자
// place_id : int
router.delete('/:info_id(\\d+)', isAdminMW, async (req, res, next) => {    
	const { info_id } = req.params;

	await deleteInfo({ info_id });
	res.json({ message: 'Successful' });
});

module.exports = router;