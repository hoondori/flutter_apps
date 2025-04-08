import 'package:carrot_market/shared/data.dart';
import 'package:carrot_market/src/screens/auth/register.dart';
import 'package:carrot_market/src/screens/feed/show.dart';
import 'package:carrot_market/src/screens/unknown.dart';
import 'package:carrot_market/src/screens/home.dart';
import 'package:flutter/material.dart';
import 'screens/auth/intro.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carrot Market',
      routes: {
        '/': (context) => const Home(),
        '/intro': (context) => const Intro(),
        '/register': (context) => const Register(),
      },
      initialRoute: '/intro',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6f07),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFFFF6f0f),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 18, fontFamily: 'Noto Sans'),
          bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Noto Sans'),
          labelLarge: TextStyle(fontSize: 16, fontFamily: 'Noto Sans', fontWeight: FontWeight.bold)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF7E36),
            padding: const EdgeInsets.symmetric(vertical: 22),
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            )
          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFFF7E36),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          )
        )
      )
    );
  }
}