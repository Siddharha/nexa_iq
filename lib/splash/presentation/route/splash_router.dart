import 'package:go_router/go_router.dart';
import 'package:nexa_iq/splash/presentation/views/splash_page.dart';

final splashRoute = [
  GoRoute(
    path: '/',
    name: 'splash',
    builder: (context, state) => const SplashPage(),
  ),
];