class ProductModel {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String documentId) {
    return ProductModel(
      id: documentId,
      title: json['title'] ?? 'Generic Asset',
      price: (json['price'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'] ?? 'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}