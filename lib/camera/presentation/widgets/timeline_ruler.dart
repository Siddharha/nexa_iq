// lib/timeline_ruler.dart
import 'dart:math';
import 'package:flutter/material.dart';

/// Data class for detection bars (equivalent to your Kotlin DetectionBar)
class DetectionBar {
  final int startHour, startMinute, startSecond;
  final int endHour, endMinute, endSecond;
  final int row; // 1,2 or 3
  final Color color;

  DetectionBar({
    required this.startHour,
    required this.startMinute,
    this.startSecond = 0,
    required this.endHour,
    required this.endMinute,
    this.endSecond = 0,
    required this.row,
    required this.color,
  });
}

/// Controller to control the timeline widget programmatically
class TimelineController extends ChangeNotifier {
  double pixelsPerMinute;
  final double minPixelsPerMinute;
  final double maxPixelsPerMinute;
  double horizontalPadding;
  bool is24HourFormat;

  // internal state
  List<DetectionBar> _bars = [];
  bool _channel1Visible = true;
  bool _channel2Visible = true;
  bool _channel3Visible = true;
  double _highlightUntilMinute = -1;

  TimelineController({
    this.pixelsPerMinute = 4.0,
    this.minPixelsPerMinute = 1.0,
    this.maxPixelsPerMinute = 600.0,
    this.horizontalPadding = 16.0,
    this.is24HourFormat = false,
  });

  // Exposed read accessors
  List<DetectionBar> get bars => List.unmodifiable(_bars);
  bool get channel1Visible => _channel1Visible;
  bool get channel2Visible => _channel2Visible;
  bool get channel3Visible => _channel3Visible;
  double get highlightUntilMinute => _highlightUntilMinute;

  // Mutators (notify listeners so the painter updates)
  void setDetectionBars(List<DetectionBar> bars) {
    _bars = List.from(bars);
    notifyListeners();
  }

  void setDetectionChannelVisibility({bool channel1 = true, bool channel2 = true, bool channel3 = true}) {
    _channel1Visible = channel1;
    _channel2Visible = channel2;
    _channel3Visible = channel3;
    notifyListeners();
  }

  void highlightUntil(int hour, int minute, [int second = 0]) {
    _highlightUntilMinute = hour * 60 + minute + second / 60.0;
    notifyListeners();
  }

  void highlightFull() {
    _highlightUntilMinute = 24 * 60.0;
    notifyListeners();
  }

  void clearHighlight() {
    _highlightUntilMinute = -1;
    notifyListeners();
  }

  void setZoom(double ppm) {
    pixelsPerMinute = ppm.clamp(minPixelsPerMinute, maxPixelsPerMinute);
    notifyListeners();
  }

  void zoomByDelta(double delta) {
    setZoom((pixelsPerMinute + delta).clamp(minPixelsPerMinute, maxPixelsPerMinute));
  }

  void resetZoom(double defaultPPM) {
    pixelsPerMinute = defaultPPM.clamp(minPixelsPerMinute, maxPixelsPerMinute);
    notifyListeners();
  }
}

/// The widget that renders the timeline ruler
class TimelineRuler extends StatefulWidget {
  final TimelineController controller;
  final double defaultPixelsPerMinute;
  final double minVisibleSize; // px
  final double barThickness;
  final double mergeThresholdPx;
  final double totalMinutes; // usually 24*60
  final EdgeInsetsGeometry padding;
  final ScrollController? scrollController;

  const TimelineRuler({
    super.key,
    required this.controller,
    this.defaultPixelsPerMinute = 120.0,
    this.minVisibleSize = 16.0,
    this.barThickness = 15.0,
    this.mergeThresholdPx = 8.0,
    this.totalMinutes = 24 * 60.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.scrollController,
  });

  @override
  _TimelineRulerState createState() => _TimelineRulerState();
}

class _TimelineRulerState extends State<TimelineRuler> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late TimelineController controller;
  double _lastScale = 1.0;
  double _initialPixelsPerMinute = 0;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controller.pixelsPerMinute = widget.defaultPixelsPerMinute;
    _scrollController = widget.scrollController ?? ScrollController();
    controller.addListener(_onControllerChange);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChange);
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onControllerChange() {
    setState(() {
      // simple setState to redraw painter when controller changes
    });
  }

  /// ScrollToTime: hour/minute/second -> center at playhead offset (optional)
  void scrollToTime(int hour, int minute, {int second = 0, bool smooth = false, double playheadOffsetPx = 0.0}) {
    final totalMinutes = hour * 60 + minute + second / 60.0;
    final x = totalMinutes * controller.pixelsPerMinute - playheadOffsetPx + controller.horizontalPadding;
    final maxScroll = _contentWidth - _scrollController.position.viewportDimension;
    final safe = x.clamp(0.0, maxScroll >= 0 ? maxScroll : 0.0);
    if (smooth) {
      _scrollController.animateTo(safe, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      _scrollController.jumpTo(safe);
    }
  }

  /// compute content width from controller pixelsPerMinute
  double get _contentWidth {
    return widget.totalMinutes * controller.pixelsPerMinute + controller.horizontalPadding * 2;
  }

  /// Convert scrollX -> time triple
  /// returns (hour, minute, second)
  Triple<int, int, int> getTimeAtScrollPosition(double scrollX) {
    final adjusted = (scrollX - controller.horizontalPadding).clamp(0.0, double.infinity);
    final totalMinutes = adjusted / controller.pixelsPerMinute;
    final hour = (totalMinutes / 60).floor().clamp(0, 23);
    final minute = (totalMinutes % 60).floor().clamp(0, 59);
    final second = (((totalMinutes - totalMinutes.floor()) * 60).floor()).clamp(0, 59);
    return Triple(hour, minute, second);
  }

  Triple<int, int, int> getTimeAtPlayhead(double offsetPx) {
    final absoluteX = _scrollController.offset + offsetPx;
    return getTimeAtScrollPosition(absoluteX);
  }

  void scrollBySeconds(int seconds, {bool smooth = false, bool backward = false}) {
    final deltaX = (seconds / 60.0) * controller.pixelsPerMinute;
    final direction = backward ? -1.0 : 1.0;
    final target = (_scrollController.offset + deltaX * direction).clamp(0.0, _contentWidth - _scrollController.position.viewportDimension);
    if (smooth) {
      _scrollController.animateTo(target, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    } else {
      _scrollController.jumpTo(target);
    }
  }

  // Expose some methods on the widget state via keys or call controller.notifyListeners after changing controller

  @override
  Widget build(BuildContext context) {
    final height = 140.0;
    return GestureDetector(
      onScaleStart: (details) {
        _lastScale = 1.0;
        _initialPixelsPerMinute = controller.pixelsPerMinute;
      },
      onScaleUpdate: (details) {
        if (details.pointerCount == 2) {
          final newScale = details.scale;
          final deltaScale = newScale / _lastScale;
          _lastScale = newScale;

          // Apply a gentle zoom factor based on scale change
          final candidate = (_initialPixelsPerMinute * newScale).clamp(controller.minPixelsPerMinute, controller.maxPixelsPerMinute);
          controller.setZoom(candidate);
        }
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        child: SizedBox(
          width: _contentWidth,
          height: height,
          child: CustomPaint(
            painter: _TimelinePainter(
              controller: controller,
              minVisibleSize: widget.minVisibleSize,
              barThickness: widget.barThickness,
              mergeThresholdPx: widget.mergeThresholdPx,
            ),
          ),
        ),
      ),
    );
  }
}

/// Simple triple returned by some methods
class Triple<A, B, C> {
  final A a;
  final B b;
  final C c;
  Triple(this.a, this.b, this.c);
}

/// The painter that actually draws the timeline
class _TimelinePainter extends CustomPainter {
  final TimelineController controller;
  final double minVisibleSize;
  final double barThickness;
  final double mergeThresholdPx;

  _TimelinePainter({
    required this.controller,
    required this.minVisibleSize,
    required this.barThickness,
    required this.mergeThresholdPx,
  }) : super(repaint: controller);

  final Paint tickPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 1.0
    ..isAntiAlias = true;

  final Paint labelPaint = Paint()
    ..color = Colors.grey
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    final clipLeft = 0.0;
    final clipRight = size.width;
    final clipBottom = size.height;
    final horizontalPadding = controller.horizontalPadding;

    // Draw highlight background if requested
    if (controller.highlightUntilMinute >= 0) {
      final highlightX = controller.highlightUntilMinute * controller.pixelsPerMinute + horizontalPadding;
      final rect = Rect.fromLTWH(0, 0, highlightX.clamp(0.0, clipRight), clipBottom);
      final highlightPaint = Paint()..color = Colors.grey.shade800;
      canvas.drawRect(rect, highlightPaint);
    }

    // Draw main timeline labels and ticks
    final totalPixelsLeft = (clipLeft - horizontalPadding);
    final startMinute = max(0, (totalPixelsLeft / controller.pixelsPerMinute).floor());
    final endMinute = min((controller.pixelsPerMinute * 24 * 60).toInt(), ((clipRight - horizontalPadding) / controller.pixelsPerMinute).ceil());

    // Dynamic label interval (same logic as Kotlin)
    final ppm = controller.pixelsPerMinute;
    final labelIntervalMinutes = ppm >= 90
        ? 1
        : ppm >= 60
            ? 5
            : ppm >= 30
                ? 10
                : ppm >= 10
                    ? 30
                    : ppm >= 5
                        ? 60
                        : ppm >= 2
                            ? 180
                            : 360;

    final snappedStart = ((startMinute + labelIntervalMinutes - 1) ~/ labelIntervalMinutes) * labelIntervalMinutes;

    final textStyle = TextStyle(color: Colors.grey.shade300, fontSize: 12);

    double timelineHBarHeight = 0.0;

    for (int minute = snappedStart; minute <= endMinute; minute += labelIntervalMinutes) {
      final x = minute * ppm + horizontalPadding;
      final yStart = 20.0;
      final yEnd = yStart + 20.0;
      final hour = minute ~/ 60;
      final min = minute % 60;
      final timeStr = controller.is24HourFormat
          ? '${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}'
          : (() {
              final hour12 = (hour % 12 == 0) ? 12 : hour % 12;
              if (min == 0) {
                final ampm = hour < 12 ? 'AM' : 'PM';
                return '$hour12 $ampm';
              } else {
                return '$hour12:${min.toString().padLeft(2, '0')}';
              }
            })();

      // Draw label
      final tp = TextPainter(text: TextSpan(text: timeStr, style: textStyle), textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(x - 30.0, yStart - tp.height / 2));

      // draw tick
      final tickP = tickPaint..strokeWidth = 1.0;
      canvas.drawLine(Offset(x, yStart + 5.0), Offset(x, yEnd), tickP);

      if (minute == 0) {
        timelineHBarHeight = yEnd;
      }
    }

    // Draw baseline horizontal line
    final linePaint = tickPaint;
    canvas.drawLine(Offset(clipLeft, timelineHBarHeight), Offset(clipRight, timelineHBarHeight), linePaint);

    final hLineHeight = timelineHBarHeight + 15.0;

    // Draw each channel similarly to the Kotlin code
    _drawChannel(canvas, size, 1, hLineHeight, controller.channel1Visible);
    _drawChannel(canvas, size, 2, hLineHeight, controller.channel2Visible);
    _drawChannel(canvas, size, 3, hLineHeight, controller.channel3Visible);
  }

  void _drawChannel(Canvas canvas, Size size, int channel, double hLineHeight, bool visible) {
    final clipLeft = 0.0;
    final clipRight = size.width;
    final horizontalPadding = controller.horizontalPadding;
    final bottom = size.height;

    final yPos = (() {
      if (channel == 1) return hLineHeight + ((bottom - hLineHeight) / 4.0);
      if (channel == 2) return hLineHeight + ((bottom - hLineHeight) / 4.0) * 2.0;
      return hLineHeight + ((bottom - hLineHeight) / 4.0) * 3.0;
    })();

    // Draw baseline for channel
    canvas.drawLine(Offset(clipLeft, yPos), Offset(clipRight, yPos), tickPaint..strokeWidth = 1.0);

    if (!visible) return;

    // Filter bars for this channel and map to ranges
    final bars = controller.bars.where((b) => b.row == channel).toList();
    final barRanges = bars.map((bar) {
      final startTotalSeconds = bar.startHour * 3600 + bar.startMinute * 60 + bar.startSecond;
      final endTotalSeconds = bar.endHour * 3600 + bar.endMinute * 60 + bar.endSecond;
      final rawStartX = (startTotalSeconds / 60.0) * controller.pixelsPerMinute;
      final rawEndX = (endTotalSeconds / 60.0) * controller.pixelsPerMinute;
      final highlightX = controller.highlightUntilMinute >= 0 ? controller.highlightUntilMinute * controller.pixelsPerMinute : double.infinity;

      final startX = (highlightX >= rawStartX) ? rawStartX : highlightX;
      final endX = (highlightX >= rawEndX) ? rawEndX : highlightX;
      return _Range(startX, endX, bar.color);
    }).toList();

    barRanges.sort((a, b) => a.start.compareTo(b.start));

    // merge close ranges
    final merged = <_Range>[];
    if (barRanges.isNotEmpty) {
      var current = barRanges[0];
      for (var i = 1; i < barRanges.length; i++) {
        final next = barRanges[i];
        if (next.start - current.end <= mergeThresholdPx) {
          current = _Range(current.start, max(current.end, next.end), next.color);
        } else {
          merged.add(current);
          current = next;
        }
      }
      merged.add(current);
    }

    // Draw merged rounded rects
    for (final r in merged) {
      if (r.end <= r.start) continue;
      double paddedStartX = r.start + horizontalPadding;
      double paddedEndX = r.end + horizontalPadding;

      // enforce min visible width
      final width = paddedEndX - paddedStartX;
      if (width < minVisibleSize) {
        final centerX = (paddedStartX + paddedEndX) / 2.0;
        paddedStartX = centerX - minVisibleSize / 2.0;
        paddedEndX = centerX + minVisibleSize / 2.0;
      }

      final rectTop = yPos - barThickness / 2.0;
      final rect = Rect.fromLTWH(paddedStartX, rectTop, max(0.0, paddedEndX - paddedStartX), barThickness);
      final rrect = RRect.fromRectAndRadius(rect, Radius.circular(8));
      final paint = Paint()..color = r.color;
      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter oldDelegate) {
    return oldDelegate.controller != controller;
  }
}

class _Range {
  final double start;
  final double end;
  final Color color;
  _Range(this.start, this.end, this.color);
}
