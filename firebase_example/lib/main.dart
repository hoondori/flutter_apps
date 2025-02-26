import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'tabsPage.dart';
import 'memoPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 초기화
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: FirebaseApp(
      //   title: 'Firebase Example',
      //   analytics: analytics,
      //   observer: observer,
      // ),
      // home: MemoPage(),
      home: FutureBuilder(
          future: Firebase.initializeApp(), // 비동기 처리해야 하는 함수
          builder: (context, snapshot) {
            // 선언시 에러가 나면 출력될 위젯
            if (snapshot.hasError) {
              return Center(child: Text("Error"));
            }

            // 선언 완료 후 표시할 위젯
            if (snapshot.connectionState == ConnectionState.done) {
              _initFirebaseMessaging(context);
              _getToken();
              return MemoPage();
            }

            // 선언되는 동안 표시할 위젯
            return Center(
              child: CircularProgressIndicator()
            );
          }
      )

    );
  }

  void _initFirebaseMessaging(BuildContext context) {
    // FCM 메시지 수신시
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print(event.notification!.title);
      print(event.notification!.body);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("알림"),
            content: Text(event.notification!.body!),
            actions: [
              TextButton(onPressed: () {Navigator.of(context).pop();}, child: Text('OK')),
            ],
          );
        }
      );
    });

    // FCM 알림 클릭 시 동작
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){});
  }

  // 출력된 FCM token 을 firebase 쪽에 등록한다.
  void _getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    print("messaging.getToken(), ${await messaging.getToken()}");
  }
}



class FirebaseApp extends StatefulWidget {
  const FirebaseApp({super.key, required this.title, required this.analytics, required this.observer});

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<FirebaseApp> createState() => _FirebaseAppState(analytics, observer);
}

class _FirebaseAppState extends State<FirebaseApp> {
  _FirebaseAppState(this.analytics, this.observer);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  String _message = '';


  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticEvent() async {
    print("here");
    await analytics.logEvent(
      name: 'test_event',
      parameters: {
        'string': 'hello !!',
        'int': 100,
      },
    );

    setMessage('Sent Analytics');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: _sendAnalyticEvent, child: Text("Send Analytic Event")),
            Text(_message, style: const TextStyle(color: Colors.blueAccent)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<TabsPage>(
            settings: RouteSettings(name: '/tab'),
            builder: (BuildContext context) {
              return TabsPage(observer: observer);
            }
          ));
        }
      ),
    );
  }
}
