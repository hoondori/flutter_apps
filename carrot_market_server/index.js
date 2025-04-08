require('dotenv').config();
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const router = require('./src/router');
const bodyParser = require('body-parser');

// json 형식 데이터 처리 
app.use(bodyParser.json());

// url 인코딩된 데이터 처리
app.use(bodyParser.urlencoded({extended: true}));

// router를 어플리케이션에 등록
app.use('/', router);

// 서버 시작
app.listen(port, ()=>{
  console.log(`웹 서버 가동... ${port}`);
});
