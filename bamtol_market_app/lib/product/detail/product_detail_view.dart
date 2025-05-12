import 'package:bamtol_market_app/common/components/app_font.dart';
import 'package:bamtol_market_app/common/components/price_view.dart';
import 'package:bamtol_market_app/common/components/trade_location_map.dart' show SimpleTradeLocationMap;
import 'package:bamtol_market_app/common/components/user_temparature_widget.dart';
import 'package:bamtol_market_app/common/layout/common_layout.dart';
import 'package:bamtol_market_app/common/model/product.dart';
import 'package:bamtol_market_app/common/utils/data_util.dart';
import 'package:bamtol_market_app/product/repository/product_detail_controller.dart';
import 'package:bamtol_market_app/product/write/product_category_type.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class _UserProducts extends StatelessWidget {
  final Product product;
  final List<Product> ownerOtherProducts;
  const _UserProducts({
    super.key,
    required this.product,
    required this.ownerOtherProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppFont(
                '${product.owner?.nickName}님의 판매 상품',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                size: 15,
              ),
              GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.translucent,
                child: SvgPicture.asset('assets/svg/icons/right.svg'),
              )
            ],
          ),
        ),
        SizedBox(
          height: (ownerOtherProducts.length.clamp(0, 6) * 0.5).ceil() * 220,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.85,
            children: List.generate(
              ownerOtherProducts.length.clamp(0, 6),
                  (index) => GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: ownerOtherProducts[index].imageUrls!.isEmpty
                          ? const SizedBox(
                          height: 120,
                          child: Center(child: Icon(Icons.error)))
                          : SizedBox(
                        height: 120,
                        child: CachedNetworkImage(
                          imageUrl:
                          ownerOtherProducts[index].imageUrls!.first,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                strokeWidth: 1,
                              )),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    AppFont(
                      ownerOtherProducts[index].title ?? '',
                      maxLine: 1,
                      size: 14,
                    ),
                    const SizedBox(height: 5),
                    PriceView(
                      price: ownerOtherProducts[index].productPrice ?? 0,
                      status: ownerOtherProducts[index].status ??
                          ProductStatusType.sale,
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _HopeTradeLocation extends StatelessWidget {
  final Product product;
  const _HopeTradeLocation({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return product.wantTradeLocation != null
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppFont(
                '거래 희망 장소',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                size: 15,
              ),
              GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.translucent,
                child: SvgPicture.asset('assets/svg/icons/right.svg'),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 200,
              child: SimpleTradeLocationMap(
                myLocation: product.wantTradeLocation!,
                label: product.wantTradeLocationLabel,
                interactiveFlags: InteractiveFlag.pinchZoom,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(indent: 20, endIndent: 20, color: Color(0xff2C2C2E))
      ],
    )
        : Container();
  }
}


class _ProductDetail extends StatelessWidget {
  final Product product;
  const _ProductDetail({super.key, required this.product});

  Widget _statistic() {
    return Row(
      children: [
        AppFont(
          '관심  ${product.likers?.length ?? 0}',
          size: 12,
          color: const Color(0xff878B93),
        ),
        const AppFont(
          '  ·  ',
          size: 12,
          color: Color(0xff878B93),
        ),
        AppFont(
          '조회  ${product.viewCount}',
          size: 12,
          color: const Color(0xff878B93),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppFont(
            product.title ?? '',
            size: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              if (product.categoryType != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: AppFont(
                    product.categoryType?.name ?? '',
                    size: 12,
                    color: const Color(0xff878B93),
                    decoration: TextDecoration.underline,
                  ),
                ),
              AppFont(
                MarketDataUtils.timeagoValue(
                    product.createdAt ?? DateTime.now()),
                size: 12,
                color: const Color(0xff878B93),
              ),
            ],
          ),
          const SizedBox(height: 30),
          AppFont(
            product.description ?? '',
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(height: 30),
          _statistic(),
        ],
      ),
    );
  }
}


class _ProfileSection extends StatelessWidget {
  final Product product;

  const _ProfileSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return product.owner == null
      ? Container()
      : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: Image.asset('assets/images/default_profile.png').image,
              backgroundColor: Colors.black,
              radius: 23,
            ),
            const SizedBox(width: 15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppFont(
                    product.owner?.nickName ?? '',
                    size: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4,),
                  const AppFont(
                    '제주 어딘가',
                    size: 13,
                    color: Color(0xffABAEB6),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                UserTemperatureWidget(
                  temperature: product.owner?.temperature ?? 36.7
                ),
                const SizedBox(height: 5),
                const AppFont(
                  '매너온도',
                  decoration: TextDecoration.underline,
                  color: Color(0xffB7BB93),
                  size: 12,
                )
              ],
            )
          ],
        ),
      );
  }
}


class _ProductThumbnail extends StatelessWidget {
  final Product product;

  const _ProductThumbnail({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: Get.size.width - 40,
            viewportFraction: 1,
            aspectRatio: 0,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 3),
            enableInfiniteScroll: true,
            disableCenter: true,
            onScrolled: (value) {},
            onPageChanged: (int index, _) {}
          ),
          items: List.generate(
            product.imageUrls?.length ?? 0,
            (index) => CachedNetworkImage(
              imageUrl: product.imageUrls![index],
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    strokeWidth: 1,
                  ),
                ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          )
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              product.imageUrls?.length ?? 0,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, color: const Color(0xff212123),
                ),
              )
            ),
          )
        )
      ],
    );
  }
}

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                width: Get.width,
                height: Get.width,
                child: _ProductThumbnail(
                  product: controller.product.value,
                ),
              ),
              _ProfileSection(product: controller.product.value),
              _ProductDetail(product: controller.product.value),
              _HopeTradeLocation(product: controller.product.value),
              _UserProducts(
                product: controller.product.value,
                ownerOtherProducts: controller.ownerOtherProducts.value,
              )
            ],
          )
        )
      )
    );
  }
}
