import 'package:flutter/material.dart';
import 'people.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Animator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'BMI Animator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<People> _people = new List.empty(growable: true);
  int _current = 0;
  Color _weightColor = Colors.blue;  // 몸무게 레벨에 따라 몸무게 막대 그래프 색상 변경
  double _opacity = 1.0;

  @override
  void initState() {
    _people.add(People('Smith', 120, 92));
    _people.add(People('Mary', 194, 140));
    _people.add(People('Hoondori', 165, 73));
    super.initState();
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
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 1),
                child: SizedBox(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: 100, child: Text('이름: ${_people[_current].name}')),
                      AnimatedContainer( // 키에 비례해서 막대 그래프
                        width: 50,
                        height: _people[_current].height,
                        duration: Duration(seconds: 2),
                        curve: Curves.bounceIn,
                        color: Colors.amber,
                        child: Text(
                          '키: ${_people[_current].height}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      AnimatedContainer( // 몸무게에 비례해서 막대 그래프
                        width: 50,
                        height: _people[_current].weight,
                        duration: Duration(seconds: 2),
                        curve: Curves.easeInCubic,
                        color: _weightColor,
                        child: Text(
                          '몸무게: ${_people[_current].weight}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      AnimatedContainer( // BMI 에 비례해서 막대 그래프
                        width: 50,
                        height: _people[_current].bmi,
                        duration: Duration(seconds: 2),
                        curve: Curves.linear,
                        color: Colors.pinkAccent,
                        child: Text(
                          'BMI: ${_people[_current].bmi.toString().substring(0, 2)}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                child: Text("다음"),
                onPressed: (){
                  setState(() {
                    if (_current < _people.length - 1) {
                      _current++;
                      _changeColor(_people[_current].weight);
                    }
                  });
                }
              ),
              ElevatedButton(
                child: Text("이전"),
                onPressed: (){
                  setState(() {
                    if (_current > 0) {
                      _current--;
                      _changeColor(_people[_current].weight);
                    }
                  });
                }
              ),
              ElevatedButton(
                  child: Text("사라지기"),
                  onPressed: (){
                    setState(() {
                      _opacity == 1 ? _opacity = 0.3: _opacity = 1;
                    });
                  }
              ),
            ]
          )
        )
      )
    );
  }

  void _changeColor(double weight) {
    if (weight < 40) {
      _weightColor = Colors.blueAccent;
    } else if (weight < 60) {
      _weightColor = Colors.indigo;
    } else if (weight < 80) {
      _weightColor = Colors.orange;
    } else {
      _weightColor = Colors.red;
    }
  }
}
