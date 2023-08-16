var express = require('express');
var conn = require('../utils/db');
const { auth } = require('../utils/auth');
const { getPosts, pressPostLike } = require('../controllers/post');
const { BadRequestError } = require('../utils/error');
const { errorWrapper } = require('../utils/util');
const { getComments, createComment, deleteComment } = require('../controllers/comment');
var router = express.Router();

// jwt 인증 middleware
router.use(auth);

// 댓글 조회
// post_id  : int
// 게시글 작성자 본인 -> user_id = 0
// 이외 작성자 -> 1, 2, 3 ..
router.get('/', async (req, res, next) => {
	let { offset, commentsPerPage, likeOrder, post_id, user_id } = req.query;	
	const { comment_id } = req.params;

	if(!offset || typeof(offset) !== 'number')
		offset = 0
	
	if(!commentsPerPage || typeof(commentsPerPage) !== 'number')
		commentsPerPage = 10

	if(!likeOrder || typeof(likeOrder) !== 'boolean')
		likeOrder = false;

	let comments = await getComments({ user_id, post_id, comment_id, offset, commentsPerPage, likeOrder });

	// 익명 비활성화
	// let writer = (await getPosts({ post_id }))[0].user_id;

	// let users = {};

	// for (let i = 0; i < comments.length; i++) {
	// 	let comment_user_id = comments[i]['user_id'];
	// 	if(writer !== comment_user_id) {
	// 		if(!users[comment_user_id])
	// 			users[comment_user_id] = i + 1;

	// 		comments[i]['user_id'] = users[comment_user_id];	
	// 	}
	// 	else
	// 		comments[i]['user_id'] = 0;
	// }

	res.json(comments);
});

// 댓글 추가
// post_id  : int
// is_reply : int - 0 or 1
// reply_id : int - 0 : 대댓 X / 0 제외 자연수 comment_id : comment_id 의 대댓
router.post('/', async (req, res, next) => {
	const { is_reply, reply_id, content, post_id } = req.body;
	
	await createComment({ post_id, content, is_reply, reply_id, user_id: req.user.uid });
	res.json([{ message : "Successful" }]);
});

// 댓글 삭제	- 본인 or 어드민
// place_id : int
// post_id  : int
router.delete('/:comment_id(\\d+)', errorWrapper(async (req, res, next) => {	
	const { comment_id } = req.params;
	
	let comment = (await getComments({ comment_id }))[0];
	if(!comment)
		throw new BadRequestError('No comment');

	if(isAdmin(req.user.uid) || req.user.uid == comment.user_id) {
		await deleteComment(comment_id);
	}

	res.json([{ message : "Successful" }]);
}));

// 댓글 좋아요
router.get('/:comment_id(\\d+)/like', async (req, res, next) => {
	const { comment_id } = req.params;

	await pressPostLike(comment_id, req.user.uid);
	res.json([{ message : "Successful" }]);
});

module.exports = router;