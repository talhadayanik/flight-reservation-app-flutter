// @dart=2.9
class User{
  String id;
  String email;
  String password;
  String first_name;
  String last_name;
  String level;

  User({this.id, this.email, this.password, this.first_name, this.last_name, this.level});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      level: json['level'] as String,
    );
  }
}