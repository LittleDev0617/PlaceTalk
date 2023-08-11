const express = require('express');
const conn = require('../utils/db');
const jwt = require('../utils/jwt');

const router = express.Router();
const { BadRequestError, UnauthorizedError } = require('../utils/error');
const { auth } = require('../utils/auth');

// deprecate
// router.post('/login', (req, res, next) => {
//     const { user_id } = req.body;
//     if(!user_id) 
//         throw new BadRequestError('user_id is required.');
    
//     // TODO : oauth kakao token
    

//     conn.query('SELECT level FROM tb_user WHERE user_id = ?', [user_id], (err, row, fields) => {
//         if(!row) throw new UnauthorizedError('User not found.');
//         const pay = {
//             uid : user_id,       
//             level : row[0]
//         };

//         const token = jwt.sign(pay, jwt.secret, jwt.options);
//         res.json({ token : token });
//     });
// });

// 회원 로그인 및 가입
router.get('/auth', (req, res, next) => {
    const { token } = req.query;
    if(!token) 
        throw new BadRequestError('token is required.');
    // https://kapi.kakao.com/v2/user/me -> 회원 정보 가져오기

    conn.query('SELECT level FROM tb_user WHERE user_id = ?', [token], (err, row) => {
        // TODO : verify kakao token
        // if no user, add
        if(!row.length) {
            conn.query('INSERT INTO tb_user(user_id, level) VALUES(?, ?)', [token, 2], (err, row) => {                
            });
        }

        const pay = {
            uid : token,
            level : row[0]['level']
        };
        
        const jwt_token = jwt.sign(pay, jwt.secret, jwt.options);
        res.cookie('token', jwt_token);
        res.json({ message : 'Success' });
    });
});

// 자신이 참가중인 핫플 조회
router.get('/place', auth, (req, res, next) => {
    conn.query('SELECT * FROM tb_place WHERE place_id IN (SELECT place_id FROM tb_join WHERE user_id = ?)', [req.user.uid], (err, rows) => {
        res.json(rows);
    });
});

module.exports = router;