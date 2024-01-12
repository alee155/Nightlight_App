import 'dart:math';

import 'package:flutter/material.dart';
import 'package:funvas/funvas.dart';
import 'package:nightlight/Customizeanimations/FunvasViewer.dart';

class Screen12 extends StatelessWidget {
  final String animation12;
  const Screen12(this.animation12, {super.key});

  static final examples = <Funvas>[
    FourAnimatedMovingLights(),
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

class FourAnimatedMovingLights extends Funvas {
  @override
  void u(double t) {
    // Clear the canvas with a black background
    c.drawPaint(Paint()..color = Colors.black);

    // Set the number of columns and rows
    const numColumns = 2;
    const numRows = 2;

    // Set the dimensions of each grid cell
    final columnWidth = x.width / numColumns;
    final rowHeight = x.height / numRows;

    // Draw stars in a grid pattern
    for (int col = 0; col < numColumns; col++) {
      for (int row = 0; row < numRows; row++) {
        final centerX = columnWidth / 2 + col * columnWidth;
        final centerY = rowHeight / 2 + row * rowHeight;

        // Increase the speed of the pulsating pattern
        const speedMultiplier = 2.0;

        // Draw two pulsating stars in each cell
        drawPulsatingStar(Offset(centerX, centerY), t * speedMultiplier, 1);
        drawPulsatingStar(Offset(centerX, centerY), t * speedMultiplier, 2);
      }
    }
  }

  void drawPulsatingStar(Offset center, double t, int index) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5.0;

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

    // Increase the size of the star arms by adjusting the armLength
    const armLengthMultiplier = 2.0;

    // Increase the speed of the pulsating effect
    const pulsatingSpeedMultiplier = 2.0;

    // Draw a star with a pulsating effect
    for (var i = 0; i < numArms; i++) {
      final angle = t + i * 2 * pi / numArms;
      final armLength = 60.0 +
          40.0 *
              sin(t * pulsatingSpeedMultiplier + i * 0.5) *
              armLengthMultiplier;
      final alpha = (255 * (1.0 - i / numArms)).toInt();

      // Use modulo to cycle through the colors
      final colorIndex = (i + index) % colors.length;
      paint.color = colors[colorIndex].withOpacity(alpha / 255);

      final x1 = center.dx + armLength * cos(angle);
      final y1 = center.dy + armLength * sin(angle);
      final x2 = center.dx + armLength * cos(angle + 2 * pi / 3);
      final y2 = center.dy + armLength * sin(angle + 2 * pi / 3);
      final x3 = center.dx + armLength * cos(angle + 4 * pi / 3);
      final y3 = center.dy + armLength * sin(angle + 4 * pi / 3);

      c.drawLine(center, Offset(x1, y1), paint);
      c.drawLine(center, Offset(x2, y2), paint);
      c.drawLine(center, Offset(x3, y3), paint);
    }
  }
}
