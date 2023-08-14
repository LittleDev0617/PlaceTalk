const express = require('express');
const conn = require('../utils/db');
const jwt = require('../utils/jwt');

const router = express.Router();
const { BadRequestError, UnauthorizedError } = require('../utils/error');
const { auth } = require('../utils/auth');
const { getUsers, createUser, getUserPlace, grantAdminRole, removeAdminRole, changeNickname } = require('../services/user');
const { isAdmin, isOrganizer } = require('../services/user');
const { errorWrapper } = require('../utils/util');
const { getPosts } = require('../services/post');

// 회원 로그인 및 가입
router.get('/auth', errorWrapper(async (req, res, next) => {
    const { token } = req.query;
    if(!token) 
        throw new BadRequestError('token is required.');
    // https://kapi.kakao.com/v2/user/me -> 회원 정보 가져오기
    let user_id = token;

    let users = await getUsers(user_id);
    
    if(!users.length)
        await createUser(user_id);

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


// 자신이 쓴 게시글 조회
router.get('/post', auth, async (req, res, next) => {
    let posts = await getPosts({ user_id: req.user.uid });
    res.json(posts); 
});

// 운영자 권한 부여
router.get('/grant-org', auth, isAdmin, async (req, res, next) => {
    const { user_id, place_id } = req.query;
    await grantAdminRole(user_id, place_id);
    res.json({ message : 'Successful' });
});

// 
router.get('/remove-org', auth, isAdmin, async (req, res, next) => {
    const { user_id, place_id } = req.query;
    await removeAdminRole(user_id, place_id);
    res.json({ message : 'Successful' });
});

router.get('/set-nickname', auth, isOrganizer, errorWrapper(async (req, res, next) => {
    const { nickname, user_id, place_id } = req.query;
    
    // 운영자 본인만 닉 변경 가능
    if(req.user.uid != 0 && user_id != req.user.uid)
        throw new UnauthorizedError('Cannot access');

    await changeNickname(user_id, place_id, nickname);
    res.json({ message : 'Successful' });
}));
module.exports = router;