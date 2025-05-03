
import 'package:bamtol_market_app/common/components/app_font.dart';
import 'package:flutter/material.dart';

class MultifulImageView extends StatefulWidget {
  const MultifulImageView({super.key});

  @override
  State<MultifulImageView> createState() => _MultifulImageViewState();
}

class _MultifulImageViewState extends State<MultifulImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont(
          '최근 항목',
          fontWeight:
          FontWeight.bold,
          size: 18,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(top: 20.0, right: 25),
              child: AppFont(
                '완료',
                color: Color(0xffED7738),
                size: 16,
                fontWeight: FontWeight.bold,
              )
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: 100,
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1
              ),
              itemBuilder: (BuildContext context, int inde) {
                return Container(
                  color: Colors.red,
                );
              }
            )
          )
        ],
      ),
    );
  }
}
