// bottom_navigation_bar.dart

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';

const List<TabItem> items = [
  TabItem(icon: Icons.shape_line),
  TabItem(icon: Icons.format_color_fill_rounded),
  TabItem(icon: Icons.more_time),
  TabItem(icon: Icons.queue_music),
  TabItem(icon: Icons.brightness_6_outlined),
];

class BottomNavigationBarWidget extends StatelessWidget {
  final int visit;
  final Function(int) onTap;

  const BottomNavigationBarWidget({
    super.key,
    required this.visit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0, // Set the height of the navigation bar
      child: BottomBarDivider(
        items: items,
        backgroundColor: Colors.transparent,
        color: const Color(0xFF00FF00),
        colorSelected: Colors.white,
        indexSelected: visit,
        onTap: onTap,
        styleDivider: StyleDivider.top,
        countStyle: const CountStyle(
          background: Colors.white,
        ),
      ),
    );
  }
}
