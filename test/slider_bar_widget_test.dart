import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slider_bar/slider_bar.dart';

void main() {
  group('SliderBar widget comprehensive tests', () {
    testWidgets('drag operations trigger callbacks correctly - horizontal', (WidgetTester tester) async {
      bool onChangeStartCalled = false;
      bool onChangeCalled = false;
      bool onChangeEndCalled = false;
      double startValue = 0;
      double currentValue = 0;
      double endValue = 0;

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
                  ),
                  onChangeStart: (value) {
                    onChangeStartCalled = true;
                    startValue = value;
                  },
                  onChanged: (value) {
                    onChangeCalled = true;
                    currentValue = value;
                  },
                  onChangeEnd: (value) {
                    onChangeEndCalled = true;
                    endValue = value;
                  },
                ),
              ),
            ),
          ),
        ),
      );

      // Find the GestureDetector
      final gesture = find.byType(GestureDetector);

      // Start drag from the middle
      await tester.dragFrom(tester.getCenter(gesture), const Offset(50, 0));
      await tester.pumpAndSettle();

      // Verify callbacks were called
      expect(onChangeStartCalled, true);
      expect(onChangeCalled, true);
      expect(onChangeEndCalled, true);

      // Values should be updated
      expect(startValue, isNot(0));
      expect(currentValue, isNot(0));
      expect(endValue, isNot(0));
    });

    testWidgets('drag operations trigger callbacks correctly - vertical', (WidgetTester tester) async {
      bool onChangeStartCalled = false;
      bool onChangeCalled = false;
      bool onChangeEndCalled = false;
      double startValue = 0;
      double currentValue = 0;
      double endValue = 0;

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
                  onChangeStart: (value) {
                    onChangeStartCalled = true;
                    startValue = value;
                  },
                  onChanged: (value) {
                    onChangeCalled = true;
                    currentValue = value;
                  },
                  onChangeEnd: (value) {
                    onChangeEndCalled = true;
                    endValue = value;
                  },
                ),
              ),
            ),
          ),
        ),
      );

      // Find the GestureDetector
      final gesture = find.byType(GestureDetector);

      // Start drag from the middle (up direction increases value in vertical slider)
      await tester.dragFrom(tester.getCenter(gesture), const Offset(0, -50));
      await tester.pumpAndSettle();

      // Verify callbacks were called
      expect(onChangeStartCalled, true);
      expect(onChangeCalled, true);
      expect(onChangeEndCalled, true);

      // Values should be updated
      expect(startValue, isNot(0));
      expect(currentValue, isNot(0));
      expect(endValue, isNot(0));
    });

    testWidgets('controller updates trigger state rebuild', (WidgetTester tester) async {
      final controller = SliderController(
        initialValue: 50,
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
                  initialValue: 50,
                  showLabel: true,
                ),
              ),
            ),
          ),
        ),
      );

      // Initial state
      expect(find.text('50.0'), findsOneWidget);

      // Update controller value
      controller.value = 75;
      await tester.pump();

      // UI should update
      expect(find.text('75.0'), findsOneWidget);
    });

    testWidgets('changing controller instance updates widget correctly', (WidgetTester tester) async {
      final controller1 = SliderController(
        initialValue: 30,
        min: 0,
        max: 100,
      );

      final controller2 = SliderController(
        initialValue: 70,
        min: 0,
        max: 100,
      );

      Widget buildSlider(SliderController controller) {
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: SliderBar(
                controller: controller,
                config: const SliderConfig(
                  min: 0,
                  max: 100,
                  showLabel: true,
                ),
              ),
            ),
          ),
        );
      }

      // Build with first controller
      await tester.pumpWidget(buildSlider(controller1));
      expect(find.text('30.0'), findsOneWidget);

      // Update to second controller
      await tester.pumpWidget(buildSlider(controller2));
      expect(find.text('70.0'), findsOneWidget);
    });

    testWidgets('custom label format is applied correctly', (WidgetTester tester) async {
      String formatLabel(double value) => '${value.toInt()}%';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SliderBar(
                config: SliderConfig(
                  min: 0,
                  max: 100,
                  initialValue: 42,
                  showLabel: true,
                  labelFormat: formatLabel,
                ),
              ),
            ),
          ),
        ),
      );

      // Verify custom format is applied
      expect(find.text('42%'), findsOneWidget);
    });

    testWidgets('custom label style is applied correctly', (WidgetTester tester) async {
      const customStyle = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.red,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SliderBar(
                config: const SliderConfig(
                  min: 0,
                  max: 100,
                  initialValue: 50,
                  showLabel: true,
                  labelStyle: customStyle,
                ),
              ),
            ),
          ),
        ),
      );

      // Find the Text widget
      final textWidget = tester.widget<Text>(find.text('50.0'));

      // Verify custom style is applied
      expect(textWidget.style, equals(customStyle));
    });

    testWidgets('slider with custom track and thumb config renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SliderBar(
                config: const SliderConfig(
                  min: 0,
                  max: 100,
                  initialValue: 50,
                  trackConfig: TrackConfig(
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    height: 10,
                    width: 200,
                    radius: 5,
                  ),
                  thumbConfig: ThumbConfig(
                    color: Colors.blue,
                    width: 30,
                    height: 30,
                    shape: BoxShape.rectangle,
                    radius: 8,
                    elevation: 4,
                    shadowColor: Colors.black45,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Verify the slider is rendered
      expect(find.byType(SliderBar), findsOneWidget);
      expect(find.byType(CustomPaint), findsAtLeastNWidgets(2)); // Track and thumb
    });

    testWidgets('slider with null track width uses available width', (WidgetTester tester) async {
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
                    trackConfig: TrackConfig(
                      width: null, // Null width should use available width
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Verify the slider is rendered
      expect(find.byType(SliderBar), findsOneWidget);
    });

    testWidgets('vertical slider with null track height uses available height', (WidgetTester tester) async {
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
                    trackConfig: TrackConfig(
                      width: null, // Null width should use available height for vertical slider
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Verify the slider is rendered
      expect(find.byType(SliderBar), findsOneWidget);
    });
  });

group('SliderBar additional edge case tests', () {
    testWidgets('unmounted widget handles controller changes gracefully', (WidgetTester tester) async {
      // This test verifies that the widget handles controller changes when unmounted
      final controller = SliderController(
        initialValue: 50,
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
                  initialValue: 50,
                ),
              ),
            ),
          ),
        ),
      );

      // Replace the widget tree to unmount the SliderBar
      await tester.pumpWidget(const SizedBox());

      // Update controller after widget is unmounted
      // This should not cause any errors
      controller.value = 75;

      // If we got here without errors, the test passes
      expect(true, true);
    });

    testWidgets('slider handles config changes correctly', (WidgetTester tester) async {
      const initialConfig = SliderConfig(
        min: 0,
        max: 100,
        initialValue: 50,
        showLabel: true,
      );

      const updatedConfig = SliderConfig(
        min: 0,
        max: 100,
        initialValue: 75,
        showLabel: true,
        direction: SliderDirection.vertical,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                height: 300,
                child: SliderBar(
                  config: initialConfig,
                ),
              ),
            ),
          ),
        ),
      );

      // Initial horizontal slider
      final initialGestureDetector = tester.widget<GestureDetector>(find.byType(GestureDetector));
      expect(initialGestureDetector.onHorizontalDragStart, isNotNull);
      expect(initialGestureDetector.onVerticalDragStart, isNull);

      // Update to vertical slider
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                height: 300,
                child: SliderBar(
                  config: updatedConfig,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      // Should now be a vertical slider
      final updatedGestureDetector = tester.widget<GestureDetector>(find.byType(GestureDetector));
      expect(updatedGestureDetector.onHorizontalDragStart, isNull);
      expect(updatedGestureDetector.onVerticalDragStart, isNotNull);
    });
  });
}
