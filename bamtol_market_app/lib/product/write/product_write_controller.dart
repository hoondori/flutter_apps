import 'package:bamtol_market_app/common/model/product.dart';
import 'package:bamtol_market_app/product/repository/product_repository.dart';
import 'package:bamtol_market_app/product/write/product_category_type.dart';
import 'package:bamtol_market_app/user/model/user_model.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class ProductWriteController extends GetxController {
  final UserModel owner;
  final ProductRepository _productRepository;
  RxList<AssetEntity> selectedImages = <AssetEntity>[].obs;
  Rx<Product> product = const Product().obs;
  ProductWriteController(this.owner, this._productRepository);


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
}