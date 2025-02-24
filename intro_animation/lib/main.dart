import 'package:flutter/material.dart';
import 'package:intro_animation/saturnLoading.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const IntroPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("This is main page")),
      body: Center(
        child: Text("This is main page"),
      )
    );
  }
}


class IntroPage extends StatefulWidget {
  const IntroPage({super.key, required this.title});

  final String title;

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  @override
  void initState() {
    super.initState();
    waitAndGo();
  }

  // 일정 시간 이후 다른 page로 이동
  Future<Timer> waitAndGo() async {
    return Timer(Duration(seconds: 5), onDoneLoading);
  }

  void onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text('토성 운행 인트로'),
              SizedBox(height: 20,),
              Saturnloading()
            ],
          ),
        ),
      )
    );
  }
}
