import 'package:flutter/material.dart';
import '../enums/slider_direction.dart';

/// Configuration for the track of the slider.
class TrackConfig {
  /// Creates a track configuration.
  const TrackConfig({
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.height = 6.0,
    this.width,
    this.radius = 3.0,
  });

  /// Color of the active part of the track.
  final Color activeColor;

  /// Color of the inactive part of the track.
  final Color inactiveColor;

  /// Height of the track.
  final double height;

  /// Width of the track. If null, it will take the available width.
  final double? width;

  /// Radius of the track's corners.
  final double radius;

  /// Creates a copy of this configuration with the given fields replaced.
  TrackConfig copyWith({
    Color? activeColor,
    Color? inactiveColor,
    double? height,
    double? width,
    double? radius,
  }) {
    return TrackConfig(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      height: height ?? this.height,
      width: width ?? this.width,
      radius: radius ?? this.radius,
    );
  }
}

/// Configuration for the thumb of the slider.
class ThumbConfig {
  /// Creates a thumb configuration.
  const ThumbConfig({
    this.color = Colors.blue,
    this.width = 20.0,
    this.height = 20.0,
    this.radius = 10.0,
    this.shape = BoxShape.circle,
    this.elevation = 1.0,
    this.shadowColor = Colors.black26,
  });

  /// Color of the thumb.
  final Color color;

  /// Width of the thumb.
  final double width;

  /// Height of the thumb.
  final double height;

  /// Radius of the thumb's corners. Only applicable for rectangle shape.
  final double radius;

  /// Shape of the thumb.
  final BoxShape shape;

  /// Elevation of the thumb.
  final double elevation;

  /// Shadow color of the thumb.
  final Color shadowColor;

  /// Creates a copy of this configuration with the given fields replaced.
  ThumbConfig copyWith({
    Color? color,
    double? width,
    double? height,
    double? radius,
    BoxShape? shape,
    double? elevation,
    Color? shadowColor,
  }) {
    return ThumbConfig(
      color: color ?? this.color,
      width: width ?? this.width,
      height: height ?? this.height,
      radius: radius ?? this.radius,
      shape: shape ?? this.shape,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }
}

/// Configuration for the slider.
class SliderConfig {
  /// Creates a slider configuration.
  const SliderConfig({
    this.min = 0.0,
    this.max = 1.0,
    this.initialValue = 0.0,
    this.direction = SliderDirection.horizontal,
    this.trackConfig = const TrackConfig(),
    this.thumbConfig = const ThumbConfig(),
    this.showLabel = false,
    this.labelStyle,
    this.labelFormat,
  })  : assert(min < max, 'Min value must be less than max value'),
        assert(
          initialValue >= min && initialValue <= max,
          'Initial value must be between min and max values',
        );

  /// Minimum value of the slider.
  final double min;

  /// Maximum value of the slider.
  final double max;

  /// Initial value of the slider.
  final double initialValue;

  /// Direction of the slider.
  final SliderDirection direction;

  /// Configuration for the track.
  final TrackConfig trackConfig;

  /// Configuration for the thumb.
  final ThumbConfig thumbConfig;

  /// Whether to show a label with the current value.
  final bool showLabel;

  /// Style for the label text.
  final TextStyle? labelStyle;

  /// Format function for the label.
  final String Function(double)? labelFormat;

  /// Creates a copy of this configuration with the given fields replaced.
  SliderConfig copyWith({
    double? min,
    double? max,
    double? initialValue,
    SliderDirection? direction,
    TrackConfig? trackConfig,
    ThumbConfig? thumbConfig,
    bool? showLabel,
    TextStyle? labelStyle,
    String Function(double)? labelFormat,
  }) {
    return SliderConfig(
      min: min ?? this.min,
      max: max ?? this.max,
      initialValue: initialValue ?? this.initialValue,
      direction: direction ?? this.direction,
      trackConfig: trackConfig ?? this.trackConfig,
      thumbConfig: thumbConfig ?? this.thumbConfig,
      showLabel: showLabel ?? this.showLabel,
      labelStyle: labelStyle ?? this.labelStyle,
      labelFormat: labelFormat ?? this.labelFormat,
    );
  }
}
