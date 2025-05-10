import 'package:bamtol_market_app/app.dart';
import 'package:bamtol_market_app/common/components/app_font.dart';
import 'package:bamtol_market_app/common/layout/common_layout.dart';
import 'package:flutter/material.dart';
import 'package:bamtol_market_app/common/controller/authentication_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';



class _ProductList extends StatelessWidget {
  const _ProductList({super.key});

  Widget _productOne(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.network(
              'https://cdn.kgmaeil.net/news/photo/202007/245825_49825_2217.jpg'
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10,),
              AppFont(
                'Yammj 상품$index 무료로 드려요 :) ',
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(height: 5,),
              const AppFont(
                'fly sky - 2025.05.05',
                size: 12,
                color: Color(0xff878B93),
              ),
              const SizedBox(height: 5,),
              const Row(
                children: [
                  AppFont('나눔', size: 14, fontWeight: FontWeight.bold,),
                  AppFont('🧡', size: 16),
                ],
              )
            ],
          )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 25.0, top: 20, right: 25),
      itemBuilder: (context, index) {
        return _productOne(index);
      },
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Divider(color: Color(0xff3C3C3E)),
      ),
      itemCount: 10
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      appBar: AppBar(
        leadingWidth: Get.width * 0.6,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(
            children: [
              const AppFont(
                '아라동',
                fontWeight: FontWeight.bold,
                size: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 10,),
              SvgPicture.asset("assets/svg/icons/bottom_arrow.svg"),
            ],
          )
        ),
        actions: [
          SvgPicture.asset('assets/svg/icons/search.svg'),
          const SizedBox(width: 15,),
          SvgPicture.asset('assets/svg/icons/list.svg'),
          const SizedBox(width: 15,),
          SvgPicture.asset('assets/svg/icons/bell.svg'),
          const SizedBox(width: 15,),
        ],
      ),
      body: const _ProductList(),
      floatingActionButton: GestureDetector(
        onTap: () async {
          Get.toNamed('/product/write');
        },
        behavior: HitTestBehavior.translucent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0xffED7738),
              ),
              child: Row(
                children: [
                  SvgPicture.asset("assets/svg/icons/plus.svg"),
                  const SizedBox(width: 6,),
                  const AppFont('글쓰기', size: 16, color: Colors.white,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
