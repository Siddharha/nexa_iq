import 'package:go_router/go_router.dart';
import 'package:nexa_iq/term_of_service/presentation/views/terms_of_service.dart';

final termsOfServiceRoute = [
  GoRoute(
    path: '/termsOfService',
    name: 'termsOfService',
    builder: (context, state) => const TermsOfServicePage(),
  ),
];