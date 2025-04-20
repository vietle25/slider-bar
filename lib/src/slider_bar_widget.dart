import 'package:flutter/material.dart';
import 'controllers/slider_controller.dart';
import 'enums/slider_direction.dart';
import 'models/slider_config.dart';
import 'painters/slider_painter.dart';

/// A customizable slider widget.
class SliderBar extends StatefulWidget {
  /// Creates a slider bar.
  const SliderBar({
    super.key,
    this.config = const SliderConfig(),
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    SliderController? controller,
  }) : _controller = controller;

  /// Configuration for the slider.
  final SliderConfig config;

  /// Called when the user starts dragging the slider.
  final ValueChanged<double>? onChangeStart;

  /// Called during drag operations.
  final ValueChanged<double>? onChanged;

  /// Called when the user stops dragging the slider.
  final ValueChanged<double>? onChangeEnd;

  /// Controller for the slider.
  final SliderController? _controller;

  @override
  State<SliderBar> createState() => _SliderBarState();
}

class _SliderBarState extends State<SliderBar> {
  late SliderController _controller;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _controller = widget._controller ??
        SliderController(
          initialValue: widget.config.initialValue,
          min: widget.config.min,
          max: widget.config.max,
        );

    _controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(SliderBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget._controller != oldWidget._controller) {
      oldWidget._controller?.removeListener(_handleControllerChanged);
      _controller = widget._controller ??
          SliderController(
            initialValue: widget.config.initialValue,
            min: widget.config.min,
            max: widget.config.max,
          );
      _controller.addListener(_handleControllerChanged);
    }
  }

  void _handleControllerChanged() {
    if (mounted) {
      setState(() {
        // Just trigger a rebuild
      });
    }
  }

  void _handleDragStart(DragStartDetails details) {
    _isDragging = true;
    _updateValueFromGlobalPosition(details.globalPosition);
    widget.onChangeStart?.call(_controller.value);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_isDragging) {
      _updateValueFromGlobalPosition(details.globalPosition);
      widget.onChanged?.call(_controller.value);
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_isDragging) {
      _isDragging = false;
      widget.onChangeEnd?.call(_controller.value);
    }
  }

  void _updateValueFromGlobalPosition(Offset globalPosition) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(globalPosition);
    
    double percentage;
    if (widget.config.direction == SliderDirection.horizontal) {
      percentage = (localPosition.dx / renderBox.size.width).clamp(0.0, 1.0);
    } else {
      // For vertical slider, we invert the percentage (bottom = 0, top = 1)
      percentage = (1.0 - localPosition.dy / renderBox.size.height).clamp(0.0, 1.0);
    }
    
    _controller.value = _controller.valueFromPercentage(percentage);
  }

  @override
  Widget build(BuildContext context) {
    final bool isHorizontal = widget.config.direction == SliderDirection.horizontal;
    final trackConfig = widget.config.trackConfig;
    final thumbConfig = widget.config.thumbConfig;
    
    // Calculate the position of the thumb
    final percentage = _controller.percentage;
    
    // Build the slider based on direction
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final double maxHeight = constraints.maxHeight;
        
        // Determine track dimensions
        final double trackWidth = isHorizontal 
            ? trackConfig.width ?? maxWidth 
            : trackConfig.height;
        final double trackHeight = isHorizontal 
            ? trackConfig.height 
            : trackConfig.width ?? maxHeight;
        
        // Calculate thumb position
        final double thumbPosition = isHorizontal
            ? percentage * (trackWidth - thumbConfig.width) + thumbConfig.width / 2
            : (1 - percentage) * (trackHeight - thumbConfig.height) + thumbConfig.height / 2;
        
        return GestureDetector(
          onHorizontalDragStart: isHorizontal ? _handleDragStart : null,
          onHorizontalDragUpdate: isHorizontal ? _handleDragUpdate : null,
          onHorizontalDragEnd: isHorizontal ? _handleDragEnd : null,
          onVerticalDragStart: !isHorizontal ? _handleDragStart : null,
          onVerticalDragUpdate: !isHorizontal ? _handleDragUpdate : null,
          onVerticalDragEnd: !isHorizontal ? _handleDragEnd : null,
          child: Container(
            width: isHorizontal ? trackWidth : null,
            height: !isHorizontal ? trackHeight : null,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Track
                Positioned(
                  left: 0,
                  top: 0,
                  child: CustomPaint(
                    painter: SliderTrackPainter(
                      trackConfig: trackConfig,
                      percentage: percentage,
                      direction: widget.config.direction,
                    ),
                    size: Size(
                      isHorizontal ? trackWidth : trackConfig.height,
                      isHorizontal ? trackConfig.height : trackHeight,
                    ),
                  ),
                ),
                
                // Thumb
                Positioned(
                  left: isHorizontal ? thumbPosition - thumbConfig.width / 2 : 0,
                  top: !isHorizontal ? thumbPosition - thumbConfig.height / 2 : 0,
                  child: CustomPaint(
                    painter: SliderThumbPainter(
                      thumbConfig: thumbConfig,
                    ),
                    size: Size(
                      isHorizontal ? thumbConfig.width : trackConfig.height,
                      isHorizontal ? trackConfig.height : thumbConfig.height,
                    ),
                  ),
                ),
                
                // Label (if enabled)
                if (widget.config.showLabel)
                  Positioned(
                    left: isHorizontal ? thumbPosition - 20 : null,
                    bottom: isHorizontal ? -25 : null,
                    right: !isHorizontal ? -25 : null,
                    top: !isHorizontal ? thumbPosition - 10 : null,
                    child: Text(
                      widget.config.labelFormat != null
                          ? widget.config.labelFormat!(_controller.value)
                          : _controller.value.toStringAsFixed(1),
                      style: widget.config.labelStyle ??
                          TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Only dispose the controller if it was created internally
    if (widget._controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_handleControllerChanged);
    }
    super.dispose();
  }
}
