import 'package:ghealth_app/data/models/product_data.dart';

class ProductDataResponse {
  final List<ProductData> products;

  ProductDataResponse({required this.products});

  factory ProductDataResponse.fromJsonList(List<dynamic> jsonList) {
    List<ProductData> products = jsonList.map((productData) => ProductData.fromJson(productData)).toList();
    return ProductDataResponse(products: products);
  }
}