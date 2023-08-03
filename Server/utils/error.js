class BadRequestError extends Error { constructor(msg) { this.status = 400; } }
class UnauthorizedError extends Error { constructor(msg) { this.status = 401; } }

module.exports = { BadRequestError, UnauthorizedError };