import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class MyAnimatedBackground extends StatefulWidget {
  final Color selectedColor;

  const MyAnimatedBackground({Key? key, required this.selectedColor})
      : super(key: key);

  @override
  State<MyAnimatedBackground> createState() => _MyAnimatedBackgroundState();
}

class _MyAnimatedBackgroundState extends State<MyAnimatedBackground>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Expanded(
        child: AnimatedBackground(
          vsync: this,
          behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
              baseColor: widget.selectedColor, // Use the selected color
              spawnOpacity: 0.0,
              opacityChangeRate: 0.25,
              minOpacity: 0.1,
              maxOpacity: 0.4,
              particleCount: 500,
              spawnMaxRadius: 15.0,
              spawnMaxSpeed: 30, // Default speed value
              spawnMinSpeed: 30,
              spawnMinRadius: 7.0,
            ),
          ),
          child: const Center(),
        ),
      ),
    );
  }
}
