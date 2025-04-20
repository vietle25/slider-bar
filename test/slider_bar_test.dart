import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slider_bar/slider_bar.dart';

void main() {
  group('SliderController tests', () {
    test('initializes with correct values', () {
      final controller = SliderController(
        initialValue: 50,
        min: 0,
        max: 100,
      );

      expect(controller.value, 50);
      expect(controller.min, 0);
      expect(controller.max, 100);
      expect(controller.percentage, 0.5);
    });

    test('updates value correctly', () {
      final controller = SliderController(
        initialValue: 50,
        min: 0,
        max: 100,
      );

      controller.value = 75;
      expect(controller.value, 75);
      expect(controller.percentage, 0.75);

      controller.updateValue(25);
      expect(controller.value, 25);
      expect(controller.percentage, 0.25);
    });

    test('clamps values to min/max range', () {
      final controller = SliderController(
        initialValue: 50,
        min: 0,
        max: 100,
      );

      controller.value = 150;
      expect(controller.value, 100);

      controller.value = -50;
      expect(controller.value, 0);
    });

    test('calculates percentage correctly', () {
      final controller = SliderController(
        initialValue: 25,
        min: 0,
        max: 100,
      );

      expect(controller.percentage, 0.25);

      controller.value = 75;
      expect(controller.percentage, 0.75);
    });

    test('calculates value from percentage correctly', () {
      final controller = SliderController(
        initialValue: 50,
        min: 0,
        max: 100,
      );

      expect(controller.valueFromPercentage(0.25), 25);
      expect(controller.valueFromPercentage(0.75), 75);
      expect(controller.valueFromPercentage(1.5), 100); // Clamped to max
      expect(controller.valueFromPercentage(-0.5), 0); // Clamped to min
    });

    test('resets to initial value', () {
      final controller = SliderController(
        initialValue: 50,
        min: 0,
        max: 100,
      );

      controller.value = 75;
      expect(controller.value, 75);

      controller.reset(25);
      expect(controller.value, 25);
    });

    test('throws assertion error for invalid initial values', () {
      expect(() => SliderController(
        initialValue: 150,
        min: 0,
        max: 100,
      ), throwsAssertionError);

      expect(() => SliderController(
        initialValue: -50,
        min: 0,
        max: 100,
      ), throwsAssertionError);

      expect(() => SliderController(
        initialValue: 50,
        min: 100,
        max: 0,
      ), throwsAssertionError);
    });
  });

  group('SliderConfig tests', () {
    test('initializes with default values', () {
      const config = SliderConfig();

      expect(config.min, 0.0);
      expect(config.max, 1.0);
      expect(config.initialValue, 0.0);
      expect(config.direction, SliderDirection.horizontal);
      expect(config.showLabel, false);
      expect(config.labelStyle, null);
      expect(config.labelFormat, null);
    });

    test('copyWith creates a new instance with updated values', () {
      const config = SliderConfig(
        min: 0,
        max: 100,
        initialValue: 50,
      );

      final updatedConfig = config.copyWith(
        min: 10,
        max: 90,
        initialValue: 40,
        direction: SliderDirection.vertical,
        showLabel: true,
      );

      expect(updatedConfig.min, 10);
      expect(updatedConfig.max, 90);
      expect(updatedConfig.initialValue, 40);
      expect(updatedConfig.direction, SliderDirection.vertical);
      expect(updatedConfig.showLabel, true);

      // Original should be unchanged
      expect(config.min, 0);
      expect(config.max, 100);
      expect(config.initialValue, 50);
      expect(config.direction, SliderDirection.horizontal);
      expect(config.showLabel, false);
    });

    test('throws assertion error for invalid values', () {
      expect(() => SliderConfig(
        min: 100,
        max: 0,
      ), throwsAssertionError);

      expect(() => SliderConfig(
        min: 0,
        max: 100,
        initialValue: 150,
      ), throwsAssertionError);

      expect(() => SliderConfig(
        min: 0,
        max: 100,
        initialValue: -50,
      ), throwsAssertionError);
    });
  });

  group('TrackConfig tests', () {
    test('initializes with default values', () {
      const config = TrackConfig();

      expect(config.activeColor, Colors.blue);
      expect(config.inactiveColor, Colors.grey);
      expect(config.height, 6.0);
      expect(config.width, null);
      expect(config.radius, 3.0);
    });

    test('copyWith creates a new instance with updated values', () {
      const config = TrackConfig();

      final updatedConfig = config.copyWith(
        activeColor: Colors.red,
        inactiveColor: Colors.grey.shade300,
        height: 8.0,
        width: 200.0,
        radius: 4.0,
      );

      expect(updatedConfig.activeColor, Colors.red);
      expect(updatedConfig.inactiveColor, Colors.grey.shade300);
      expect(updatedConfig.height, 8.0);
      expect(updatedConfig.width, 200.0);
      expect(updatedConfig.radius, 4.0);

      // Original should be unchanged
      expect(config.activeColor, Colors.blue);
      expect(config.inactiveColor, Colors.grey);
      expect(config.height, 6.0);
      expect(config.width, null);
      expect(config.radius, 3.0);
    });
  });

  group('ThumbConfig tests', () {
    test('initializes with default values', () {
      const config = ThumbConfig();

      expect(config.color, Colors.blue);
      expect(config.width, 20.0);
      expect(config.height, 20.0);
      expect(config.radius, 10.0);
      expect(config.shape, BoxShape.circle);
      expect(config.elevation, 1.0);
      expect(config.shadowColor, Colors.black26);
    });

    test('copyWith creates a new instance with updated values', () {
      const config = ThumbConfig();

      final updatedConfig = config.copyWith(
        color: Colors.green,
        width: 24.0,
        height: 24.0,
        radius: 12.0,
        shape: BoxShape.rectangle,
        elevation: 2.0,
        shadowColor: Colors.black45,
      );

      expect(updatedConfig.color, Colors.green);
      expect(updatedConfig.width, 24.0);
      expect(updatedConfig.height, 24.0);
      expect(updatedConfig.radius, 12.0);
      expect(updatedConfig.shape, BoxShape.rectangle);
      expect(updatedConfig.elevation, 2.0);
      expect(updatedConfig.shadowColor, Colors.black45);

      // Original should be unchanged
      expect(config.color, Colors.blue);
      expect(config.width, 20.0);
      expect(config.height, 20.0);
      expect(config.radius, 10.0);
      expect(config.shape, BoxShape.circle);
      expect(config.elevation, 1.0);
      expect(config.shadowColor, Colors.black26);
    });
  });

  group('SliderBar widget tests', () {
    testWidgets('renders correctly with default config', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SliderBar(),
            ),
          ),
        ),
      );

      expect(find.byType(SliderBar), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
      expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
    });

    testWidgets('controller updates value correctly', (WidgetTester tester) async {
      final controller = SliderController(
        initialValue: 0,
        min: 0,
        max: 100,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: SliderBar(
                  controller: controller,
                  config: const SliderConfig(
                    min: 0,
                    max: 100,
                    initialValue: 0,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Update controller value programmatically
      controller.value = 50;
      await tester.pump();

      // Value should be updated to 50
      expect(controller.value, 50);
    });

    testWidgets('shows label when configured', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: SliderBar(
                  config: const SliderConfig(
                    min: 0,
                    max: 100,
                    initialValue: 50,
                    showLabel: true,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
      expect(find.text('50.0'), findsOneWidget);
    });

    testWidgets('uses custom label format when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: SliderBar(
                  config: SliderConfig(
                    min: 0,
                    max: 100,
                    initialValue: 50,
                    showLabel: true,
                    labelFormat: (value) => '${value.toInt()}%',
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);
    });

    testWidgets('renders vertical slider when configured', (WidgetTester tester) async {
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

      expect(find.byType(SliderBar), findsOneWidget);
      // Vertical slider should use vertical drag gestures
      final gestureDetector = tester.widget<GestureDetector>(find.byType(GestureDetector));
      expect(gestureDetector.onVerticalDragStart, isNotNull);
      expect(gestureDetector.onHorizontalDragStart, isNull);
    });
  });
}
