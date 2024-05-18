import 'package:taskmanager_app/modules/auth/domain/entity/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel(
      {required super.id,
      required super.username,
      required super.email,
      required super.firstName,
      required super.lastName,
      required super.gender,
      required super.image,
      required super.token});
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json["id"],
      username: json["username"],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      image: json['image'],
      token: json['token'],
    );
  }
}
