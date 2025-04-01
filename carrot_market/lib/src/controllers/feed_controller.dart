import 'dart:math';
import 'package:get/get.dart';

class FeedController extends GetxController {
  RxList<Map> feedList = <Map>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  _initializeData() {
    List<Map<String, dynamic>> sample = [
      {
        'id': 1,
        'title': '텀블러',
        'content': '텀블러 팝니다',
        'price': 500,
      },
      {
        'id': 2,
        'title': '머그잔',
        'content': '머그잔 팝니다',
        'price': 300,
      },
    ];

    feedList.assignAll(sample);
  }

  void addData() {
    final random = Random();
    final newItem = {
      'id': random.nextInt(100),
      'title': '제목 ${random.nextInt(100)}',
      'content': '설명 ${random.nextInt(100)}',
      'price': 500 + random.nextInt(49500)
    };
    feedList.add(newItem);
    print('new addeds');
  }

  void updateData(Map newData) {
    final id = newData['id'];
    final index = feedList.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      feedList[index] = newData;
    }
  }
}