import 'dart:math';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';

class Screen11 extends StatefulWidget {
  final Color selectedColor;
  const Screen11({Key? key, required this.selectedColor}) : super(key: key);

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
        key: Key(widget.selectedColor.toString()),
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: [
          widget.selectedColor,
          generateRandomColor(), // Random color for the second ItemBehaviour
          generateRandomColor(),
        ],
        secondaryColors: [
          generateRandomColor(), // Random color for the second ItemBehaviour
          generateRandomColor(),
          generateRandomColor(), // Random color for the second ItemBehaviour
        ],
      ),
    );
  }
}
