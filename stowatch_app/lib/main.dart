import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stop Watch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StopWatchPage(title: 'Stop Watch'),
    );
  }
}

class StopWatchPage extends StatefulWidget {
  const StopWatchPage({super.key, required this.title});
  final String title;

  @override
  State<StopWatchPage> createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  Timer? _timer;
  var _time = 0;  // 0.01 초마다 1씩 증가
  var _isRunning = false;   // 현재 시작 상태
  List<String> _laptimes = []; // 랩타임 저장

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomAppBar(
        child: Container(height: 90,)
      ),
      floatingActionButton: FloatingActionButton( // 중앙 시작(play) 버튼
        onPressed: () {
          setState(() {
            _clickButton();
          });
        },
        child: _isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _buildBody() {
    var sec = _time ~/100; // 초
    var millisec = '${_time%100}'.padLeft(2, '0');  // 1/100 초

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row( // 시간 표시 영역
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('$sec', style: TextStyle(fontSize: 50.0),), // sec
                    Text('$millisec') // millisec
                  ],
                ),
                Container( // lap-time 표시부
                  width: 100,
                  height: 200,
                  child: ListView(
                    children: _laptimes.map((time) => Text(time)).toList(),
                  ),
                ),
              ],
            ),
            Positioned( // 왼쪽 하단, 초기화 버튼
              left: 10,
              bottom: 10,
              child: FloatingActionButton(
                backgroundColor: Colors.deepOrange,
                onPressed: _reset,
                child: Icon(Icons.rotate_left),
              ),
            ),
            Positioned( // 오른쪽 하단, 랩타임 기록 버튼
              right: 10,
              bottom: 10,
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    _recordLapTime('$sec.$millisec');
                  });
                },
                child: Text("랩타임"),
              ),
            ),
          ],
        )
      ),
    );
  }


  _clickButton() {
    // 시작/정지 flag
    _isRunning = !_isRunning;

    if(_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  _start() {
    // 0.01  초마다 tick이 증가하는 timer 구동
    _timer = Timer.periodic(Duration(microseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }
  _pause() {
    _timer?.cancel();
  }

  _reset() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
      _laptimes.clear();
      _time = 0;
    });
  }

  _recordLapTime(String time) {
    _laptimes.insert(0, 'Rank: ${_laptimes.length+1} $time');
  }
}


