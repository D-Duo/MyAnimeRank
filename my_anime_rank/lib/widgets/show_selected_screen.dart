import 'package:flutter/material.dart';

class ShowSelectedScreenGradient extends StatelessWidget {
  const ShowSelectedScreenGradient(
      {super.key,
      required this.barHeight,
      required this.isSelected,
      required this.child});

  final double barHeight;
  final bool isSelected;
  final IconButton child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: barHeight,
      color: getSelectedColor(isSelected),
      child: child,
    );
  }
}

Color getSelectedColor(bool isSel) {
  if (isSel) {
    return Color.fromARGB(157, 63, 62, 131);
  } else {
    return Colors.transparent;
  }
}
