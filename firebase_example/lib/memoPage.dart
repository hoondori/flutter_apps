import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'memoAddPage.dart';
import 'memoDetail.dart';
import 'memo.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  FirebaseDatabase? _database;
  DatabaseReference? _reference;
  List<Memo> memos = new List.empty(growable: true);
  BannerAd? _banner;
  bool _loadingBanner = false;

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase.instance;

    _reference = _database!.ref().child('memo'); // 기본 DB에 연결해서 memo라는 컬렉션 생성

    // DB에 데이터가 추가되면 호출되서 memo list에 memo instance 추가
    _reference!.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
      print(memos.length);
      print(memos[0]);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _banner?.dispose();
  }

  Widget drawGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: memos.length,
      itemBuilder: (context, index) {
        return Card(
          child: GridTile(
            child: Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: SizedBox(
                child: GestureDetector(
                    child: Text(memos[index].content!),
                    onTap: () async {
                      // 데이터 수정
                      Memo? memo = await Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) =>
                              MemoDetailPage(_reference!, memos[index])));
                      if (memo != null) {
                        setState(() {
                          memos[index].title = memo.title;
                          memos[index].content = memo.content;
                        });
                      }
                    },
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(memos[index].title!),
                            content: Text('삭제하시겠습니까?'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    _reference!
                                        .child(memos[index].key!)
                                        .remove()
                                        .then((_) {
                                      setState(() {
                                        memos.removeAt(index);
                                        Navigator.of(context).pop();
                                      });
                                    });
                                  },
                                  child: Text('예')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('아니요')),
                            ],
                          );
                        });
                      },
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Future<void> _createBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size =
      await AdSize.getAnchoredAdaptiveBannerAdSize(
        Orientation.portrait,
        MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      return;
    }
    final BannerAd banner = BannerAd(
      size: size,
      adUnitId: "BannerAd testAdUnitId",
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded');
          setState(() {
            _banner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failed to load: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) =>print('$BannerAd onAdOpended'),
        onAdClosed: (Ad ad) =>print('$BannerAd onAdClosed'),
      ),
      request: AdRequest(),
    );

    return banner.load();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loadingBanner) {
      _loadingBanner = true;
      _createBanner(context);
    }
    return Scaffold(
      appBar: AppBar(title: Text('Memo app')),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            child: Center(
                child: memos.length == 0
                    ? CircularProgressIndicator()
                    : drawGrid()
            ),
          ),
          if (_banner != null)
            Container(
              color: Colors.green,
              width: _banner!.size.width.toDouble(),
              height: _banner!.size.height.toDouble(),
              child: AdWidget(ad: _banner!),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MemoAddApp(_reference!)));
        },
        child: Icon(Icons.add)
      )
    );
  }
}


