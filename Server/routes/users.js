const express = require('express');
const conn = require('../utils/db');
const jwt = require('../utils/jwt');
const { getRandomNickname } = require('@woowa-babble/random-nickname');

const router = express.Router();
const { BadRequestError, UnauthorizedError } = require('../utils/error');
const { auth } = require('../utils/auth');
const { getUsers, createUser, getUserPlace, grantAdminRole, removeAdminRole, changeNickname, exitPlace, joinPlace, isAdmin } = require('../services/user');
const { isAdminMW, isOrganizer } = require('../services/user');
const { errorWrapper, ADMIN_TOKEN } = require('../utils/util');
const { getPosts } = require('../services/post');

// 회원 로그인 및 가입
router.get('/auth', errorWrapper(async (req, res, next) => {
    let { token, email, nickname } = req.query;
    if(!token) 
        throw new BadRequestError('token is required.');
    // https://kapi.kakao.com/v2/user/me -> 회원 정보 가져오기
    let user_id = parseInt(token);

    let users = await getUsers({ user_id });
    
    if(!users.length) {
        if(!nickname)
            nickname = getRandomNickname('animals');
        if(!email)
            email = 'test@example.com';
        await createUser({ user_id, nickname: nickname, email });
    }
    const pay = {
        uid : user_id,
        // level : users[0]['level']
    };
    
    const jwt_token = jwt.sign(pay, jwt.secret, jwt.options);
    res.cookie('token', jwt_token);
    res.json({ message : 'Success' });
}));

// 자신이 참가중인 핫플 조회
router.get('/place', auth, async (req, res, next) => {
    places = await getUserPlace(req.user.uid);
    res.json(places);
});


// 핫플 참가
router.get('/join/:place_id(\\d+)', auth, errorWrapper(async (req, res, next) => {   
	const { place_id } = req.params;
    
	let result = await joinPlace(req.user.uid, place_id);
	res.json({ message : 'Success' });
}));

// 핫플 나가기
router.get('/exit/:place_id(\\d+)', auth, errorWrapper(async (req, res, next) => {   
	const { place_id } = req.params;

	let result = await exitPlace(req.user.uid, place_id);
	res.json({ message : 'Success' });
}));

// 자신이 쓴 게시글 조회
router.get('/post', auth, async (req, res, next) => {
    let posts = await getPosts({ user_id: req.user.uid });
    res.json(posts); 
});

// 운영자 권한 부여
router.get('/grant-org', auth, isAdminMW, async (req, res, next) => {
    const { user_id, place_id } = req.query;
    await grantAdminRole(user_id, place_id);
    res.json({ message : 'Successful' });
});

// 
router.get('/remove-org', auth, isAdminMW, async (req, res, next) => {
    const { user_id, place_id } = req.query;
    await removeAdminRole(user_id, place_id);
    res.json({ message : 'Successful' });
});

router.get('/change-nickname', auth, errorWrapper(async (req, res, next) => {
    const { nickname, user_id } = req.query;
    
    // 본인만 닉 변경 가능
    if(!isAdmin(req.user.uid) && user_id != req.user.uid)
        throw new UnauthorizedError('Cannot access');

    await changeNickname(user_id, nickname);
    res.json({ message : 'Successful' });
}));
module.exports = router;