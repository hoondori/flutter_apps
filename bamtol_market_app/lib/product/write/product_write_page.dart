import 'package:bamtol_market_app/common/components/app_font.dart';
import 'package:bamtol_market_app/common/components/checkbox.dart';
import 'package:bamtol_market_app/common/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class _HopeTradeLocationMap extends StatelessWidget {
  const _HopeTradeLocationMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.translucent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppFont('거래 희망 장소', size: 16, color: Colors.white,),
            Row(
              children: [
                const AppFont('장소 선택', size: 13, color: Color(0xff6D7179),),
                SvgPicture.asset("assets/svg/icons/right.svg"),
              ],
            )
          ],
        )
      ),
    );
  }
}


class _ProductDescription extends StatelessWidget {
  const _ProductDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: CommonTextField(
        hintColor: Color(0xff6D7179),
        hintText: '아라동에 올릴 게시글 내용을 작성해주세요.\n(판매 금지 물품은 게시가 제한될 수 있어요.)',
        textInputType: TextInputType.multiline,
        maxLines: 10,
        onChange: (value) {},
      ),
    );
  }
}


class _PriceSettingView extends StatelessWidget {
  const _PriceSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: CommonTextField(
              hintColor: Color(0xff6D7179),
              hintText: '\$ 가격 (선택사항)',
              textInputType: TextInputType.number,
            )
          ),
          CheckBox(
            label: '나늠',
            isChecked: true,
            toggleCallback: (){}
          )
        ],
      ),
    );
  }
}


class _CategorySelectView extends StatelessWidget {
  const _CategorySelectView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: GestureDetector(
        onTap: () async {},
        behavior: HitTestBehavior.translucent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppFont('카테고리 선택', size:16, color: Colors.white),
            SvgPicture.asset("assets/svg/icons/right.svg")
          ],
        ),
      )
    );
  }
}


class _PhotoSelectedView extends StatelessWidget {
  const _PhotoSelectedView({super.key});

  Widget _photoSelectIcon() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 77, height: 77,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xff42464E)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svg/icons/camera.svg"),
            const SizedBox(height: 5,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppFont('0', size:13, color: Color(0xff868B95)),
                AppFont('/10', size:13, color: Color(0xff868B95)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _selectedImageList() {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      height: 77,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:10, right: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    width: 67, height: 67,
                    child: Container(
                      color: Colors.red,
                      child: Center(child: AppFont(index.toString())),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                child: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset("assets/svg/icons/remove.svg"),
                )
              )
            ],
          );
        },
        itemCount: 5,
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Row(
        children: [
          _photoSelectIcon(), // 상품 이미지 등록
          Expanded(child: _selectedImageList()), // 등록된 상품 이미지들 나열
        ],
      ),
    );
  }
}

class _ProductTitleView extends StatelessWidget {
  const _ProductTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: '글 제목',
          hintStyle: TextStyle(
            color: Color(0xff6D7179),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          )
        ),
        onChanged: (v) {},
      ),
    );
  }
}


class ProductWritePage extends StatelessWidget {
  const ProductWritePage({super.key});

  Widget get _divider => const Divider(
    color: Color(0xff3C3C3E),
    indent: 25,
    endIndent: 25,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset("assets/svg/icons/close.svg"),
          ),
        ),
        centerTitle: true,
        title: const AppFont('내 물건 팔기', fontWeight: FontWeight.bold, size: 10,),
        actions: [
          GestureDetector(
            onTap: () {},
            child: AppFont('완료', fontWeight: FontWeight.bold, color: Color(0xffED7738), size: 16,),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _PhotoSelectedView(),
                  _divider,
                  _ProductTitleView(),
                  _divider,
                  _CategorySelectView(),
                  _divider,
                  _PriceSettingView(),
                  _divider,
                  _ProductDescription(),
                  Container(
                    height: 5,
                    color: Color.fromARGB(255, 12, 12, 15),
                  ),
                  _HopeTradeLocationMap(),
                ],
              ),
            ),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xff3C3C3E),
                )
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/svg/icons/photo_small.svg"),
                    const SizedBox(width: 10,),
                    const AppFont('0/10', size: 13, color: Colors.white),
                  ],
                ),
                GestureDetector(
                  onTap: FocusScope.of(context).unfocus,
                  behavior: HitTestBehavior.translucent,
                  child: SvgPicture.asset("assets/svg/icons/keyboard-down.svg"),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
