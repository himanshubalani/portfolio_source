import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class SineWaveAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const SineWaveAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  State<SineWaveAnimation> createState() => _SineWaveAnimationState();
}

class _SineWaveAnimationState extends State<SineWaveAnimation>
    with SingleTickerProviderStateMixin {
  Timer? _hoverTimer;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _waveOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {}); // hides wave after fade-out finishes
      }
    });

    _animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller);

    // Create smooth opacity animation for text with curves
    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 10.0,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(0.0),
        weight: 80.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 10.0,
      ),
    ]).animate(_controller);

    // Create smooth opacity animation for wave
    _waveOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 20.0,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 60.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 20.0,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    _hoverTimer?.cancel();
  }

  void playAnimation() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        // Start a 500ms delay before playing animation
        _hoverTimer = Timer(const Duration(milliseconds: 500), () {
          if (mounted) playAnimation();
        });
      },
      onExit: (_) {
        // Cancel the timer if the user leaves early
        _hoverTimer?.cancel();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: SineWavePainter(
              phase: _animation.value,
              showWave:
                  _waveOpacityAnimation.value > 0.01, // only show while visible
              waveOpacity: _waveOpacityAnimation.value,
            ),
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class SineWavePainter extends CustomPainter {
  final double phase;
  final bool showWave;
  final double waveOpacity;

  SineWavePainter({
    required this.phase,
    required this.showWave,
    this.waveOpacity = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!showWave) return;

    final paint = Paint()
      ..color = Colors.black.withOpacity(waveOpacity)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw the horizontal divider line
    final dividerPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      dividerPaint,
    );

    // Draw the sine wave
    final path = Path();
    final amplitude = size.height / 2.8;
    const frequency = 2.8;
    final centerY = size.height / 2;

    path.moveTo(0, centerY + amplitude * math.sin(-phase));

    for (double x = 0; x <= size.width; x += 1) {
      final y = centerY +
          amplitude *
              math.sin((x / size.width) * frequency * 2 * math.pi - phase);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SineWavePainter oldDelegate) {
    return oldDelegate.phase != phase || oldDelegate.showWave != showWave;
  }
}
