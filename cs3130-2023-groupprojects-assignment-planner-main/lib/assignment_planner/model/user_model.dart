class UserModel {
  String username;
  String email;
  int university;
  UserModel(
      {required this.username, required this.email, required this.university});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String,
      email: json['email'] as String,
      university: json['university'] as int,
    );
  }
}
