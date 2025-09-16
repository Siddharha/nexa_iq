import 'package:flutter/material.dart';
import 'package:nexa_iq/camera/presentation/widgets/scrubber_timeline_component.dart' as timelineController;
import 'package:nexa_iq/camera/presentation/widgets/timeline_ruler.dart';

class ScrubberTimelineComponent extends StatefulWidget {
    final TimelineController timelineController = TimelineController(
  pixelsPerMinute: 4.0,
  horizontalPadding: 16.0,
);

  ScrubberTimelineComponent({super.key});


  @override
  State<ScrubberTimelineComponent> createState() => _ScrubberTimelineComponentState();
}

@override
void dispose() {
  timelineController.dispose();
//  super.dispose();
}


class _ScrubberTimelineComponentState extends State<ScrubberTimelineComponent> {
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 80,
      child: Stack(
        children: [
          Expanded(
            child: TimelineRuler(
                  controller: widget.timelineController,
                  defaultPixelsPerMinute: 120.0,
                ),
          ),
          Positioned(
            child: Container(width: 1,
            height: 80,
            color: Colors.amber,),
          )
        ],
      ),
    );
  }
}