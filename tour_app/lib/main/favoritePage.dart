import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tour_app/data/tour.dart';
import 'package:tour_app/main/tourDetailPage.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key, required this.database});

  final Future<Database>? database;

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Future<List<TourData>>? _tourList;

  @override
  void initState() {
    super.initState();
    _tourList = getTours();
  }

  Future<List<TourData>> getTours() async {
    // DB에서 읽어오기
    final Database databaseImpl = await widget.database!;

    final List<Map<String, dynamic>> maps = await databaseImpl.query('place');
    print('maps: ${maps.length}');
    return List.generate(maps.length, (i) {
      return TourData(
        id: maps[i]['id']?.toString() ?? '',  // null 체크
        title: maps[i]['title']?.toString() ?? '',
        tel: maps[i]['tel']?.toString() ?? '',
        zipcode: maps[i]['zipcode']?.toString() ?? '',
        address: maps[i]['address']?.toString() ?? '',
        mapx: maps[i]['mapx'] != null ? double.tryParse(maps[i]['mapx'].toString()) ?? 0.0 : 0.0,
        mapy: maps[i]['mapy'] != null ? double.tryParse(maps[i]['mapy'].toString()) ?? 0.0 : 0.0,
        imagePath: maps[i]['imagePath']?.toString() ?? '',
      );
    });
  }

  ImageProvider _getImage(String? imagePath) {
    if (imagePath != null && imagePath != '') {
      return NetworkImage(imagePath);
    } else {
      // 기본 이미지
      return AssetImage('assets/images/map_location.jpg');
    }
  }

  Widget showTour(TourData info, int index) {
    return Card( // 각각의 tourData를 카드로 표시
      child: InkWell(
        child: Row(
          children: [
            Hero(
              tag: 'favorite_tourinfo$index',
              child: Container(
                margin: EdgeInsets.all(10),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1),
                    image: DecorationImage(
                      image: _getImage(info.imagePath),
                      fit: BoxFit.fill,
                    )
                ),
              ),
            ),
            SizedBox(width: 20,),
            Container(
              child: Column(
                children: [
                  Text(info.title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  Text('주소: ${info.address!}'),
                  info.zipcode != null ? Text('zipcode: ${info.zipcode!}') : Container(),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              width: MediaQuery.of(context).size.width - 150,
            )
          ],
        ),
        onTap: () {   // 눌렀을 때 상세 페이지로 이동한다.
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TourDetailPage(
                tourData: info,
              )));
        },
        onDoubleTap: () { // 더블탭시에 즐겨찾기에서 삭제
          _deleteTour(widget.database!, info);
        },
      ),
    );
  }

  void _deleteTour(Future<Database> db, TourData info) async {
    final Database database = await db;
    await database
      .delete('place', where: 'title=?', whereArgs: [info.title])
      .then((value) {
        setState(() {
          _tourList = getTours();
        });
      });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("즐겨찾기를 해제합니다: ${info.title}")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("즐겨찾기",)),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemBuilder: (context, index) {
                          List<TourData> tourList = snapshot.data as List<TourData>;
                          TourData info = tourList[index];
                          return showTour(info, index);
                        },
                      itemCount: (snapshot.data!).length,
                    );
                  } else {
                    Text("No data");
                  }
              }
              return CircularProgressIndicator();
            },
            future: _tourList,
          ),
        ),
      )
    );
  }
}
