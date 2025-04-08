const generateToken = require('./jwt');

exports.phone = (req, res) => {
  res.send('인증 번호 발송');
}

exports.phoneVerify = (req, res) => {
  const { code } = req.body;

  if (code == '123456') {
    res.json({result: 'ok', message: '성공'});
    return;
  }

  res.json({result: 'fail', message: '인증번호가 맞지 않습니다'});
}

exports.register = async (req, res) => {
  // [TODO] 사용자 정보 검증 후....

  // 토큰 발급
  try {
    const userInfo = { id: 1, name: ' 홍길동'}; 
    const token = await generateToken(userInfo);
    res.json({result: "ok", access_token: token});
  } catch (error) {
    res.status(500).json({result: "error", message: '토큰 발급 실패'});
  }
}

exports.login = (req, res) => {
  res.send('마이 페이지');
}

exports.update = (req, res) => {
  res.send('마이 페이지 수정');
}