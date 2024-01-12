import 'package:bubble_lens/bubble_lens.dart';
import 'package:flutter/material.dart';

class BallAnimation5 extends StatefulWidget {
  final List<Color> selectedColors;

  const BallAnimation5({Key? key, List<Color>? selectedColors})
      : selectedColors =
            selectedColors ?? const [Colors.pink, Colors.white, Colors.yellow],
        super(key: key);

  @override
  _BallAnimation5State createState() => _BallAnimation5State();
}

class _BallAnimation5State extends State<BallAnimation5>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Adjust the duration as needed
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              color: Colors.black,
              child: BubbleLens(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                widgets: [
                  for (var i = 0; i < 100; i++)
                    Transform.translate(
                      offset: Offset(
                        0,
                        100 * _controller.value,
                      ),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: widget.selectedColors[i % 3],
                      ),
                    ),
                ],
              ),
            );
          },
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
