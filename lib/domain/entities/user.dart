class User {
  int id;
  String username;
  String password;
  String email;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
    };
  }

}