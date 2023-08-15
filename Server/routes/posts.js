var express = require('express');
var conn = require('../utils/db');
const { auth } = require('../utils/auth');
const { createPost, getPosts, editPost, deletePost, pressPostLike } = require('../services/post');
const { BadRequestError, UnauthorizedError } = require('../utils/error');
const { errorWrapper } = require('../utils/util');
const { getComments, createComment, deleteComment } = require('../services/comment');
const { getPlaces } = require('../services/place');
const { isAdmin } = require('../services/user');
var router = express.Router();

// jwt 인증 middleware
router.use(auth);

const getPostsC = async (req, res, next) => {    
	let { offset, postPerPage, likeOrder, place_id } = req.query;
	const { post_id } = req.params;

	if(!offset || typeof(offset) !== 'number')
		offset = 0
	
	if(!postPerPage || typeof(postPerPage) !== 'number')
		postPerPage = 10

	if(!likeOrder || typeof(likeOrder) !== 'boolean')
		likeOrder = false;

	const posts = await getPosts({ offset, postPerPage, likeOrder, place_id, post_id });
	res.json(posts);
};

// place_id 핫플의 여러 게시글 조회
// offset 	   : 시작 페이지
// postPerPage : 페이지 당 게시글 수
// likeOrder   : bool / 좋아요 순 정렬 false -> 시간순 정렬
router.get('/', getPostsC);
router.get('/:post_id(\\d+)', getPostsC);

// 게시글 추가
router.post('', errorWrapper(async (req, res, next) => {    
	const { content, place_id } = req.body;

	if(!(typeof(content) === 'string'))
		throw new BadRequestError('Bad data.');
	
	const userJoinPlaces = await getPlaces({ user_id: req.user.uid, place_id });
	if(!userJoinPlaces.length)
		throw new UnauthorizedError('Access denied.');

	await createPost({ content, place_id, user_id: req.user.uid });
	res.json({ message : "Successful" });
}));

const isWriter = errorWrapper(async function(req, res, next) {
	const { post_id } = req.params;

	if(isAdmin(req.user.uid))
		next();

	const posts = await getPosts({ post_id });
	if(!posts.length) {
		throw new BadRequestError('Post does not exist.');
	}
	if(req.user.uid !== posts[0].user.user_id) {
		throw new UnauthorizedError('user_id does not match.');
	}
	next();
});

// 게시글 수정
router.put('/:post_id(\\d+)', isWriter, errorWrapper(async (req, res, next) => {    
	const { content } = req.body;
	const { post_id } = req.params;

	if(!(typeof(content) === 'string'))
		throw new BadRequestError('Bad data.');
	
	await editPost({ content, post_id });
	res.json({ message : "Successful" });
}));

// 게시글 삭제
router.delete('/:post_id(\\d+)', isWriter, async (req, res, next) => {	    
	const { post_id } = req.params;
	console.log(post_id)
	await deletePost(post_id);
	res.json({ message : "Successful" });
});

// 게시글 좋아요
router.get('/:post_id(\\d+)/like', async (req, res, next) => {
	const { post_id } = req.params;

	await pressPostLike(post_id, req.user.uid);
	res.json({ message : "Successful" });
});


module.exports = router;