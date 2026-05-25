import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.accessToken,
    required super.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    accessToken: json['access_token'] as String,
    refreshToken: json['refresh_token'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'access_token': accessToken,
    'refresh_token': refreshToken,
  };
}
