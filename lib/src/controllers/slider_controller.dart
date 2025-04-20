import 'package:flutter/foundation.dart';

/// Controller for the slider.
class SliderController extends ChangeNotifier {
  /// Creates a slider controller.
  SliderController({
    double initialValue = 0.0,
    required this.min,
    required this.max,
  })  : assert(min < max, 'Min value must be less than max value'),
        assert(
          initialValue >= min && initialValue <= max,
          'Initial value must be between min and max values',
        ),
        _value = initialValue;

  /// Minimum value of the slider.
  final double min;

  /// Maximum value of the slider.
  final double max;

  double _value;

  /// Current value of the slider.
  double get value => _value;

  /// Sets the value of the slider.
  set value(double newValue) {
    // Ensure the value is within the range
    final clampedValue = newValue.clamp(min, max);
    
    if (_value != clampedValue) {
      _value = clampedValue;
      notifyListeners();
    }
  }

  /// Updates the value of the slider.
  void updateValue(double newValue) {
    value = newValue;
  }

  /// Calculates the percentage of the current value.
  double get percentage => (value - min) / (max - min);

  /// Calculates the value from a percentage.
  double valueFromPercentage(double percentage) {
    final clampedPercentage = percentage.clamp(0.0, 1.0);
    return min + (max - min) * clampedPercentage;
  }

  /// Resets the value to the initial value.
  void reset(double initialValue) {
    assert(
      initialValue >= min && initialValue <= max,
      'Initial value must be between min and max values',
    );
    _value = initialValue;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
