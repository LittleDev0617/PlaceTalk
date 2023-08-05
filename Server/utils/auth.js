
module.exports = {
    auth : function(token, level) {
        if(!token || typeof(token) != 'string')
            throw new BadRequestError('token is required.');

        user = jwt.verify(token);

        if(!user)
            throw new UnauthorizedError('token is not valid.');

        if(user['level'] > level)
            return false;
        
        return user;
    }
}