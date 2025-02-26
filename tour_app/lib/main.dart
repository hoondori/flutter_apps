import 'package:flutter/material.dart';
import 'login.dart';
import 'signPage.dart';
import 'package:firebase_core/firebase_core.dart';
import  'mainPage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tour_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE place(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title TEXT, tel TEXT, zipcode TEXT, address TEXT, "
          "mapx Number, mapy Number, imagePath Text)"
        );
      },
      version: 1,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: '모두의 여행',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/sign': (context) => SignPage(),
        '/main': (context) => MainPage(database: database),
      }
    );
  }
}

