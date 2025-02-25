import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'sendDataExample.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS) {
      return CupertinoApp(
        home: CupertinoNativeApp(title: 'IOS Native App'),
      );
    }
    return MaterialApp(
      title: 'Android Native App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      //home: const NativeApp(title: 'Android Native App'),
      home: const SendDataExample(),
    );
  }
}

class CupertinoNativeApp extends StatefulWidget {
  const CupertinoNativeApp({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => _NativeAppState();
}

class NativeApp extends StatefulWidget {
  const NativeApp({super.key, required this.title});

  final String title;

  @override
  State<NativeApp> createState() => _NativeAppState();
}

class _NativeAppState extends State<NativeApp> {
  // Channel 생성
  static const platform = const MethodChannel('com.hoondori.dev/info');
  String _deviceInfo = "Unknown info";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_deviceInfo, style: TextStyle(fontSize: 30),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _getDeviceInfo();
        },
        child: Icon(Icons.get_app),
      ),
    );
  }

  Future<void> _getDeviceInfo() async {
    String deviceInfo;
    try {
      final String result = await platform.invokeMethod("getDeviceInfo");
      deviceInfo = 'Device Info: $result';
    } on PlatformException catch(e) {
      deviceInfo = 'Failed to get Device Info: ${e.message}';
    } on Exception catch(e) {
      deviceInfo = 'Failed to get Device Info: ${e.toString()}';
    }
    setState(() {
      _deviceInfo = deviceInfo;
    });
  }
}

