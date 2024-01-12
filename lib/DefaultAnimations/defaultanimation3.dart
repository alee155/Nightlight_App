import 'package:bubble_lens/bubble_lens.dart';
import 'package:flutter/material.dart';

class BubbleLensFour extends StatefulWidget {
  final String animation3;
  const BubbleLensFour(this.animation3, {super.key});

  @override
  _BubbleLensFourState createState() => _BubbleLensFourState();
}

class _BubbleLensFourState extends State<BubbleLensFour>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 50).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.black,
          child: BubbleLens(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            widgets: [
              for (var i = 0; i < 100; i++)
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        _animation.value * (i % 2 == 0 ? 1 : -1),
                      ),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: [Colors.red, Colors.green, Colors.blue][i % 3],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
