import 'package:bamtol_market_app/common/controller/authentication_controller.dart';
import 'package:bamtol_market_app/common/controller/bottom_nav_controller.dart';
import 'package:bamtol_market_app/common/controller/data_load_controller.dart';
import 'package:bamtol_market_app/firebase_options.dart';
import 'package:bamtol_market_app/home/page/home_page.dart';
import 'package:bamtol_market_app/login/controller/login_controller.dart';
import 'package:bamtol_market_app/login/page/login_page.dart';
import 'package:bamtol_market_app/root.dart';
import 'package:bamtol_market_app/splash/controller/splash_controller.dart';
import 'package:bamtol_market_app/user/repository/authentication_repository.dart';
import 'package:bamtol_market_app/user/repository/user_repository.dart';
import 'package:bamtol_market_app/user/signup/controller/signup_controller.dart';
import 'package:bamtol_market_app/user/signup/page/signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var authenticationRepository =
        AuthenticationRepository(FirebaseAuth.instance);
    var db = FirebaseFirestore.instance;
    var userRepository = UserRepository(db);
    return GetMaterialApp(
      title: '당근마켓 클론 코딩',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Color(0xff212123),
            titleTextStyle: TextStyle(
              color: Colors.white,
            )
        ),
        scaffoldBackgroundColor: const Color(0xff212123)
      ),
      initialBinding: BindingsBuilder((){
        Get.put(userRepository);
        Get.put(authenticationRepository);
        Get.put(SplashController());
        Get.put(DataLoadController());
        Get.put(BottomNavController());
        Get.put(AuthenticationController(
            authenticationRepository,
            userRepository
        ));
      }),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const App()),
        GetPage(name: '/home', page: () => const Root()),
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut<LoginController>(() => LoginController(Get.find<AuthenticationRepository>()));
          })
        ),
        GetPage(
          name: '/signup/:uid',
          page: () => const SignupPage(),
          binding: BindingsBuilder((){
            Get.create<SignupController>(
              () => SignupController(Get.find<UserRepository>(),
                Get.parameters['uid'] as String),
            );
          })
        ),
      ]
    );
  }
}