const express = require('express');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const app = express();

const usersRouter = require('./routes/users');
const postsRouter = require('./routes/posts');
const placesRouter = require('./routes/places');

app.use(express.static(__dirname + '/images'));
app.use(bodyParser.json());
app.use(cookieParser());

app.use('/api/users', usersRouter);
app.use('/api/posts', postsRouter);
app.use('/api/places', placesRouter);

// app.use((err, req, res, next) => {
//     if(err.status)
//         res.status(err.status).json({ message : err.message });
//     next();
// });

const port = 3000;
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});