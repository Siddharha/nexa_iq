import 'package:nexa_iq/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> login(String email, String password);
}