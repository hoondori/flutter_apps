import 'package:flutter/material.dart';
import 'package:bamtol_market_app/main.dart';
import 'package:bamtol_market_app/splash/page/splash_page.dart';
import 'package:bamtol_market_app/init/page/init_start_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late bool isInitStarted; // 앱 최초 실행 여부

  @override
  void initState() {
    super.initState();
    isInitStarted = prefs.getBool('isInitStarted') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return isInitStarted
        ? InitStartPage(
          onStart: () {
            setState(() {
              isInitStarted = false;
            });
            print('babo');
            prefs.setBool('isInitStarted', isInitStarted);
          },
        )
        : const SplashPage();
  }
}
