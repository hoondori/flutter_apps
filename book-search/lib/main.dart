import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

void main() async{
  await dotenv.load(fileName: 'assets/config/.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Info Downloader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BookInfoPage(title: 'Book Info Downloader'),
    );
  }
}

class BookInfoPage extends StatefulWidget {
  const BookInfoPage({super.key, required this.title});

  final String title;

  @override
  State<BookInfoPage> createState() => _BookInfoPageState();
}

class _BookInfoPageState extends State<BookInfoPage> {
  String result = "";
  List? _data;
  TextEditingController? _queryController;
  // scroll
  int _page = 1;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _data = new List.empty(growable: true);
    _queryController = new TextEditingController();
    _scrollController = new ScrollController();
    // scroll을 해서 바닥 경계를 넘어서면 새로운 데이터를 가져온다.
    _scrollController!.addListener(() {
      if( _scrollController!.offset >=
          _scrollController!.position.maxScrollExtent) {
        print("touch bottom");
        _page++;
        _getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: TextField(
          controller: _queryController,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(hintText: '검색어를 입력하세요'),
        ),
      ),
      body: Container(
       child: Center(
         child: _data!.length == 0 ? Text("$result") : ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                child: Row(
                  children: [
                    Image.network(
                      _data![index]['thumbnail'],
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 150,
                          child: Text(_data![index]['title'].toString(), textAlign: TextAlign.center),
                        ),
                        Text(_data![index]['authors'].toString()),
                        Text(_data![index]['sale_price'].toString()),
                        Text(_data![index]['status'].toString()),
                      ],
                    ),
                  ],
                )
              )
            );
          },
          itemCount: _data!.length,
          controller: _scrollController,
         ),
       ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _page = 1;
          _data!.clear();
          _getData();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<String> _getData() async {
    var query = _queryController?.value.text;
    var page = _page;
    var url = 'https://dapi.kakao.com/v3/search/book?target=title&page=$page&query=$query';
    var appKey = dotenv.env['KAKAO_REST_API_KEY'];
    var response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "KakaoAK $appKey"}
    );
    setState(() {
      var json = jsonDecode(response.body);
      List result = json['documents'];
      _data!.clear();
      _data!.addAll(result);
    });

    return response.body;
  }
}
