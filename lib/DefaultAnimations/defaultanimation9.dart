import 'package:flutter/material.dart';
import 'package:vitality/vitality.dart';

class DefScreen9 extends StatefulWidget {
  final String animation9;
  const DefScreen9(this.animation9,
      {super.key, required MaterialColor selectedColor});

  @override
  _DefScreen9State createState() => _DefScreen9State();
}

class _DefScreen9State extends State<DefScreen9>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Vitality.randomly(
      background: Colors.black,
      maxOpacity: 0.8,
      minOpacity: 0.3,
      itemsCount: 80,
      enableXMovements: false,
      whenOutOfScreenMode: WhenOutOfScreenMode.Teleport,
      maxSpeed: 1.5,
      maxSize: 30,
      minSpeed: 0.5,
      randomItemsColors: const [
        Colors.yellow,
        Colors.blue,
        Colors.red,
      ],
      randomItemsBehaviours: [
        ItemBehaviour(shape: ShapeType.Icon, icon: Icons.star),
        ItemBehaviour(shape: ShapeType.Icon, icon: Icons.star_border),
        ItemBehaviour(shape: ShapeType.StrokeCircle),
      ],
    );
  }
}
