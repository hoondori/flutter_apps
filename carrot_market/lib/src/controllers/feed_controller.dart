import 'dart:math';
import 'package:get/get.dart';
import 'package:carrot_market/src/providers/feed_provider.dart';
import 'package:carrot_market/src/models/feed_model.dart';

class FeedController extends GetxController {
  final feedProvider = Get.put(FeedProvider());
  RxList<FeedModel> feedList = <FeedModel>[].obs;

  feedIndex(int page) async {
    Map json = await feedProvider.getList(page: page);
    List<FeedModel> tmp = json['data'].map((m) => FeedModel.parse(m)).toList();
    (page == 1) ? feedList.assignAll(tmp) : feedList.addAll(tmp);
  }

  void addData() {
    final random = Random();
    final newItem = FeedModel.parse({
      'id': random.nextInt(100),
      'title': '제목 ${random.nextInt(100)}',
      'content': '설명 ${random.nextInt(100)}',
      'price': 500 + random.nextInt(49500)
    });
    feedList.add(newItem);
  }

  void updateData(FeedModel updatedItem) {
    final index = feedList.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      feedList[index] = updatedItem;
    }
  }
}
