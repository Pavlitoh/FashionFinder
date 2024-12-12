class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? image;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      image: json['image'],
    );
  }
}
