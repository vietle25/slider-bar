import 'package:flutter/material.dart';
import '../models/slider_config.dart';
import '../enums/slider_direction.dart';

/// Custom painter for drawing the slider track.
class SliderTrackPainter extends CustomPainter {
  /// Creates a slider track painter.
  SliderTrackPainter({
    required this.trackConfig,
    required this.percentage,
    required this.direction,
  });

  /// Configuration for the track.
  final TrackConfig trackConfig;

  /// Percentage of the slider value.
  final double percentage;

  /// Direction of the slider.
  final SliderDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint inactivePaint = Paint()
      ..color = trackConfig.inactiveColor
      ..style = PaintingStyle.fill;

    final Paint activePaint = Paint()
      ..color = trackConfig.activeColor
      ..style = PaintingStyle.fill;

    final double radius = trackConfig.radius;
    
    if (direction == SliderDirection.horizontal) {
      // Draw inactive track
      final RRect inactiveRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, trackConfig.height),
        Radius.circular(radius),
      );
      canvas.drawRRect(inactiveRRect, inactivePaint);

      // Draw active track
      final RRect activeRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width * percentage, trackConfig.height),
        Radius.circular(radius),
      );
      canvas.drawRRect(activeRRect, activePaint);
    } else {
      // Vertical slider
      // Draw inactive track
      final RRect inactiveRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, trackConfig.height, size.height),
        Radius.circular(radius),
      );
      canvas.drawRRect(inactiveRRect, inactivePaint);

      // Draw active track (from bottom to top)
      final RRect activeRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          0,
          size.height * (1 - percentage),
          trackConfig.height,
          size.height * percentage,
        ),
        Radius.circular(radius),
      );
      canvas.drawRRect(activeRRect, activePaint);
    }
  }

  @override
  bool shouldRepaint(SliderTrackPainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.trackConfig != trackConfig ||
        oldDelegate.direction != direction;
  }
}

/// Custom painter for drawing the slider thumb.
class SliderThumbPainter extends CustomPainter {
  /// Creates a slider thumb painter.
  SliderThumbPainter({
    required this.thumbConfig,
  });

  /// Configuration for the thumb.
  final ThumbConfig thumbConfig;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint thumbPaint = Paint()
      ..color = thumbConfig.color
      ..style = PaintingStyle.fill;

    // Draw shadow
    if (thumbConfig.elevation > 0) {
      canvas.drawShadow(
        Path()
          ..addOval(
            Rect.fromCenter(
              center: Offset(size.width / 2, size.height / 2),
              width: thumbConfig.width,
              height: thumbConfig.height,
            ),
          ),
        thumbConfig.shadowColor,
        thumbConfig.elevation,
        true,
      );
    }

    // Draw thumb
    if (thumbConfig.shape == BoxShape.circle) {
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        thumbConfig.width / 2,
        thumbPaint,
      );
    } else {
      // Rectangle with rounded corners
      final RRect thumbRRect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: thumbConfig.width,
          height: thumbConfig.height,
        ),
        Radius.circular(thumbConfig.radius),
      );
      canvas.drawRRect(thumbRRect, thumbPaint);
    }
  }

  @override
  bool shouldRepaint(SliderThumbPainter oldDelegate) {
    return oldDelegate.thumbConfig != thumbConfig;
  }
}
