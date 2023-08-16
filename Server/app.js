const express = require('express');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const cors = require('cors');
const app = express();

const usersRouter = require('./routes/users');
const placesRouter = require('./routes/places');
const boothsRouter = require('./routes/booths');
const feedsRouter = require('./routes/feeds');
const infosRouter = require('./routes/infos');
const postsRouter = require('./routes/posts');
const commentsRouter = require('./routes/comments');

app.use(cors({ origin: "http://localhost:1234", credentials: true }));
console.log(__dirname + '/images')
app.use('/images', express.static(__dirname + '/images'));
app.use(bodyParser.json());
app.use(cookieParser());

app.use((req, res, next) => {
    // https://velog.io/@kdkeiie8/NodeJS-%EB%A1%9C%EA%B7%B8%EB%A5%BC-%EC%B0%8D%EC%96%B4%EB%B3%B4%EC%9E%90with-tracer

    const {
        method, params, path, url, query, headers: { cookie }, body,
    } = req;
    const request = {
        method, path, cookie, body, url, query, params
    };
    console.log(request);
    next();
});

app.use('/api/users', usersRouter);
app.use('/api/places', placesRouter);
app.use('/api/booths', boothsRouter);
app.use('/api/feeds', feedsRouter);
app.use('/api/infos', infosRouter);
app.use('/api/posts', postsRouter);
app.use('/api/comments', commentsRouter);

app.use(async (err, req, res, next) => {
    if(err.status)
        res.status(err.status).json([{ code : err.code, message : err.message }]);
    next();
});

const port = 3000;
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});