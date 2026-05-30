import 'package:flutter/material.dart';

/// A widget that tracks mouse hover state and optionally applies
/// a vertical lift transform to its child on hover.
///
/// The [builder] callback receives the current hover state, allowing
/// the child widget to react visually beyond just the transform.
///
/// Example usage:
/// ```dart
/// OnHover(
///   builder: (isHovered) => Text(
///     'Hover me',
///     style: TextStyle(color: isHovered ? Colors.blue : Colors.black),
///   ),
/// )
/// ```
class OnHover extends StatefulWidget {
  /// Called with the current hover state to build the child widget.
  final Widget Function(bool isHovered) builder;

  /// Whether to apply the lift transform on hover.
  ///
  /// If `true` (default), the widget translates upward when hovered.
  /// If `false`, only [builder] receives the updated hover state —
  /// useful when you want hover-driven styling without any movement.
  final bool enableTransform;

  /// Creates an [OnHover] widget.
  ///
  /// The [builder] argument must not be null.
  /// [enableTransform] defaults to `true`.
  const OnHover({
    super.key,
    required this.builder,
    this.enableTransform = true,
  });

  @override
  OnHoverState createState() => OnHoverState();
}

/// State for [OnHover]. Manages hover tracking and applies
/// the animated transform when [OnHover.enableTransform] is enabled.
class OnHoverState extends State<OnHover> {
  /// Whether the mouse is currently over this widget.
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hovered = Matrix4.identity()..translateByDouble(0, -10, 0, 1);
    final transform = widget.enableTransform && isHovered
        ? hovered
        : Matrix4.identity();

    return MouseRegion(
      onEnter: (_) => onEntered(true),
      onExit: (_) => onEntered(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: transform,
        child: widget.builder(isHovered),
      ),
    );
  }

  /// Updates [isHovered] when the cursor enters or exits the widget.
  void onEntered(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }
}
