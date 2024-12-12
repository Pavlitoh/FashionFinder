class Branch {
  final String id;
  final String name;
  final String categoryId;
  final String address;
  final String storeId;
  final double latitude;
  final double longitude;
  final List<String>? services;
  final Map<String, Map<String, String>>? schedule;

  Branch({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.address,
    required this.storeId,
    required this.latitude,
    required this.longitude,
    this.services,
    this.schedule,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['_id'],
      name: json['name'],
      categoryId: json['category_id'],
      address: json['address'],
      storeId: json['store_id'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      services: (json['services'] as List<dynamic>?)?.cast<String>(),
      schedule: (json['schedule'] as Map<String, dynamic>?)?.map((key, value) {
        return MapEntry(
          key,
          (value as Map<String, dynamic>).cast<String, String>(),
        );
      }),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category_id': categoryId,
      'address': address,
      'store_id': storeId,
      'latitude': latitude,
      'longitude': longitude,
      'services': services,
      'schedule': schedule,
    };
  }
}
