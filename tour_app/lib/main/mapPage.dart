import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tour_app/data/tour.dart';
import 'package:http/http.dart' as http;
import '../data/listData.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  List<DropdownMenuItem<Item>> _areas = List.empty(growable: true);  // AREA 목록
  List<DropdownMenuItem<Item>> _kinds = List.empty(growable: true); // KIND 목록
  List<TourData> _tourData = List.empty(growable: true); // 조회된 정보 목록

  ScrollController? _scrollController;

  // FIXME
  String _authKey = "0S%2BuLGQrkXkxo0pRogfUO6CxXH4wB1Zf4%2BlFL%2BeNX3fN8IL5d38da4QpEil5Y8693Oo%2B9mJeSrKLAs6mOTKnvA%3D%3D";

  Item? _area; // 선택된 area
  Item? _kind; // 선택된 kind
  int page = 1;

  @override
  void initState() {
    super.initState();

    _areas = Area().seoulArea;
    _kinds = Kind().kinds;

    _area = _areas[0].value;
    _kind = _kinds[0].value;

    _scrollController = new ScrollController();
    _scrollController!.addListener(() {
      // if( _scrollController!.offset >=
      //     _scrollController!.position.maxScrollExtent) {
      //
      // }
      if (_scrollController!.offset >= _scrollController!.position.maxScrollExtent) {
        page++;
        print("touch bottom");
        print(page);
        _getAreaList(area: _area!.value, contentTypeId: _kind!.value, page: page);
      }
    });
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  // 데이터 fetch
  void _getAreaList({required int area, required int contentTypeId, required int page}) async {
    print('page: $page');
    var url = 'http://apis.data.go.kr/B551011/KorService1/areaBasedList1?numOfRows=10&pageNo=$page&MobileOS=AND&MobileApp=ModuTour&_type=json&areaCode=1&sigunguCode=$area&serviceKey=$_authKey';

    if (contentTypeId != 0) {
      url = url + '&contentTypeId=$contentTypeId';
    }
    print(url);

    var response = await http.get(Uri.parse(url));
    String body = utf8.decode(response.bodyBytes);
    print(body);
    var json = jsonDecode(body);
    if (json['response']['header']['resultCode'] == '0000') { // custom OK
      if (json['response']['body']['items'] == '') { // last page
        showDialog(context: context, builder: (context) {
          return AlertDialog(content: Text("마지막 페이지 입니다"));
        });
      } else {
        List jsonArray = json['response']['body']['items']['item'];
        for (var s in jsonArray) {
          print(s);
          setState(() {
            _tourData.add(TourData.fromJson(s));
          });
        }
      }
    } else {
      // nothing to do
      print('error');
    }
  }

  ImageProvider _getImage(String? imagePath) {
    if (imagePath != null && imagePath != '') {
      return NetworkImage(imagePath);
    } else {
      // 기본 이미지
      return AssetImage('assets/images/map_location.jpg');
    }
  }

  Widget _tourDataList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              child: Row(
                children: [
                  Hero(
                    tag: 'tourinfo$index',
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1),
                        image: DecorationImage(
                          image: _getImage(_tourData[index].imagePath),
                          fit: BoxFit.fill,
                        )
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    child: Column(
                      children: [
                        Text(_tourData[index].title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text('주소: ${_tourData[index].address!}'),
                        _tourData[index].tel != null ? Text('전화번호: ${_tourData[index].tel!}') : Container(),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                    width: MediaQuery.of(context).size.width - 150,
                  )
                ],
              )
            )
          );
        },
        itemCount: _tourData.length,
        controller: _scrollController,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("검색하기"),),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  DropdownButton( // AREA 선택
                    items: _areas,
                    onChanged: (value) {
                      Item selectedItem = value!;
                      setState(() {
                        _area = selectedItem;
                      });
                    },
                    value: _area,
                  ),
                  SizedBox(width: 10,),
                  DropdownButton( // KIND 선택
                      items: _kinds,
                      onChanged: (value) {
                        Item selectedItem = value!;
                        setState(() {
                          _kind = selectedItem;
                        });
                      },
                      value: _kind,
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton( // 검색 실행: 외부 API 호출
                    onPressed: () {
                      page = 1;
                      _tourData.clear();
                      _getAreaList(
                        area: _area!.value,
                        contentTypeId: _kind!.value,
                        page: page
                      );
                    },
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blueAccent)),
                    child: Text(
                      '검색하기',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              _tourDataList() // 조회된 tour data 목록을 ListView로 보여준다.
            ],
          ),
        ),
      ),
    );
  }
}

