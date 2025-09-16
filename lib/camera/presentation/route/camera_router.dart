import 'package:go_router/go_router.dart';
import 'package:nexa_iq/camera/presentation/views/camera_page.dart';

final cameraRoute = [
  GoRoute(
    path: '/landing/site/camera',
    name: 'camera',
    builder: (context, state) => const CameraPage(),
  ),
];