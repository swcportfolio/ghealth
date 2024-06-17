
class ProductDTO {
  final List<ProductDataDTO> products;

  ProductDTO({required this.products});

  factory ProductDTO.fromJson(List<dynamic> json) {
    return ProductDTO(
      products: ProductDataDTO.jsonToList(json),
    );
  }
}


class ProductDataDTO {
  final String company;
  final String title;
  final int price;
  final String effect;
  final String priority;
  final String productImg; // Assuming it's a string representing image data
  final String count;

  ProductDataDTO({
    required this.company,
    required this.title,
    required this.price,
    required this.effect,
    required this.priority,
    required this.productImg,
    required this.count,
  });

  factory ProductDataDTO.fromJson(Map<String, dynamic> json) {
    return ProductDataDTO(
      company: json['company'],
      title: json['title'],
      price: json['price'],
      effect: json['effect'],
      priority: json['priority'],
      productImg: json['productImg'],
      count: json['count'],
    );
  }

  static List<ProductDataDTO> jsonToList(List<dynamic> json) {
    return json.map((productData) => ProductDataDTO.fromJson(productData)).toList();
  }
}