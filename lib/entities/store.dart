class Store {
  final String id;
  final String name;
  final String description;
  final String categoryId;
  final String mainAddress;
  final String mainPhone;
  final String? website;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Store({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.mainAddress,
    required this.mainPhone,
    this.website,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      categoryId: json['category_id'],
      mainAddress: json['main_address'],
      mainPhone: json['main_phone'],
      website: json['website'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'category_id': categoryId,
      'main_address': mainAddress,
      'main_phone': mainPhone,
      'website': website,
      'image': image,
    };
  }
}
