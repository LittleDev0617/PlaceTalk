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

app.use((req, res, next) => {
    // https://velog.io/@kdkeiie8/NodeJS-%EB%A1%9C%EA%B7%B8%EB%A5%BC-%EC%B0%8D%EC%96%B4%EB%B3%B4%EC%9E%90with-tracer

    const {
        method, path, url, query, headers: { cookie }, body,
    } = req;
    const request = {
        method, path, cookie, body, url, query
    };
    console.log(request);
});

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