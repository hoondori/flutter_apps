import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main/favoritePage.dart';
import 'main/settingPage.dart';
import 'main/mapPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  TabController? _controller;
  FirebaseDatabase? _database;
  DatabaseReference? _reference;
  String? id;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);

    // FIXME
    // 기본 DB에 연결해서 XXX 라는 컬렉션 생성
    _database = FirebaseDatabase.instance;
    _reference = _database!.ref().child('XXX');
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // route시에 전달된 사용자 ID
    id = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      body: TabBarView(
        children: [
          MapPage(),
          FavoritePage(),
          SettingPage(),
        ],
        controller: _controller,
      ),
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.map)),
          Tab(icon: Icon(Icons.star)),
          Tab(icon: Icon(Icons.settings)),
        ],
        labelColor: Colors.amber,
        indicatorColor: Colors.deepOrangeAccent,
        controller: _controller,
      ),
    );
  }
}

