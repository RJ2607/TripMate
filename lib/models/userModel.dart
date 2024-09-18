class UserModel {
  String uid;
  String name;
  String email;
  // String phone;
  String profile;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    // required this.phone,
    required this.profile,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      // 'phone': phone,
      'profile': profile,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      // phone: json['phone'],
      profile: json['profile'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
