import 'package:bubble_lens/bubble_lens.dart';
import 'package:flutter/material.dart';
import 'package:nightlight/Customizeanimations/BubbleWidget.dart';

class Screen1 extends StatefulWidget {
  final String animationscreen;
  const Screen1(this.animationscreen, {super.key});

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> with SingleTickerProviderStateMixin {
  Color backgroundSelectedColor = Colors.black;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * 3.1416, // Full rotation
                child: BubbleLens(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  widgets: [
                    for (var i = 0; i < 100; i++)
                      // ignore: prefer_const_constructors
                      BubbleWidget(
                        radius: 50,
                        color: Colors.red,
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
