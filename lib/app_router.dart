import 'package:go_router/go_router.dart';
import 'package:nexa_iq/auth/presentation/route/auth_router.dart';
import 'package:nexa_iq/landing/presentation/route/landing_router.dart';
import 'package:nexa_iq/splash/presentation/route/splash_router.dart';
import 'package:nexa_iq/term_of_service/presentation/route/terms_of_router_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      ...splashRoute,
      ...authRoute,
      ...termsOfServiceRoute,
      ...landingRoute
    ]
  );
}