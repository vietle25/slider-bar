import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slider_bar/slider_bar.dart';
import 'package:slider_bar/src/painters/slider_painter.dart';

void main() {
  group('SliderTrackPainter tests', () {
    test('shouldRepaint returns true when properties change', () {
      final painter1 = SliderTrackPainter(
        trackConfig: const TrackConfig(),
        percentage: 0.5,
        direction: SliderDirection.horizontal,
      );

      final painter2 = SliderTrackPainter(
        trackConfig: const TrackConfig(),
        percentage: 0.7, // Different percentage
        direction: SliderDirection.horizontal,
      );

      final painter3 = SliderTrackPainter(
        trackConfig: const TrackConfig(activeColor: Colors.red), // Different config
        percentage: 0.5,
        direction: SliderDirection.horizontal,
      );

      final painter4 = SliderTrackPainter(
        trackConfig: const TrackConfig(),
        percentage: 0.5,
        direction: SliderDirection.vertical, // Different direction
      );

      expect(painter1.shouldRepaint(painter2), true);
      expect(painter1.shouldRepaint(painter3), true);
      expect(painter1.shouldRepaint(painter4), true);
    });

    test('shouldRepaint returns false when properties are the same', () {
      final trackConfig = const TrackConfig();

      final painter1 = SliderTrackPainter(
        trackConfig: trackConfig,
        percentage: 0.5,
        direction: SliderDirection.horizontal,
      );

      final painter2 = SliderTrackPainter(
        trackConfig: trackConfig,
        percentage: 0.5,
        direction: SliderDirection.horizontal,
      );

      expect(painter1.shouldRepaint(painter2), false);
    });
  });

  group('SliderThumbPainter tests', () {
    test('shouldRepaint returns true when properties change', () {
      final painter1 = SliderThumbPainter(
        thumbConfig: const ThumbConfig(),
      );

      final painter2 = SliderThumbPainter(
        thumbConfig: const ThumbConfig(color: Colors.red), // Different config
      );

      expect(painter1.shouldRepaint(painter2), true);
    });

    test('shouldRepaint returns false when properties are the same', () {
      final thumbConfig = const ThumbConfig();

      final painter1 = SliderThumbPainter(
        thumbConfig: thumbConfig,
      );

      final painter2 = SliderThumbPainter(
        thumbConfig: thumbConfig,
      );

      expect(painter1.shouldRepaint(painter2), false);
    });
  });

  // This test verifies that the painters can be used in a widget
  testWidgets('Painters can be used in CustomPaint widgets', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Test track painter
                CustomPaint(
                  key: const Key('track_painter'),
                  painter: SliderTrackPainter(
                    trackConfig: const TrackConfig(),
                    percentage: 0.5,
                    direction: SliderDirection.horizontal,
                  ),
                  size: const Size(200, 10),
                ),
                const SizedBox(height: 20),
                // Test thumb painter
                CustomPaint(
                  key: const Key('thumb_painter'),
                  painter: SliderThumbPainter(
                    thumbConfig: const ThumbConfig(),
                  ),
                  size: const Size(30, 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Verify that the CustomPaint widgets are rendered using keys
    expect(find.byKey(const Key('track_painter')), findsOneWidget);
    expect(find.byKey(const Key('thumb_painter')), findsOneWidget);
  });
}
