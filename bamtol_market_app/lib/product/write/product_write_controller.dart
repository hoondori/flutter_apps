import 'package:bamtol_market_app/product/repository/product_repository.dart';
import 'package:bamtol_market_app/user/model/user_model.dart';
import 'package:get/get.dart';

class ProductWriteController extends GetxController {
  final UserModel owner;
  final ProductRepository _productRepository;
  ProductWriteController(this.owner, this._productRepository);
}