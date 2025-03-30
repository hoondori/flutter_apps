import 'package:carrot_market/shared/data.dart';
import 'package:carrot_market/src/screens/auth/register.dart';
import 'package:carrot_market/src/screens/feed/show.dart';
import 'package:carrot_market/src/screens/unknown.dart';
import 'package:carrot_market/src/screens/home.dart';
import 'package:flutter/material.dart';
import 'screens/intro.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carrot Market',
      routes: {
        '/': (context) => const Home(),
        '/intro': (context) => const Intro(),
        '/register': (context) => const Register(),
      },
      initialRoute: '/',
      onGenerateRoute: (route) {
        // for /feed/id
        if (route.name!.startsWith('/feed')) {

          final id = int.parse(route.name!.split('/').last);
          final item = feedList.firstWhere((e) => e['id'] == id, orElse: () => {});

          if (item.isNotEmpty) {
            return MaterialPageRoute(
                builder: (context) => FeedShow(item));
          }
        }

        // the other route to unknown
        return MaterialPageRoute(
          builder: (context) => const UnknownScreen(),
        );
      },
    );
  }
}