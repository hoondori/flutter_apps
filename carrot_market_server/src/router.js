
const express = require('express');
const router = express.Router();

const multer = require('multer');
const upload = multer( {dest: 'storage/'});

const webController = require('./web/controller');
const apiFeedController = require('./api/feed/controller');
const apiUserController = require('./api/user/controller');

const { logRequestTime } = require('./middleware/log');

// 로깅을 모든 곳에 적용
router.use(logRequestTime);

router.get('/', webController.home);
router.get('/page:route', logRequestTime, webController.page); 

router.get('/api/feed', apiFeedController.index);
router.post('/api/feed', apiFeedController.store);
router.get('/api/feed/:id', apiFeedController.show);
router.put('/api/feed/:id', apiFeedController.update);
router.delete('/api/feed/:id', apiFeedController.delete);

router.post('/auth/phone', apiUserController.phone);
router.put('/auth/phone', apiUserController.phoneVerify);
router.post('/auth/register', apiUserController.register);
router.post('/auth/login', apiUserController.login);
router.post('/api/user/my', apiUserController.update);


router.post("/api/user/my", (req, res) =>  {
  res.send('마이 페이지');
});

router.get("/api/feed", (req, res) =>  {
  res.send('피드 목록');
});

router.post('/file', upload.single('file'), (req, res) =>{
  console.log(req.file);
  res.json(req.file);
});

module.exports = router;