class BadRequestError extends Error { constructor(msg) { super(msg); this.status = 400; } }
class UnauthorizedError extends Error { constructor(msg) { super(msg); this.status = 401; } }
class AlreadyJoinError extends Error { constructor() { super('User already joined.'); this.status = 200; this.code = 1; } }
class TooManyJoinError extends Error { constructor() { super('Cannot join more than 5 places.'); this.status = 200; this.code = 2; } }

module.exports = { BadRequestError, UnauthorizedError, AlreadyJoinError, TooManyJoinError };