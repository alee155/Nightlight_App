import 'package:flutter/material.dart';
import 'package:particles_fly/particles_fly.dart';

class Screen8 extends StatelessWidget {
  final String animation8;
  const Screen8(this.animation8, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ParticlesFly(
          height: size.height,
          width: size.width,
          connectDots: true,
          numberOfParticles: 100,
          lineColor: Colors.white,
        ),
      ),
    );
  }
}
