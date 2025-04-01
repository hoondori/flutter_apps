import 'package:carrot_market/src/controllers/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedEdit extends StatefulWidget {
  final Map item;
  const FeedEdit({required this.item, super.key});

  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {

  final FeedController feedController = Get.find<FeedController>();

  TextEditingController? titleController;
  TextEditingController? priceController;

  void _submit() {
    final updatedItem = {
      ...widget.item,
      'title': titleController!.text,
      'price': int.tryParse(priceController!.text)
          ?? widget.item['price']
    };

    feedController.updateData(updatedItem);

    Get.back();
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.item['title']);
    priceController = TextEditingController(text: widget.item['price'].toString());
  }

  @override
  void dispose() {
    titleController?.dispose();
    priceController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("물품 수정"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                )
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                )
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('완료')
            )
          ],
        ),
      ),
    );
  }
}
