import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slider_bar/slider_bar.dart';

void main() {
  group('SliderBar widget additional tests', () {
    testWidgets('renders with callbacks', (WidgetTester tester) async {
      bool onChangedCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SliderBar(
                config: const SliderConfig(
                  min: 0,
                  max: 100,
                  initialValue: 50,
                ),
                onChanged: (value) {
                  onChangedCalled = true;
                },
                onChangeStart: (value) {},
                onChangeEnd: (value) {},
              ),
            ),
          ),
        ),
      );

      // Verify the widget is rendered with callbacks
      expect(find.byType(SliderBar), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('handles external controller updates', (WidgetTester tester) async {
      final controller = SliderController(
        initialValue: 30,
        min: 0,
        max: 100,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SliderBar(
                controller: controller,
                config: const SliderConfig(
                  min: 0,
                  max: 100,
                  initialValue: 30,
                  showLabel: true,
                ),
              ),
            ),
          ),
        ),
      );

      // Initial state
      expect(find.text('30.0'), findsOneWidget);

      // Update controller
      controller.value = 75;
      await tester.pump();

      // Check if UI updated
      expect(find.text('75.0'), findsOneWidget);
    });

    testWidgets('disposes internal controller when not provided externally', (WidgetTester tester) async {
      // This test verifies that the internal controller is properly disposed
      // We can't directly test disposal, but we can check that no errors occur

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SliderBar(
                config: SliderConfig(
                  min: 0,
                  max: 100,
                  initialValue: 50,
                ),
              ),
            ),
          ),
        ),
      );

      // Rebuild with a different widget to trigger disposal
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Disposed'),
            ),
          ),
        ),
      );

      // If we got here without errors, the test passes
      expect(find.text('Disposed'), findsOneWidget);
    });

    testWidgets('creates new instance with different config', (WidgetTester tester) async {
      const initialConfig = SliderConfig(
        min: 0,
        max: 100,
        initialValue: 50,
        showLabel: true,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SliderBar(
                config: initialConfig,
              ),
            ),
          ),
        ),
      );

      // Initial state
      expect(find.byType(SliderBar), findsOneWidget);

      // Update with new config
      const updatedConfig = SliderConfig(
        min: 0,
        max: 100,
        initialValue: 75,
        showLabel: true,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SliderBar(
                config: updatedConfig,
              ),
            ),
          ),
        ),
      );

      // If we got here without errors, the test passes
      expect(find.byType(SliderBar), findsOneWidget);
    });

    testWidgets('vertical slider has correct layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                height: 300,
                child: SliderBar(
                  config: const SliderConfig(
                    min: 0,
                    max: 100,
                    initialValue: 50,
                    direction: SliderDirection.vertical,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Verify that the vertical slider is rendered
      final gestureDetector = tester.widget<GestureDetector>(find.byType(GestureDetector));
      expect(gestureDetector.onVerticalDragStart, isNotNull);
      expect(gestureDetector.onHorizontalDragStart, isNull);

      // Verify that the CustomPaint widgets are rendered
      expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
    });
  });
}
