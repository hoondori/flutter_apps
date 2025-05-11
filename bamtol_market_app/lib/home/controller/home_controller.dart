
import 'package:bamtol_market_app/common/model/product.dart';
import 'package:bamtol_market_app/common/model/product_search_option.dart';
import 'package:bamtol_market_app/product/repository/product_repository.dart';
import 'package:bamtol_market_app/product/write/product_category_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ProductRepository _productRepository;
  HomeController(this._productRepository);
  RxList<Product> productList = <Product>[].obs;
  ProductSearchOption searchOption = ProductSearchOption(
    status: const [
      ProductStatusType.sale,
      ProductStatusType.reservation
    ],
  );
  ScrollController scrollController = ScrollController();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProductList();
    _event();
  }

  void _event() {
    scrollController.addListener(() {
      if (scrollController.offset >
          scrollController.position.maxScrollExtent -100 &&
          searchOption.lastItem != null &&
          !isLoading.value
      ) {
        _loadProductList();
      }
    });
  }
  void _initData() {
    searchOption = searchOption.copyWith(lastItem: null);
    productList.clear();
  }

  void refresh() async {
    _initData();
    await _loadProductList();
  }

  Future<void> _loadProductList() async {
    isLoading(true);

    await Future.delayed(Duration(milliseconds: 1000));

    var result = await _productRepository.getProducts(searchOption);
    // lastItem 갱신
    if (result.lastItem != null) {
      searchOption = searchOption.copyWith(lastItem: result.lastItem);
    } else {
      searchOption = searchOption.copyWith(lastItem: null);
    }
    productList.addAll(result.list);

    print("fetch=${result.list.length}, "
        "lastItem=${result.lastItem}, "
        "total=${productList.length}");

    isLoading(false);
  }
}