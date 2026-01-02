import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedPillsBackground extends StatefulWidget {
  const AnimatedPillsBackground({
    super.key,
    this.rows,
    this.columns,
    this.color = Colors.blueGrey,
    this.duration = const Duration(seconds: 5),
    this.pillAspectRatio = 0.15,
  });

  /// Number of rows of pills (auto-calculated if null)
  final int? rows;

  /// Number of columns of pills (auto-calculated if null)
  final int? columns;

  /// Base color of pills
  final Color color;

  /// Animation duration (controls breathing speed)
  final Duration duration;

  /// Aspect ratio for pill width relative to cell width
  final double pillAspectRatio;

  @override
  State<AnimatedPillsBackground> createState() =>
      _AnimatedPillsBackgroundState();
}

class _AnimatedPillsBackgroundState extends State<AnimatedPillsBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  List<_Pill>? _pills;
  final Random _random = Random();
  Size? _lastSize;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializePills(Size size) {
    if (_lastSize == size && _pills != null) return;
    _lastSize = size;

    // Calculate optimal grid dimensions based on screen size
    final rows = widget.rows ?? _calculateRows(size);
    final columns = widget.columns ?? _calculateColumns(size);

    _pills = List.generate(rows * columns, (index) {
      final baseHeight = 5.0 + _random.nextDouble() * 15;
      final delay = _random.nextDouble() * 2 * pi;
      return _Pill(baseHeight, delay);
    });
  }

  int _calculateRows(Size size) {
    // Aim for roughly 60-80px per row
    return max(6, (size.height / 70).round());
  }

  int _calculateColumns(Size size) {
    // Aim for roughly 60-80px per column
    return max(10, (size.width / 70).round());
  }

  double _animatedHeight(_Pill pill, double t, double baseScale) {
    final anim = sin((t * 2 * pi) + pill.delay);
    final normalized = (anim + 1) / 2;
    return (pill.baseHeight * baseScale) + normalized * (20 * baseScale);
  }

  double _animatedOpacity(_Pill pill, double t) {
    final anim = sin((t * 2 * pi) + pill.delay);
    final normalized = (anim + 1) / 2;
    return 0.1 + normalized * 0.4;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _initializePills(size);

        if (_pills == null) return const SizedBox.shrink();

        final rows = widget.rows ?? _calculateRows(size);
        final columns = widget.columns ?? _calculateColumns(size);
        
        // Scale factor based on screen size
        final baseScale = min(size.width, size.height) / 600;

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = Curves.easeInOut.transform(_controller.value);
            return CustomPaint(
              painter: _PillsGridPainter(
                pills: _pills!,
                time: t,
                rows: rows,
                columns: columns,
                heightFn: (pill, time) => _animatedHeight(pill, time, baseScale),
                opacityFn: _animatedOpacity,
                color: widget.color,
                pillAspectRatio: widget.pillAspectRatio,
              ),
              child: Container(),
            );
          },
        );
      },
    );
  }
}

class _Pill {
  final double baseHeight;
  final double delay;
  _Pill(this.baseHeight, this.delay);
}

class _PillsGridPainter extends CustomPainter {
  final List<_Pill> pills;
  final double time;
  final int rows;
  final int columns;
  final double Function(_Pill, double) heightFn;
  final double Function(_Pill, double) opacityFn;
  final Color color;
  final double pillAspectRatio;

  _PillsGridPainter({
    required this.pills,
    required this.time,
    required this.rows,
    required this.columns,
    required this.heightFn,
    required this.opacityFn,
    required this.color,
    required this.pillAspectRatio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final cellWidth = size.width / (columns + 1);
    final cellHeight = size.height / (rows + 1);
    
    // Make pill width responsive to cell size
    final pillWidth = cellWidth * pillAspectRatio;
    final cornerRadius = min(pillWidth / 2, 6.0);

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        final index = row * columns + col;
        if (index >= pills.length) continue;
        
        final pill = pills[index];

        final baseCx = (col + 1) * cellWidth;
        final baseCy = (row + 1) * cellHeight;
        final h = heightFn(pill, time);
        final opacity = opacityFn(pill, time);

        // Horizontally displace alternate rows
        final cx = baseCx + ((row % 2 == 1) ? (cellWidth * 0.5) : 0);
        // Vertically displace alternate columns
        final cy = baseCy + ((col % 2 == 1) ? (h * 0.5) : 0);

        paint.color = color.withOpacity(opacity);

        final rect = RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(cx, cy),
            width: h,
            height: pillWidth,
          ),
          Radius.circular(cornerRadius),
        );
        canvas.drawRRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}