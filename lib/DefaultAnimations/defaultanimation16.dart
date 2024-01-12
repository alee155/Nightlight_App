import 'dart:math';

import 'package:flutter/material.dart';
import 'package:funvas/funvas.dart';
import 'package:nightlight/Customizeanimations/FunvasViewer.dart';

class Screen16 extends StatelessWidget {
  final String animation16;
  const Screen16(this.animation16, {super.key});

  static final examples = <Funvas>[
    // ExampleFunvas(),
    // WaveFunvas(),
    Animation2(),
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

class Animation2 extends Funvas {
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    // Add more colors as needed
  ];

  @override
  void u(double t) {
    c.scale(x.width / 1920, x.height / 1080);

    final v = t + 400;
    for (var q = 0; q < 255; q += 5) {
      final index = q % colors.length;
      final paint = Paint()..color = colors[index];

      final radius = q.toDouble();

      // Adjust the angle to make the circles face towards the front side
      final angle = v - q.toDouble() - pi / 20;

      final xPosition = 1920 / 2 + radius * C(angle);
      final yPosition = 540 + radius * S(angle);

      c.drawCircle(
        Offset(xPosition, yPosition),
        20, // Adjust the circle size
        paint,
      );
    }
  }
}
