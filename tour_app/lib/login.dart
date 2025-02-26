import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:tour_app/data/user.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  FirebaseDatabase? _database;
  DatabaseReference? _reference;
  String _databaseURL = "";

  // ID, PW input
  TextEditingController? _idController;
  TextEditingController? _pwController;

  // intro animation
  AnimationController? _animationController;
  Animation? _animation;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    // 기본 DB에 연결해서 user 라는 컬렉션 생성
    _database = FirebaseDatabase.instance;
    _reference = _database!.ref().child('user');

    _idController = TextEditingController();
    _pwController = TextEditingController();

    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this
    );
    _animation = Tween<double>(begin: 0, end: pi * 2)
        .animate(_animationController!);
    _animationController!.repeat();

    // 페이지 생성 후 2초 후 타이머 시작
    Timer(Duration(seconds: 2), () {
      setState(() {
        _opacity = 1;
      });
    });
  }
  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  Widget _airplaneAnimation() {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, widget) {
        return Transform.rotate(
          angle: _animation!.value,
          child: widget,);
      },
      child: Icon(
        Icons.airplanemode_active,
        color: Colors.deepOrangeAccent,
        size: 80,
      ),
    );
  }

  Widget _credentialInput() {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(seconds: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox( // ID
            width: 200,
            child: TextField(
              controller: _idController,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: '아이디',
                  border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 20,),
          SizedBox( // Password
            width: 200,
            child: TextField(
              controller: _pwController,
              obscureText: true,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder()
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return TextButton(
      onPressed: () {
        if(_idController!.value.text.length == 0 ||
          _pwController!.value.text.length == 0) {
          makeDialog("빈칸이 있습니다");
        } else {
          _reference!
              .child(_idController!.value.text)
              .onValue
              .listen((event) {
                if (event.snapshot.value == null) {
                  makeDialog("아이디가 없습니다");
                } else {
                  _reference!
                      .child(_idController!.value.text)
                      .onChildAdded
                      .listen((event) {
                        User user = User.fromsnapshot(event.snapshot);

                        var bytes = utf8.encode(_pwController!.value.text);
                        var digest = sha1.convert(bytes);
                        if (user.pw == digest.toString()) {
                          Navigator.of(context).pushReplacementNamed("/main",
                            arguments: _idController!.value.text
                          );
                        } else {
                          makeDialog("비밀번호가 틀립니다.");
                        }
                      });
                }
            });
        }
      },
      child: Text('로그인'),
    );
  }

  void makeDialog(String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(text),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _airplaneAnimation(), // Logo
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    "모두의 여행",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              _credentialInput(), // ID, PW 입력란
              Row( // 회원 가입, 로그인 버튼
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){ Navigator.of(context).pushNamed('/sign'); },
                    child: Text('회원가입')
                  ),
                  _loginButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
