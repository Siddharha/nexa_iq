// HLS Sample URL
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

const hlsUrl =
    "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8";

// Provider for VideoPlayerController
final videoPlayerControllerProvider =
    FutureProvider<VideoPlayerController>((ref) async {
  final controller = VideoPlayerController.networkUrl(Uri.parse(hlsUrl));
  await controller.initialize();
  controller.play();
  controller.setLooping(true);
  return controller;
});