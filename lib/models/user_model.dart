class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String userClass;
  final String? photoUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userClass,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'userClass': userClass,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      userClass: map['userClass'] ?? '',
      photoUrl: map['photoUrl'],
    );
  }
}