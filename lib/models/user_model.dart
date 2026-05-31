class UserModel {
  String id;
  String email;
  String name;

  UserModel({required this.id, required this.email, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json, String documentId) {
    return UserModel(
      id: documentId,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
    };
  }
}