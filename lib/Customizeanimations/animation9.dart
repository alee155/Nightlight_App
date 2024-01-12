import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vitality/vitality.dart';

class Screen9 extends StatefulWidget {
  final Color selectedColor;

  const Screen9({Key? key, required this.selectedColor}) : super(key: key);

  @override
  _Screen9State createState() => _Screen9State();
}

class _Screen9State extends State<Screen9> with SingleTickerProviderStateMixin {
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
    return Vitality.randomly(
      key: Key(widget.selectedColor.toString()), // Add a key to force rebuild
      background: Colors.black,
      maxOpacity: 0.8,
      minOpacity: 0.3,
      itemsCount: 80,
      enableXMovements: false,
      whenOutOfScreenMode: WhenOutOfScreenMode.Teleport,
      maxSpeed: 1.5,
      maxSize: 30,
      minSpeed: 0.5,
      randomItemsColors: [
        widget.selectedColor,
        generateRandomColor(), // Random color for the second ItemBehaviour
        generateRandomColor(), // Random color for the third ItemBehaviour
      ],
      randomItemsBehaviours: [
        ItemBehaviour(shape: ShapeType.Icon, icon: Icons.star),
        ItemBehaviour(shape: ShapeType.Icon, icon: Icons.star_border),
        ItemBehaviour(shape: ShapeType.StrokeCircle),
      ],
    );
  }
}
