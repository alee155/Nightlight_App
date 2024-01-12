import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';

class Screen4 extends StatefulWidget {
  final Color selectedColor;

  const Screen4({Key? key, required this.selectedColor}) : super(key: key);

  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> with TickerProviderStateMixin {
  late ParticleOptions particleOptions;
  final Paint particlePaint = Paint()
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 10.0;

  @override
  void initState() {
    super.initState();
    // Initialize particleOptions with the selected color
    particleOptions = _createParticleOptions(widget.selectedColor);
  }

  @override
  void didUpdateWidget(covariant Screen4 oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update particleOptions when the selected color changes
    if (oldWidget.selectedColor != widget.selectedColor) {
      setState(() {
        particleOptions = _createParticleOptions(widget.selectedColor);
      });
    }
  }

  ParticleOptions _createParticleOptions(Color color) {
    return ParticleOptions(
      baseColor: color,
      spawnOpacity: 0.1,
      opacityChangeRate: 0.25,
      minOpacity: 0.1,
      maxOpacity: 0.4,
      spawnMinSpeed: 2.0,
      spawnMaxSpeed: 7.0,
      spawnMinRadius: 7.0,
      spawnMaxRadius: 15.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: particleOptions,
          paint: particlePaint,
        ),
        vsync: this,
        child: const Text(''),
      ),
    );
  }
}
