import 'package:flutter/material.dart';
import 'package:nexa_iq/camera/presentation/widgets/camera_stream_component.dart';
import 'package:nexa_iq/camera/presentation/widgets/scrubber_timeline_component.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                maxRadius: 5,
                backgroundColor: Colors.amber,
              ),
            ),
            Text("Cam 1"),
          ],
        ),
      ),

      body: ListView(
        children: [
          CameraStreamComponent(),
          ScrubberTimelineComponent()
        ],
      ),
    );
  }
}