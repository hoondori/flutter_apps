const jwt = require('jsonwebtoken');
const util = require('util');

// jwt.sign 함수를 비동기적으로 사용할 수 있게 변환
const signAsync = util.promisify(jwt.sign);
const privateKey = process.env.JWT_KEY;

// payload로 JWT token 생성
async function generateToken(payload) {
  return await signAsync(payload, privateKey);
}

module.exports = generateToken;
