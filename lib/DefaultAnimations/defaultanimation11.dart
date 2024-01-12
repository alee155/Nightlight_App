import 'dart:math';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';

class Screen11 extends StatefulWidget {
  final String animation11;
  const Screen11(this.animation11, {super.key});

  @override
  _Screen11State createState() => _Screen11State();
}

class _Screen11State extends State<Screen11>
    with SingleTickerProviderStateMixin {
  Random random = Random();

  Color generateRandomColor() {
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          Colors.pink,
          Colors.yellow,
          Colors.red,
        ],
        secondaryColors: const [
          Colors.green,
          Colors.white,
          Colors.brown,
        ],
      ),
    );
  }
}
