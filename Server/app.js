const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');

const app = express();

const usersRouter = require('./routes/users');

app.use('/api/users', usersRouter);

app.use(bodyParser.json());

const pool = mysql.createPool({
  host: 'mysql-host',
  user: 'mysql-username',
  password: 'mysql-password',
  database: 'mysql-database',
});

app.get('/', (req, res) => {
  res.send('Hello World!');
});

const port = 3000;
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});