# SliderBar

A highly customizable slider widget for Flutter applications. This package provides a slider that can be extensively styled and configured to match your app's design.

## Demo

<img width="500" alt="Slider demo" src="https://github.com/user-attachments/assets/81aaab92-b232-4b7d-9cc3-fc7abaa44abc" />


## Features

- Horizontal and vertical slider orientations
- Customizable track (active and inactive parts)
- Customizable thumb with different shapes
- Value labels with custom formatting
- Configurable min/max values
- Controller for programmatic control

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  slider_bar: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:slider_bar/slider_bar.dart';

SliderBar(
  config: SliderConfig(
    min: 0,
    max: 100,
    initialValue: 50,
  ),
  onChanged: (value) {
    print('Current value: $value');
  },
)
```

### Customizing the Slider

```dart
SliderBar(
  config: SliderConfig(
    min: 0,
    max: 100,
    initialValue: 50,
    direction: SliderDirection.horizontal, // or SliderDirection.vertical
    showLabel: true,
    labelFormat: (value) => value.toInt().toString(),
    trackConfig: TrackConfig(
      activeColor: Colors.blue,
      inactiveColor: Colors.grey.shade300,
      height: 8,
      radius: 4,
    ),
    thumbConfig: ThumbConfig(
      color: Colors.blue,
      width: 24,
      height: 24,
      shape: BoxShape.circle, // or BoxShape.rectangle
      radius: 12, // for rectangle shape
      elevation: 2,
      shadowColor: Colors.black26,
    ),
  ),
  onChanged: (value) {
    // Handle value change
  },
  onChangeStart: (value) {
    // Handle drag start
  },
  onChangeEnd: (value) {
    // Handle drag end
  },
)
```

### Using a Controller

```dart
final SliderController controller = SliderController(
  initialValue: 50,
  min: 0,
  max: 100,
);

// Later in your widget build method
SliderBar(
  controller: controller,
  config: SliderConfig(
    min: 0,
    max: 100,
    initialValue: 50,
  ),
)

// Update the slider programmatically
controller.value = 75;

// Don't forget to dispose the controller
@override
void dispose() {
  controller.dispose();
  super.dispose();
}
```

## Configuration Options

### SliderConfig

| Property | Type | Description |
|----------|------|-------------|
| min | double | Minimum value of the slider |
| max | double | Maximum value of the slider |
| initialValue | double | Initial value of the slider |
| direction | SliderDirection | Orientation of the slider (horizontal or vertical) |
| trackConfig | TrackConfig | Configuration for the track |
| thumbConfig | ThumbConfig | Configuration for the thumb |
| showLabel | bool | Whether to show a label with the current value |
| labelStyle | TextStyle? | Style for the label text |
| labelFormat | Function? | Format function for the label |

### TrackConfig

| Property | Type | Description |
|----------|------|-------------|
| activeColor | Color | Color of the active part of the track |
| inactiveColor | Color | Color of the inactive part of the track |
| height | double | Height of the track |
| width | double? | Width of the track (if null, takes available width) |
| radius | double | Radius of the track's corners |

### ThumbConfig

| Property | Type | Description |
|----------|------|-------------|
| color | Color | Color of the thumb |
| width | double | Width of the thumb |
| height | double | Height of the thumb |
| radius | double | Radius of the thumb's corners (for rectangle shape) |
| shape | BoxShape | Shape of the thumb (circle or rectangle) |
| elevation | double | Elevation of the thumb |
| shadowColor | Color | Shadow color of the thumb |

## Examples

See the `/example` folder for a complete example app demonstrating various configurations of the slider.
