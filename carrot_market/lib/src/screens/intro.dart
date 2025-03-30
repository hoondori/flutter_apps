import 'package:carrot_market/shared/data.dart';
import 'package:carrot_market/src/screens/auth/register.dart';
import 'package:carrot_market/src/screens/feed/show.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '이 책은 플러터로 \n SNS 중고 거래 애플리케이션을 만듭니다.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () => {
                //Navigator.pushNamed(context, "/register"),
                Navigator.pushNamed(context, "/feed/1"),
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => FeedShow(feedList[1])
                //   )
                // )
              },
              child: const Text("사용하러 가기")),
          ],
        )
      )
    );
  }
}
