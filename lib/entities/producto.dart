class Product {
  final String id;
  final String store_id;
  final String name;
  final String description;
  final double price;
  final String? image;

  Product({
    required this.id,
    required this.store_id,
    required this.name,
    required this.description,
    required this.price,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      store_id: json['store_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'store_id': store_id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
    };
  }
}
