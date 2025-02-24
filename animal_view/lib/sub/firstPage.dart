import 'package:flutter/material.dart';
import '../animalItem.dart';

class FirstApp extends StatelessWidget {
  final List<Animal>? list;
  const FirstApp({super.key, this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(
            itemBuilder: (context, position) {
              return GestureDetector(
                child: Card(
                  child: Row(
                    children: [
                      Image.asset(list![position].imagePath!, height: 100, width: 100, fit: BoxFit.contain,),
                      Text(list![position].animalName!),
                    ],
                  ),
                ),
                onTap: () {
                  AlertDialog dlg = AlertDialog(
                    content: Text(
                      '이 동물은 ${list![position].kind}입니다',
                      style: TextStyle(fontSize: 30.0),
                    )
                  );
                  showDialog(context: context, builder: (BuildContext context) => dlg);
                },
              );
            },
            itemCount: list!.length,
          ),
        ),
      ),
    );
  }
}
