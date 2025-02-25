import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendDataExample extends StatefulWidget {
  const SendDataExample({super.key});

  @override
  State<SendDataExample> createState() => _SendDataExampleState();
}

class _SendDataExampleState extends State<SendDataExample> {
  // Channel 생성
  static const platform = const MethodChannel('com.hoondori.dev/info');
  TextEditingController _controller = new TextEditingController();
  String _encryptedText = 'Nothing';
  String _decryptedText = 'Nothing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Send Data Example"),),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20,),
              Text(_encryptedText, style: TextStyle(fontSize: 20),),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  _decrypt(_encryptedText);
                },
                child: Text("디코딩하기")
              ),
              Text(_decryptedText, style: TextStyle(fontSize: 20),)
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _encrypt(_controller.value.text);
        },
        child: Text("변환"),
      ),
    );
  }

  Future<void> _encrypt(String text) async {
    final String result = await platform.invokeMethod("getEncrypt", text);
    print(result);
    setState(() {
      _encryptedText = result;
    });
  }

  Future<void> _decrypt(String text) async {
    final String result = await platform.invokeMethod("getDecrypt", text);
    setState(() {
      _decryptedText = result;
    });
  }
}
