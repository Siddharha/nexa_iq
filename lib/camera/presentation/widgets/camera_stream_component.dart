import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexa_iq/camera/presentation/views/videocontroller_provider.dart';
import 'package:video_player/video_player.dart';

class CameraStreamComponent extends ConsumerWidget {
  const CameraStreamComponent({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
      final controllerAsync = ref.watch(videoPlayerControllerProvider);
      return Container(
        color: const Color.fromARGB(255, 17, 17, 17),
        height: 200,
        child: controllerAsync.when(
          data: (controller) => Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error: $err")),
        ),
      );
  }


}