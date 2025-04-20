import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slider_bar/slider_bar.dart';

void main() {
  group('TrackConfig tests', () {
    test('initializes with default values', () {
      const config = TrackConfig();
      
      expect(config.activeColor, Colors.blue);
      expect(config.inactiveColor, Colors.grey);
      expect(config.height, 6.0);
      expect(config.width, null);
      expect(config.radius, 3.0);
    });
    
    test('initializes with custom values', () {
      const config = TrackConfig(
        activeColor: Colors.red,
        inactiveColor: Colors.black,
        height: 10.0,
        width: 200.0,
        radius: 5.0,
      );
      
      expect(config.activeColor, Colors.red);
      expect(config.inactiveColor, Colors.black);
      expect(config.height, 10.0);
      expect(config.width, 200.0);
      expect(config.radius, 5.0);
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
    
    test('copyWith with null values keeps original values', () {
      const config = TrackConfig(
        activeColor: Colors.red,
        inactiveColor: Colors.black,
        height: 10.0,
        width: 200.0,
        radius: 5.0,
      );
      
      final updatedConfig = config.copyWith();
      
      expect(updatedConfig.activeColor, Colors.red);
      expect(updatedConfig.inactiveColor, Colors.black);
      expect(updatedConfig.height, 10.0);
      expect(updatedConfig.width, 200.0);
      expect(updatedConfig.radius, 5.0);
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
    
    test('initializes with custom values', () {
      const config = ThumbConfig(
        color: Colors.green,
        width: 30.0,
        height: 30.0,
        radius: 15.0,
        shape: BoxShape.rectangle,
        elevation: 2.0,
        shadowColor: Colors.black45,
      );
      
      expect(config.color, Colors.green);
      expect(config.width, 30.0);
      expect(config.height, 30.0);
      expect(config.radius, 15.0);
      expect(config.shape, BoxShape.rectangle);
      expect(config.elevation, 2.0);
      expect(config.shadowColor, Colors.black45);
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
    
    test('copyWith with null values keeps original values', () {
      const config = ThumbConfig(
        color: Colors.green,
        width: 30.0,
        height: 30.0,
        radius: 15.0,
        shape: BoxShape.rectangle,
        elevation: 2.0,
        shadowColor: Colors.black45,
      );
      
      final updatedConfig = config.copyWith();
      
      expect(updatedConfig.color, Colors.green);
      expect(updatedConfig.width, 30.0);
      expect(updatedConfig.height, 30.0);
      expect(updatedConfig.radius, 15.0);
      expect(updatedConfig.shape, BoxShape.rectangle);
      expect(updatedConfig.elevation, 2.0);
      expect(updatedConfig.shadowColor, Colors.black45);
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
      expect(config.trackConfig, isA<TrackConfig>());
      expect(config.thumbConfig, isA<ThumbConfig>());
    });
    
    test('initializes with custom values', () {
      final labelStyle = TextStyle(fontSize: 14, color: Colors.red);
      String formatLabel(double value) => '${value.toInt()}%';
      
      final config = SliderConfig(
        min: 10.0,
        max: 90.0,
        initialValue: 50.0,
        direction: SliderDirection.vertical,
        showLabel: true,
        labelStyle: labelStyle,
        labelFormat: formatLabel,
        trackConfig: const TrackConfig(
          activeColor: Colors.red,
          height: 8.0,
        ),
        thumbConfig: const ThumbConfig(
          color: Colors.green,
          shape: BoxShape.rectangle,
        ),
      );
      
      expect(config.min, 10.0);
      expect(config.max, 90.0);
      expect(config.initialValue, 50.0);
      expect(config.direction, SliderDirection.vertical);
      expect(config.showLabel, true);
      expect(config.labelStyle, labelStyle);
      expect(config.labelFormat, formatLabel);
      expect(config.labelFormat!(50.0), '50%');
      expect(config.trackConfig.activeColor, Colors.red);
      expect(config.trackConfig.height, 8.0);
      expect(config.thumbConfig.color, Colors.green);
      expect(config.thumbConfig.shape, BoxShape.rectangle);
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
        trackConfig: const TrackConfig(activeColor: Colors.red),
        thumbConfig: const ThumbConfig(color: Colors.green),
      );
      
      expect(updatedConfig.min, 10);
      expect(updatedConfig.max, 90);
      expect(updatedConfig.initialValue, 40);
      expect(updatedConfig.direction, SliderDirection.vertical);
      expect(updatedConfig.showLabel, true);
      expect(updatedConfig.trackConfig.activeColor, Colors.red);
      expect(updatedConfig.thumbConfig.color, Colors.green);
      
      // Original should be unchanged
      expect(config.min, 0);
      expect(config.max, 100);
      expect(config.initialValue, 50);
      expect(config.direction, SliderDirection.horizontal);
      expect(config.showLabel, false);
      expect(config.trackConfig.activeColor, Colors.blue);
      expect(config.thumbConfig.color, Colors.blue);
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
}
