import 'package:flutter/material.dart';

class PulsingWrapper extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double maxScale;

  const PulsingWrapper({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.maxScale = 1.1,
  }) : super(key: key);

  @override
  _PulsingWrapperState createState() => _PulsingWrapperState();
}

class _PulsingWrapperState extends State<PulsingWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 1.0,
      end: widget.maxScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}