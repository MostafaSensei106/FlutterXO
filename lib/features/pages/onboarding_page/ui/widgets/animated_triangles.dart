import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedGameShapes extends StatefulWidget {
  const AnimatedGameShapes({super.key});

  @override
  State<AnimatedGameShapes> createState() => _AnimatedGameShapesState();
}

class _AnimatedGameShapesState extends State<AnimatedGameShapes>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<GameShape> _shapes = [];
  final Paint _shapePaint = Paint()..style = PaintingStyle.fill;
  final Paint _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0;

  // Material 3 Colors
  final List<Color> _material3Colors = [
    const Color(0xFF6750A4), // Primary Purple
    const Color(0xFF625B71), // Secondary Purple
    const Color(0xFF7D5260), // Tertiary Pink
    const Color(0xFFB3261E), // Error Red
    const Color(0xFF006A6B), // Success Teal
    const Color(0xFF1D192B), // Surface Dark
    const Color(0xFF49454F), // Outline
    const Color(0xFF79747E), // Outline Variant
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    // Create 12 shapes (mix of X and O)
    for (var i = 0; i < 12; i++) {
      _shapes.add(
        GameShape(
          shapeType: i.isEven ? ShapeType.x : ShapeType.o,
          color: _material3Colors[Random().nextInt(_material3Colors.length)],
        ),
      );
    }
  }

  @override
  Widget build(final BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (final context, final child) => CustomPaint(
      painter: GameShapePainter(
        shapes: _shapes,
        animationValue: _controller.value,
        screenSize: MediaQuery.of(context).size,
        shapePaint: _shapePaint,
        borderPaint: _borderPaint,
      ),
      size: Size.infinite,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

enum ShapeType { x, o }

class GameShape {
  GameShape({required this.shapeType, required this.color})
    : relativeX = Random().nextDouble(),
      relativeY = Random().nextDouble(),
      size = Random().nextDouble() * 50 + 40,
      speedFactor = Random().nextDouble() * 0.8 + 0.3,
      rotationSpeed = Random().nextDouble() * 2 + 1;

  final ShapeType shapeType;
  final double relativeX;
  final double relativeY;
  final double size;
  final double speedFactor;
  final double rotationSpeed;
  final Color color;
}

class GameShapePainter extends CustomPainter {
  GameShapePainter({
    required this.shapes,
    required this.animationValue,
    required this.screenSize,
    required this.shapePaint,
    required this.borderPaint,
  });

  final List<GameShape> shapes;
  final double animationValue;
  final Size screenSize;
  final Paint shapePaint;
  final Paint borderPaint;

  @override
  void paint(final Canvas canvas, final Size size) {
    for (var shape in shapes) {
      final baseX = shape.relativeX * screenSize.width;
      final baseY = shape.relativeY * screenSize.height;

      // Floating animation
      final floatOffset = sin(animationValue * 2 * pi * shape.speedFactor) * 25;
      final adjustedX = baseX;
      final adjustedY = baseY + floatOffset;

      // Opacity animation
      final opacity = (sin(animationValue * 2 * pi * 0.7) + 1) / 2;

      // Rotation animation
      final rotation = animationValue * 2 * pi * shape.rotationSpeed;

      canvas.save();
      canvas.translate(adjustedX, adjustedY);
      canvas.rotate(rotation);

      if (shape.shapeType == ShapeType.x) {
        _drawX(canvas, shape, opacity);
      } else {
        _drawO(canvas, shape, opacity);
      }

      canvas.restore();
    }
  }

  void _drawX(Canvas canvas, GameShape shape, double opacity) {
    final strokeWidth = shape.size * 0.15;
    final halfSize = shape.size / 2;

    shapePaint.color = shape.color.withAlpha((opacity * 200).toInt());
    borderPaint.color = shape.color.withAlpha((opacity * 255).toInt());
    borderPaint.strokeWidth = strokeWidth;

    // Draw X using two lines
    final path1 = Path()
      ..moveTo(-halfSize * 0.7, -halfSize * 0.7)
      ..lineTo(halfSize * 0.7, halfSize * 0.7);

    final path2 = Path()
      ..moveTo(halfSize * 0.7, -halfSize * 0.7)
      ..lineTo(-halfSize * 0.7, halfSize * 0.7);

    canvas.drawPath(path1, borderPaint);
    canvas.drawPath(path2, borderPaint);
  }

  void _drawO(Canvas canvas, GameShape shape, double opacity) {
    final strokeWidth = shape.size * 0.12;
    final radius = shape.size * 0.35;

    shapePaint.color = shape.color.withAlpha((opacity * 80).toInt());
    borderPaint.color = shape.color.withAlpha((opacity * 255).toInt());
    borderPaint.strokeWidth = strokeWidth;

    // Draw filled circle with border
    canvas.drawCircle(Offset.zero, radius, shapePaint);
    canvas.drawCircle(Offset.zero, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant final GameShapePainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
