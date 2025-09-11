import 'package:nexa_iq/auth/domain/entities/user.dart';

class UserModel {
  final String id;
  final String name;

  UserModel({required this.id, required this.name});

  User toEntity() => User(id: id, name: name);
}