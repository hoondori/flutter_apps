import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BmiMain(),
    );
  }
}

class BmiMain extends StatefulWidget {
  const BmiMain({super.key});

  @override
  State<BmiMain> createState() => _BmiMainState();
}

class _BmiMainState extends State<BmiMain> {
  final _formKey = GlobalKey<FormState>();

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child:Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Height',
                ),
                keyboardType: TextInputType.number,
                controller: _heightController,
                validator: (value) {
                  if (value?.trim().isEmpty ?? true)  {
                    return "You must input your height";
                  }
                  return null;  // no error
                },
              ),
              SizedBox(height: 16,),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Weight',
                ),
                keyboardType: TextInputType.number,
                controller: _weightController,
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "You must input your weight";
                  }
                  return null;  // no error
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      // navigate to result page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            BmiResult(
                                height: double.parse(_heightController.text.trim()),
                                weight: double.parse(_weightController.text.trim()),
                            )
                        )
                      );
                    }
                  },
                  child: Text("Show Result"),
                )
              )
            ],
          )
        ),
      ),
    );
  }
}

class BmiResult extends StatelessWidget {

  final double height;
  final double weight;
  late final bmi = weight / (height/100)*(height/100);
    
  BmiResult({
    super.key,
    required this.height,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_calcBmi(bmi), style: TextStyle(fontSize: 36),),
            SizedBox(height: 16,),
            _buildIcon(bmi),
          ],
        ),
      ),
    );
  }

  String _calcBmi(double bmi) {
    var result = 'Underweight';
    if (bmi >= 35) {
      result = 'Severely Obese';
    } else if (bmi >= 30) {
      result = 'Obese (Class 2)';
    } else if (bmi >= 25) {
      result = 'Obese (Class 1)';
    } else if (bmi >= 23) {
      result = 'Overweight';
    } else if (bmi >= 18.5) {
      result = 'Normal';
    }
    return result;
  }

  Widget _buildIcon(double bmi) {
    if (bmi >= 23) {
      return Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.red,
        size: 100,
      );
    } else if (bmi >= 18.5) {
      return Icon(
        Icons.sentiment_satisfied,
        color: Colors.green,
        size: 100,
      );
    } else {
      return Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.orange,
        size: 100,
      );
    }
  }
}


