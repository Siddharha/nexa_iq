
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa_iq/auth/domain/entities/user.dart';

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null);

  void login(String email, String password) {
    // simulate login
    state = User(id: "1", name: "Siddhartha");
  }

  void logout() => state = null;
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>(
  (ref) => AuthNotifier(),
);