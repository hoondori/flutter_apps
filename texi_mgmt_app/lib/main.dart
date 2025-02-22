import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Management App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ControllerPage(title: 'Texi Managment System'),
    );
  }
}

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key, required this.title});

  final String title;

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  var _index = 0;
  final _pages = [HomePage(), ServicePage(), MyInfoPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.black,
              )),
        ],
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          currentIndex: _index,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment), label: 'Service'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'My Info'),
          ]),
    );
  }
}
final dummyImages = [
  'assets/images/safari.jpg',
  'assets/images/tajikistan.jpg',
  'assets/images/thanksgiving.jpg'
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildTop(),
        _buildMiddle(),
        _buildBottom(),
      ],
    );
  }

  Widget _buildTop() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {print('클릭 0-0');},
                child: Column(
                  children: [
                    Icon(Icons.local_taxi, size: 40,),
                    Text('Taxi'),],
                ),
              ),
              GestureDetector(
                onTap: () {print('클릭 0-1');},
                child: Column(
                  children: [
                    Icon(Icons.local_taxi, size: 40,),
                    Text('Black'),],
                ),
              ),
              GestureDetector(
                onTap: () {print('클릭 0-2');},
                child: Column(
                  children: [
                    Icon(Icons.local_taxi, size: 40,),
                    Text('Bike'),],
                ),
              ),
              GestureDetector(
                onTap: () {print('클릭 0-3');},
                child: Column(
                  children: [
                    Icon(Icons.local_taxi, size: 40,),
                    Text('ServTaxi'),],
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {print('클릭 1-0');},
                child: Column(
                  children: [
                    Icon(Icons.local_taxi, size: 40,),
                    Text('Taxi'),],
                ),
              ),
              GestureDetector(
                onTap: () {print('클릭 1-1');},
                child: Column(
                  children: [
                    Icon(Icons.local_taxi, size: 40,),
                    Text('Black'),],
                ),
              ),
              GestureDetector(
                onTap: () {print('클릭 1-2');},
                child: Column(
                  children: [
                    Icon(Icons.local_taxi, size: 40,),
                    Text('Bike'),],
                ),
              ),
              Opacity(
                opacity: 0.0,
                child: Column(
                  children: [
                    Icon(Icons.local_taxi, size: 40,),
                    Text('Taxi'),],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildMiddle() {
    return CarouselSlider(
      items: dummyImages.map((image_path) {
        return Builder(builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: const BoxDecoration(
              color: Colors.amber
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(image_path, fit: BoxFit.cover),
            )
          );
        });
      }).toList(),
      options: CarouselOptions(height: 150.0)
    );
  }
  Widget _buildBottom() {
    final items = List.generate(10, (i) {
      return ListTile(
        leading: Icon(Icons.notifications_none),
        title: Text('[Event: $i] This is notification'),
      );
    });

    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: items,
    );
  }
}

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Service Page')),
      body: Text('Service Page Content'),
    );
  }
}

class MyInfoPage extends StatelessWidget {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Info Page')),
      body: Text('My Info Page Content'),
    );
  }
}
