import 'package:flutter/material.dart';
import 'package:metaballs/metaballs.dart';

class Screen6 extends StatefulWidget {
  final Color selectedColor;

  const Screen6({
    super.key,
    required this.selectedColor,
  });

  @override
  _Screen6State createState() => _Screen6State();
}

class _Screen6State extends State<Screen6> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Metaballs(
        effect: MetaballsEffect.follow(
          growthFactor: 1,
          smoothing: 1,
          radius: 0.5,
        ),
        metaballs: 20,
        animationDuration: const Duration(milliseconds: 500),
        speedMultiplier: 5.0, // Default speed value
        bounceStiffness: 40,
        minBallRadius: 5,
        maxBallRadius: 40,
        glowRadius: 0.7,
        glowIntensity: 1.0,
        color: widget.selectedColor, // Use the selected color
      ),
    );
  }
}
