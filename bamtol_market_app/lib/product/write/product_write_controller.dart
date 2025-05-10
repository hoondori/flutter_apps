import 'package:bamtol_market_app/common/components/app_font.dart';
import 'package:bamtol_market_app/common/model/product.dart';
import 'package:bamtol_market_app/common/repository/cloud_firebase_storage_repository.dart';
import 'package:bamtol_market_app/product/repository/product_repository.dart';
import 'package:bamtol_market_app/product/write/product_category_type.dart';
import 'package:bamtol_market_app/user/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class ProductWriteController extends GetxController {
  final UserModel owner;
  final ProductRepository _productRepository;
  RxList<AssetEntity> selectedImages = <AssetEntity>[].obs;
  Rx<Product> product = const Product().obs;
  RxBool isPossibleSubmit = false.obs;
  final CloudFirebaseRepository _cloudFirebaseRepository;

  ProductWriteController(this.owner, this._productRepository, this._cloudFirebaseRepository);


  @override
  void onInit() {
    super.onInit();
    product.stream.listen((event) {
      _isValidSubmitPossible();
    });
  }

  _isValidSubmitPossible() {
    if ((product.value.productPrice ?? 0) >=0 && product.value.title != '') {
      isPossibleSubmit(true);
    } else {
      isPossibleSubmit(false);
    }
  }

  changeSelectedImages(List<AssetEntity>? images) {
    selectedImages(images);
  }

  deleteImage(int index) {
    selectedImages.removeAt(index);
  }

  changeTitle(String value) {
    product(product.value.copyWith(title: value));
  }

  changeCategoryType(ProductCategoryType? type){
    product(product.value.copyWith(categoryType: type));
  }

  changePrice(String price) {
    // 숫자로만 구성된 문자열이 아니면 셋팅하지 않음
    if (!RegExp(r'^[0-9]+$').hasMatch(price)) return;
    product(product.value.copyWith(   // 가격을 0으로 셋팅하면 '무료' 표시
      productPrice: int.parse(price),
      isFree: int.parse(price) == 0
    ));
  }

  changeIsFreeProduct() {
    product(product.value.copyWith(isFree: !(product.value.isFree ?? false)));
    // 무료 상품으로 체크되면 가격을 0으로 변경한다.
    if (product.value.isFree!) {
      changePrice('0');
    }
  }

  changeDescription(String value) {
    product(product.value.copyWith(description: value));
  }

  changeTraceLocationMap(Map<String, dynamic>  mapInfo) {
    product(product.value.copyWith(
      wantTradeLocation: mapInfo['location'],
      wantTradeLocationLabel: mapInfo['label']
    ));
  }

  clearWantTradeLocation() {
    product(product.value.copyWith(wantTradeLocationLabel: '', wantTradeLocation: null));
  }

  submit() async {
    var downloadUrls = await uploadImages(selectedImages);
    product(product.value.copyWith(imageUrls: downloadUrls));
    var saveId = await _productRepository.saveProduct(product.value.toMap());
    if (saveId != null) {
      await showDialog(
        context: Get.context!,
        builder: (context) {
          return CupertinoAlertDialog(
            content: const AppFont(
              '물건이 등록되었습니다',
              color: Colors.black,
              size: 16,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const AppFont(
                  '확인',
                  size: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                )
              )
            ],
          );
        }
      );
      Get.back(result: true);
    }
  }

  Future<List<String>> uploadImages(List<AssetEntity> images) async {
    List<String> imageUrls = [];
    for (var image in images) {
      var file = await image.file;
      if (file == null) return [];
      var downloadUrl = await _cloudFirebaseRepository.uploadFile(owner.uid!, file);
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }
}