import 'dart:math';

import 'package:flutter/material.dart';
import 'package:funvas/funvas.dart';
import 'package:nightlight/Customizeanimations/FunvasViewer.dart';

class Screen15 extends StatelessWidget {
  final String animation15;
  const Screen15(this.animation15, {super.key});
  static final examples = <Funvas>[
    Circle(),
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

class Circle extends Funvas {
  @override
  void u(double t) {
    // Clear the canvas with a black background
    c.drawPaint(Paint()..color = Colors.black);

    // Set the center of the circles
    final center = Offset(x.width / 2, x.height / 2);

    // Draw pulsating concentric circles with padding
    drawPulsatingCircles(center, t);
  }

  void drawPulsatingCircles(Offset center, double t) {
    final paint = Paint()..strokeWidth = 10.0;

    // Define the number of circles
    const numCircles = 20;

    // Define an array of colors
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.cyan,
      Colors.pink,
      Colors.teal,
      Colors.amber,
      Colors.indigo,
      Colors.brown,
      Colors.lime,
      Colors.deepOrange,
      Colors.lightGreen,
      Colors.deepPurple,
      Colors.amberAccent,
      Colors.lightBlue,
      Colors.deepOrangeAccent,
      Colors.blueGrey,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.blueAccent,
      Colors.yellowAccent,
      Colors.purpleAccent,
      Colors.orangeAccent,
      Colors.cyanAccent,
      Colors.pinkAccent,
      Colors.tealAccent,
      Colors.amberAccent,
      Colors.indigoAccent,
      Colors.brown,
      Colors.limeAccent,
      Colors.deepOrangeAccent,
      Colors.lightGreenAccent,
      Colors.deepPurpleAccent,
      Colors.amberAccent,
      Colors.lightBlueAccent,
      Colors.deepOrangeAccent,
      Colors.blueGrey,
    ];

    // Define padding
    const padding = 50.0;

    // Draw concentric circles with a pulsating effect and padding
    for (var i = 0; i < numCircles; i++) {
      final radius = 100.0 + 100.0 * sin(t + i * 0.5) - padding;
      final alpha = (255 * (1.0 - i / numCircles)).toInt();

      // Use modulo to cycle through the colors
      final colorIndex = i % colors.length;
      paint.color = colors[colorIndex].withOpacity(alpha / 255);

      // Adjust center coordinates to be at the center of the screen
      c.drawCircle(Offset(center.dx, center.dy), radius, paint);
    }
  }
}
