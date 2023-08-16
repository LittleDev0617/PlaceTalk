var express = require('express');
var conn = require('../utils/db');
const { auth } = require('../utils/auth');
const { upload } = require('../utils/util');
const { isOrganizer } = require('../controllers/user');
const { getFeeds, createFeed, editFeed, deleteFeed } = require('../controllers/feed');
var router = express.Router();

// jwt 인증 middleware
router.use(auth);

const getFeed = async function (req, res, next) {
	let { offset, feedPerPage, place_id, feed_id } = req.query;

	if(!offset || typeof(offset) !== 'number')
		offset = 0
	
	if(!feedPerPage || typeof(feedPerPage) !== 'number')
		feedPerPage = 20

	let feeds = await getFeeds({ place_id, feed_id, offset, feedPerPage });
	res.json(feeds);
}


// 모든 핫플 피드 조회
// place_id : int
router.get('/', getFeed);

router.get('/:feed_id', getFeed);

// 핫플 피드 추가 - 관리자
// place_id : int
// title : string
// content : string
router.post('/',
 upload.fields([{ name: 'images', maxCount: 5 }, { name: 'content' }, ]),
 isOrganizer,  async (req, res, next) => {
	const { content, date, place_id } = req.body;
	
	await createFeed({ content, date, images: req.files.images }, place_id, req.user.uid);
	res.json({ message: 'Successful'});
});


// 핫플 피드 수정 - 관리자
// place_id : int
router.put('/:feed_id(\\d+)', isOrganizer, async (req, res, next) => {    
	const { title, content } = req.body;
	const { place_id, feed_id } = req.params;	

	await editFeed({ title, content, feed_id }, place_id);
	res.json({ message: 'Successful'});
});


// 핫플 피드 삭제 - 관리자
// place_id : int
router.delete('/:feed_id(\\d+)', isOrganizer, async (req, res, next) => {    	
	const { place_id, feed_id } = req.params;	

	await deleteFeed({ feed_id });
	res.json({ message: 'Successful' });
});

module.exports = router;