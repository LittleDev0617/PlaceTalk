var express = require('express');
var conn = require('../utils/db');
const jwt = require('../utils/jwt');
const { BadRequestError, UnauthorizedError } = require('../utils/error');
var router = express.Router();

// Get places
router.get('/', (req, res, next) => {
	conn.query(`SELCET p.*, (
				SELECT COUNT(*) 
				FROM tb_join as j 
				WHERE p.place_id = j.place_id
				) as cnt FROM tb_place as p `, (err, rows) => {
		res.json(rows);
	});
});

router.get('/:user_id', (req, res, next) => {
	const uid = parseInt(req.params.user_id);
	conn.query(`SELCET p.*, (
		SELECT COUNT(*) 
		FROM tb_join as j 
		WHERE p.place_id = j.place_id
		) as cnt FROM tb_place as p WHERE p.place_id = ?`, [uid], (err, rows) => {
		res.json(rows);
	});
});

// Get Booth
router.get('/:place_id', (req, res, next) => {
	const place_id = parseInt(req.params.place_id);
	conn.query('SELECT * from tb_booth WHERE place_id = ?', [place_id], (err, rows) => {
		res.json(rows);
	});
});

// join user to place
router.post('/join', (req, res, next) => {
	const { user_id, place_id } = req.body;

	if(!(typeof(user_id) === 'number' && typeof(place_id) === 'number'))
		throw new BadRequestError('Bad data.');

	conn.query('SELECT COUNT(*) FROM tb_join WHERE user_id = ?', [user_id], (err, rows) => {
		if(!rows.length)
			res.json({ message : 'Empty' });

		// Check duplicate ?

		if(rows.length < 5) {
			conn.query('INSERT INTO tb_join VALUES(?, ?)', [user_id, place_id], (err, rows) => {
				if(err)
					console.log(err);
				res.json({ message : 'Successful' });
			});
		}
		else
			res.json({ message : 'User cannot join in more than 5 places.'});
	});
});

// Add place
router.post('/add', (req, res, next) => {
	const { token, placeName, startDate, endDate, latitude, longitude } = req.body;
	
	if(!token || typeof(token) != 'string')
		throw new BadRequestError('token is required.');

	user = jwt.verify(token);

	if(!user)
		throw new UnauthorizedError('token is not valid.');

	if(user['level'] == 2)
		throw new BadRequestError('guest cannot add place.');

	if(!(typeof(placeName) === 'string' && typeof(startDate) == 'string' &&
		typeof(endDate) === 'string' && typeof(latitude) == 'number' && typeof(longitude) === 'number'))
		throw new BadRequestError('Bad data.');
	
	conn.query('INSERT INTO tb_place(name, start_date, end_date, latitude, longitude) VALUES(?, ?, ?, ?, ?)', 
				[placeName, startDate, endDate, latitude, longitude], (err, rows) => {
		if(err)
			console.log(err);
	});
	res.send({ message : "Successful" });
});

module.exports = router;