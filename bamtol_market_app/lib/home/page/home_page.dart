import 'package:bamtol_market_app/app.dart';
import 'package:bamtol_market_app/common/components/app_font.dart';
import 'package:bamtol_market_app/common/components/price_view.dart';
import 'package:bamtol_market_app/common/layout/common_layout.dart';
import 'package:bamtol_market_app/common/model/product.dart';
import 'package:bamtol_market_app/home/controller/home_controller.dart';
import 'package:bamtol_market_app/product/write/product_category_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class _ProductList extends GetView<HomeController> {
  const _ProductList({super.key});

  Widget subInfo(Product product) {
    return Row(
      children: [
        AppFont(
          product.owner?.nickName ?? 'default nickname',
          color: const Color(0xff878993),
          size: 12,
        ),
        const AppFont(
          ' . ',
          color: const Color(0xff878993),
          size: 12,
        ),
        AppFont(
          DateFormat('yyyy.MM.dd').format(product.createdAt!),
          color: const Color(0xff878993),
          size: 12,
        )
      ],
    );
  }

  Widget _productOne(Product product) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/product/detail/${product.docId}');
      },
      behavior: HitTestBehavior.translucent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                product.imageUrls != null && product.imageUrls!.isNotEmpty
                  ? product.imageUrls!.first ?? ''
                  : 'https://cdn.kgmaeil.net/news/photo/202007/245825_49825_2217.jpg'
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
                  product.title ?? 'default product title',
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(height: 5,),
                subInfo(product),
                PriceView(
                  price: product.productPrice ?? 0,
                  status: product.status ?? ProductStatusType.sale,
                )
              ],
            )
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        padding: const EdgeInsets.only(left: 25.0, top: 20, right: 25),
        controller: controller.scrollController,
        itemBuilder: (context, index) {
          if (index == controller.productList.length) {
            return controller.searchOption.lastItem != null
                ? const Center(child: CircularProgressIndicator(strokeWidth: 1,),)
                : Container();
          } else {
            return _productOne(controller.productList[index]);
          }
        },
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Divider(color: Color(0xff3C3C3E)),
        ),
        itemCount: controller.productList.length + 1,
      ),
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
          var isNeedRefresh = await Get.toNamed('/product/write');
          if (isNeedRefresh is bool && isNeedRefresh) {
            Get.find<HomeController>().refresh();
          }
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
