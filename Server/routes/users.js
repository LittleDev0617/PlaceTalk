const express = require('express');
const conn = require('../utils/db');
const jwt = require('../utils/jwt');

const router = express.Router();
const { BadRequestError, UnauthorizedError } = require('../utils/error');

router.get('/', (req, res, next) => {
    res.send('test');
});

router.post('/login', (req, res, next) => {
    const { user_id } = req.body;
    if(!user_id) 
        throw new BadRequestError('user_id is required.');
    
    // TODO : oauth kakao token
    

    conn.query('SELECT level FROM tb_user WHERE user_id = ?', [user_id], (err, row, fields) => {
        if(!row) throw new UnauthorizedError('User not found.');
        const pay = {
            uid : user_id,
            level : row[0]
        };

        const token = jwt.sign(pay, jwt.secret, jwt.options);
        res.json({ token : token });
    });
});

router.post('/', (req, res, next) => {
    const { user_id } = req.body;
    if(!user_id) 
        throw new BadRequestError('user_id is required.');

    conn.query('SELECT level FROM tb_user WHERE user_id = ?', [user_id], (err, row) => {
        // TODO : verify kakao token

        // if no user, add
        if(!row) {
            conn.query('INSERT INTO tb_user VALUES(user_id, level)', [user_id, 2]);
        }

        const pay = {
            uid : user_id,
            level : row[0]
        };

        const token = jwt.sign(pay, jwt.secret, jwt.options);
        res.json({ token : token });
    });
});

module.exports = router;