
class ProductData {
  final String company;
  final String title;
  final int price;
  final String effect;
  final String priority;
  final String productImg; // Assuming it's a string representing image data
  final String count;

  ProductData({
    required this.company,
    required this.title,
    required this.price,
    required this.effect,
    required this.priority,
    required this.productImg,
    required this.count,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      company: json['company'],
      title: json['title'],
      price: json['price'],
      effect: json['effect'],
      priority: json['priority'],
      productImg: json['productImg'],
      count: json['count'],
    );
  }
}

