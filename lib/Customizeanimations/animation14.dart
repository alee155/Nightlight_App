import 'dart:math';

import 'package:flutter/material.dart';
import 'package:funvas/funvas.dart';
import 'package:nightlight/Customizeanimations/FunvasViewer.dart';

class Screen14 extends StatelessWidget {
  const Screen14({super.key});

  static final examples = <Funvas>[
    AnimatedLines(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: FunvasViewer(
          funvases: examples,
        ),
      ),
    );
  }
}

class AnimatedLines extends Funvas {
  @override
  void u(double t) {
    // Clear the canvas with a black background
    c.drawPaint(Paint()..color = Colors.black);

    // Set the center of the star
    final center = Offset(x.width / 2, x.height / 2);

    // Draw a pulsating star
    drawPulsatingStar(center, t);
  }

  void drawPulsatingStar(Offset center, double t) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10.0;

    // Define the number of arms in the star
    const numArms = 15;

    // Define an array of colors
    final colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.pink,
    ];

    // Draw star arms with a pulsating effect
    for (var i = 0; i < numArms; i++) {
      final angle = t + i * 2 * pi / numArms;
      final length = 100.0 + 50.0 * sin(t + i * 0.5);
      final alpha = (255 * (1.0 - i / numArms)).toInt();

      // Use modulo to cycle through the colors
      final colorIndex = i % colors.length;
      paint.color = colors[colorIndex].withOpacity(alpha / 255);

      final x1 = center.dx + length * cos(angle);
      final y1 = center.dy + length * sin(angle);
      final x2 = center.dx + 2 * length * cos(angle);
      final y2 = center.dy + 2 * length * sin(angle);

      c.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }
}
