import 'package:carrot_market/src/screens/feed/edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 이미지 크기
const double _imageSize = 110;

class FeedListItem extends StatelessWidget {
  final Map item;
  const FeedListItem(this.item, {super.key});


  Widget drawImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(
        "https://picsum.photos/200",
        width: _imageSize,
        height: _imageSize,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget drawInformation(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 판매할 물건 재목
            Text(
              item['title'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  '동네이름',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  ' ・ N 분전',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            // 물품 가격
            Text(
              item['price'].toString(),
              style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawLowerRightIcons(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 0,
      child: Row(
        children: [
          Icon(
            Icons.chat_bubble_outline,
            color: Colors.grey,
            size: 16,
          ),
          SizedBox(width: 2),
          Text(
            '1',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(width: 4),
          Icon(
            Icons.favorite_border,
            color: Colors.grey,
            size: 16,
          ),
          SizedBox(width: 2),
          Text(
            '1',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => FeedEdit(item: item)),
        // );
        Get.to(() => FeedEdit(item: item));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이미지 영역
                drawImage(context),

                // 정보 영역
                drawInformation(context),

                // 기타 영역
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                    size: 16,
                  ),
                )
              ],
            ),

            // 채팅, 관심 물건 창 배치
            drawLowerRightIcons(context),
          ],
        ),
      ),
    );
  }
}

