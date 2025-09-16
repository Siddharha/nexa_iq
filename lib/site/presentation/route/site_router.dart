import 'package:go_router/go_router.dart';
import 'package:nexa_iq/site/presentation/views/site_page.dart';

final siteRoute = [
  GoRoute(
    path: '/landing/site',
    name: 'site',
    builder: (context, state) => const SitePage(),
  ),
];