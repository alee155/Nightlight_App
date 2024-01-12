import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particle_field/particle_field.dart';
import 'package:rnd/rnd.dart';

// This is a very quick and dirty example.
class Screen7 extends StatelessWidget {
  const Screen7({super.key});

  @override
  Widget build(BuildContext context) {
    // Load a sprite sheet for particle animation
    final SpriteSheet sparkleSpriteSheet = SpriteSheet(
      image: const AssetImage('assets/images/particle-21x23.png'),
      frameWidth: 11,
    );

    // Simple "star" particle field
    final ParticleField starField = ParticleField(
      spriteSheet: sparkleSpriteSheet,
      blendMode: BlendMode.dstIn,
      origin: Alignment.topLeft,
      // onTick is where particle creation and updates happen
      onTick: (controller, elapsed, size) {
        List<Particle> particles = controller.particles;
        // Add a new particle each frame
        particles.add(Particle(
          color: Colors.white,
          x: rnd(size.width),
          scale: rnd(0.2, 0.5),
          frame: rnd(sparkleSpriteSheet.length * 1.0).floor(),
          vy: rnd(6, 20),
        ));
        // Update existing particles and remove if out of bounds
        for (int i = particles.length - 1; i >= 0; i--) {
          Particle particle = particles[i];
          particle.update();
          if (!size.contains(particle.toOffset())) particles.removeAt(i);
        }
      },
    );

    // More complex "comet" particle effect
    final ParticleField cometParticles = ParticleField(
      spriteSheet: sparkleSpriteSheet,
      blendMode: BlendMode.dstIn,
      origin: Alignment.topCenter,
      // Different onTick handler for comets
      onTick: (controller, elapsed, size) {
        List<Particle> particles = controller.particles;
        // Add 10 particles each tick
        for (int i = 10; i > 0; i--) {
          particles.add(Particle(
            color: HSLColor.fromAHSL(1, rnd(180, 290), 1, 0.5).toColor(),
            x: rnd(size.width / 2) * rnd.getSign(),
            y: rnd(-10, size.height),
            vx: rnd(-2, 2),
            vy: rnd(-1, 1),
            frame: rnd.getInt(0, 10000),
            rotation: rnd(pi),
            lifespan: rnd(30, 80),
          ));
        }
        for (int i = particles.length - 1; i >= 0; i--) {
          Particle particle = particles[i];
          double ratio = particle.age / particle.lifespan;
          // Update particle properties based on age
          particle.update(
            vy: particle.vy + 0.15,
            x: particle.x * sqrt(1 - ratio * 0.15) + particle.vx,
            scale: sqrt((1 - ratio) * 4),
            frame: particle.frame + 1,
          );
          // Remove particle if it exceeds its lifespan
          if (particle.age > particle.lifespan) particles.removeAt(i);
        }
      },
    );

    // Scaffold with a colored background and stacked particle fields
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
          height: 1,
          shadows: [Shadow(blurRadius: 8, color: Colors.green)],
        ),
        child: ColoredBox(
          color: const Color(0xFF110018),
          child: starField.stackBelow(
            child: Align(
              alignment: const Alignment(0, -0.67),
              child: cometParticles.stackBelow(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                scale: 1.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
