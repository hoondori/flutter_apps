import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalcPage(title: 'Mini Calculator'),
    );
  }
}

class CalcPage extends StatefulWidget {
  const CalcPage({super.key, required this.title});

  final String title;

  @override
  State<CalcPage> createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage> {

  String sum = "";
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  List _buttonList = ['Add', 'Subtract', 'Multiply', 'Divide'];
  List<DropdownMenuItem<String>> _dropDownMenuItems = new List.empty(growable: true);
  String? _buttonText;

  @override
  void initState() {
    super.initState();
    for(var item in _buttonList) {
      _dropDownMenuItems.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    _buttonText = _dropDownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding( // show result
            padding: EdgeInsets.all(15),
            child: Text('Result: $sum', style: TextStyle(fontSize: 20)),
          ),
          Padding( // first numeric value to be inputted
            padding: EdgeInsets.only(left:20, right: 20),
            child: TextField(keyboardType: TextInputType.number, controller: value1,),
          ),
          Padding( // second numeric value to be inputted
            padding: EdgeInsets.only(left:20, right: 20),
            child: TextField(keyboardType: TextInputType.number, controller: value2,),
          ),
          Padding(  // button to apply operation on value1 and value2
            padding: EdgeInsets.all(15),
            child:ElevatedButton(
              child: Row(
                children: [
                  _getIcon(),
                  Text('$_buttonText'),
                ],
              ),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
              onPressed: (){ // do calculation and set result to state
                setState(() {
                  double result = _doCalc();
                  sum = '$result';
                });
              },
            ),
          ),
          Padding( // List of operation
            padding: EdgeInsets.all(15),
            child: DropdownButton(
              items: _dropDownMenuItems,
              value: _buttonText, // currently chosen
              onChanged: (String? value) {
                setState(() {
                  _buttonText = value;
                });
              }
            )
          )
        ],
      )
    );
  }

  Widget _getIcon() {
    if (_buttonText == 'Add') {
      return Icon(Icons.add);
    } else if (_buttonText == 'Subtract') {
      return Icon(Icons.remove);
    } else if (_buttonText == 'Multiply') {
      return Icon(Icons.dangerous_rounded);
    } else {
      return Icon(Icons.safety_divider);
    }
  }

  double _doCalc() {
    var _value1 = double.parse(value1.value.text);
    var _value2 = double.parse(value2.value.text);

    if (_buttonText == 'Add') {
      return _value1 + _value2;
    } else if (_buttonText == 'Subtract') {
      return _value1 - _value2;
    } else if (_buttonText == 'Multiply') {
      return _value1 * _value2;
    } else {
      return _value1 + _value2;
    }
  }
}
