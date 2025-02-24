import 'package:flutter/material.dart';

import '../animalItem.dart';

// main 에서 받은 동물 목록에 신규 동물 추가
class SecondApp extends StatefulWidget {
  List<Animal>? list;
  SecondApp({super.key, @required this.list});

  @override
  State<SecondApp> createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  final nameController = TextEditingController(); // name
  int? _radioValue = 0; // kind
  bool? flyExist = false;  // can fly
  String? _imagePath; // 얼굴 선택

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField( // 이름 입력
                controller: nameController,
                keyboardType: TextInputType.text,
                maxLines: 1,
              ),
              Row( // 종류 선택
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Radio(value: 0, groupValue: _radioValue, onChanged: _radioChanged),
                  Text("양서류"),
                  Radio(value: 1, groupValue: _radioValue, onChanged: _radioChanged),
                  Text("파충류"),
                  Radio(value: 2, groupValue: _radioValue, onChanged: _radioChanged),
                  Text("포유류"),
                ],
              ),
              Row(  // 비행 능력
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("날 수 있나요?"),
                  Checkbox(
                    value: flyExist,
                    onChanged: (bool? check) {
                      setState(() {
                        flyExist = check;
                      });
                    })
                ],
              ),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      child: Image.asset("assets/images/cow.png", width: 80,),
                      onTap: (){
                        _imagePath = "assets/images/cow.png";
                      },
                    ),
                    GestureDetector(
                      child: Image.asset("assets/images/pig.png", width: 80,),
                      onTap: (){
                        _imagePath = "assets/images/pig.png";
                      },
                    ),
                    GestureDetector(
                      child: Image.asset("assets/images/bee.png", width: 80,),
                      onTap: (){
                        _imagePath = "assets/images/bee.png";
                      },
                    ),
                    GestureDetector(
                      child: Image.asset("assets/images/cat.png", width: 80,),
                      onTap: (){
                        _imagePath = "assets/images/cat.png";
                      }
                    ),
                    GestureDetector(
                      child: Image.asset("assets/images/dog.png", width: 80,),
                      onTap: (){
                        _imagePath = "assets/images/dog.png";
                      },
                    ),
                    GestureDetector(
                      child: Image.asset("assets/images/monkey.png", width: 80,),
                      onTap: (){
                        _imagePath = "assets/images/monkey.png";
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: Text('동물 추가하기'),
                onPressed: (){
                  var animal = Animal(
                    animalName: nameController.value.text,
                    kind: _getKind(_radioValue),
                    imagePath: _imagePath
                  );
                  AlertDialog dlg = AlertDialog(
                    title: Text("동물 추가하기"),
                    content: Text(
                      '이 동물은 ${animal.animalName}입니다.'
                      '또 동물의 종류는 ${animal.kind}입니다.\n'
                      '이 동물을 추가하시겠습니까?'
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: (){
                          widget.list?.add(animal);
                          Navigator.of(context).pop();
                        },
                        child: Text('예')
                      ),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text('아니오')
                      ),
                    ],
                  );
                  showDialog(context: context, builder: (BuildContext context) => dlg);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _radioChanged(int? value) {
    setState(() {
      _radioValue = value;
    });
  }

  _getKind(int? value) {
    if (value == 0) {
      return "양서류";
    } else if (value == 1) {
      return "파충류";
    } else {
      return "포유류";
    }
  }
}


