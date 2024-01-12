import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vitality/vitality.dart';

Future<ui.Image?> loadImage(String assetPath) async {
  try {
    ByteData data = await rootBundle.load(assetPath);
    List<int> bytes = data.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(Uint8List.fromList(bytes));
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  } catch (e) {
    print('Error loading image: $e');
    // Return a placeholder image or handle the error as needed
    return null;
  }
}

class Screen10 extends StatelessWidget {
  const Screen10({super.key});

  List<Shape> getClouds(Size size) {
    return ShapesGenerator.randomly(
      maxWidth: size.width,
      maxHeight: size.height / 3,
      enableYMovements: false,
      maxSize: 60,
      minSize: 50,
      maxOpacity: 0.9,
      minOpacity: 0.5,
      whenOutOfScreenMode: WhenOutOfScreenMode.Reflect,
      behaviours: [ItemBehaviour(shape: ShapeType.Icon, icon: Icons.star)],
      colors: const [Colors.white],
    ).getShapes(10);
  }

  List<Shape> getGroundShapes(Size size) {
    return ShapesGenerator.randomly(
      minHeight: size.height - 130,
      maxWidth: size.width,
      maxHeight: size.height,
      enableYMovements: false,
      maxSize: 190,
      minSize: 90,
      maxOpacity: 1,
      minOpacity: 0.5,
      whenOutOfScreenMode: WhenOutOfScreenMode.none,
      behaviours: [
        ItemBehaviour(shape: ShapeType.Icon, icon: Icons.circle),
      ],
      colors: const [Colors.brown],
      maxSpeed: 0,
      minSpeed: 0,
    ).getShapes(40);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<ui.Image?>(
      future: loadImage('assets/images/moon.png'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Error loading image'));
          }
          return Vitality.custom(
            background: Colors.black,
            shapes: [
              Shape(
                pos: const Offset(30, 30),
                dx: 0.3,
                dy: 0,
                size: 160,
                color: Colors.yellow,
                whenOutOfScreenMode: WhenOutOfScreenMode.Reflect,
                behaviour: ItemBehaviour(
                  shape: ShapeType.Image,
                  image: snapshot.data!,
                ),
              ),
              ...getClouds(size),
              ...getGroundShapes(size),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
