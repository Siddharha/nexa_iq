import 'package:go_router/go_router.dart';
import 'package:nexa_iq/landing/presentation/views/landing_page.dart';

final landingRoute = [
  GoRoute(
    path: '/landing',
    name: 'landing',
    builder: (context, state) => const LandingPage(),
  ),
];