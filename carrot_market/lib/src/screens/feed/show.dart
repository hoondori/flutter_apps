import 'package:carrot_market/src/models/feed_model.dart';
import 'package:flutter/material.dart';

class FeedShow extends StatelessWidget {
  final FeedModel item;
  const FeedShow(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${item.title} 텀블러 팔기"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.content),
            Text("가격: ${item.price} 원"),
          ],
        ),
      ),
    );
  }
}

