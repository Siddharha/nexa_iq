import 'package:go_router/go_router.dart';
import 'package:nexa_iq/auth/presentation/views/login_view.dart';

final authRoute = [
  GoRoute(
    path: '/auth',
    name: 'auth',
    builder: (context, state) => const AuthPage(),
  ),
];