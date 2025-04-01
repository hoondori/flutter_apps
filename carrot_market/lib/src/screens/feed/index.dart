import 'dart:math';

import 'package:carrot_market/src/controllers/feed_controller.dart';
import 'package:carrot_market/src/widgets/listitems/feed_list_item.dart';
import 'package:flutter/material.dart';
import 'package:carrot_market/src/widgets/buttons/category_button.dart';
import 'package:get/get.dart';

class FeedIndex extends StatefulWidget {
  const FeedIndex({super.key});

  @override
  State<FeedIndex> createState() => _FeedIndexState();
}

class _FeedIndexState extends State<FeedIndex> {

  // state management by GetX
  final FeedController feedController = Get.put(FeedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("내 동네"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.text_rotation_none_rounded)),
        ]
      ),
      body: Column(
        children: [
          // 카테고리바
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryButton(icon: Icons.menu),
                SizedBox(width: 12,),
                CategoryButton(icon: Icons.search, title: "알바"),
                SizedBox(width: 12,),
                CategoryButton(icon: Icons.home, title: "부동산",),
                SizedBox(width: 12,),
                CategoryButton(icon: Icons.car_crash, title: "중고차",),
              ],
            ),
          ),

          // 중고 거래 목록
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: feedController.feedList.length,
                itemBuilder: (context, index) {
                  final item = feedController.feedList[index];
                  return FeedListItem(item);
                },
              )
            )
          )
        ],
      ),
      // 임의 물품 추가 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: feedController.addData,
        child: const Icon(Icons.add),
      ),
    );
  }
}
