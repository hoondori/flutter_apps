import 'package:bamtol_market_app/product/write/product_category_type.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? title;
  final int? productPrice;
  final bool? isFree;
  final ProductCategoryType? categoryType;

  const Product({
    this.title,
    this.productPrice = 0,
    this.isFree,
    this.categoryType = ProductCategoryType.none,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'productPrice': productPrice,
      'isFree': isFree,
      'categoryType': categoryType?.code,
    };
  }

  factory Product.fromJson(String docId, Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      productPrice: json['productPrice'],
      isFree: json['isFree'],
      categoryType: json['categoryType'] == null
        ? ProductCategoryType.none
        : ProductCategoryType.findByCode(json['categoryType'])
    );
  }

  Product copyWith({
    String? title,
    int? productPrice,
    bool? isFree,
    ProductCategoryType? categoryType
  }) {
    return Product(
      title: title ?? this.title,
      productPrice: productPrice ?? this.productPrice,
      isFree: isFree,
      categoryType: categoryType ?? this.categoryType,
    );
  }

  @override
  List<Object?> get props => [
    title,
    productPrice,
    isFree,
    categoryType,
  ];
}