const { BadRequestError, UnauthorizedError } = require('./error');
const jwt = require('./jwt');
const { errorWrapper } = require('./util');

module.exports = {
    auth : errorWrapper(async function(req, res, next) {
        const token = req.cookies['token']
        if(!token || typeof(token) != 'string')
            throw new BadRequestError('token is required.');

        user = await jwt.verify(token, jwt.secret);
        if(!user)
            throw new UnauthorizedError('token is not valid.');

        req.user = user;
        next();
    })
}