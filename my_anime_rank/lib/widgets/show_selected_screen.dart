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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.0, 0.70],
          tileMode: TileMode.clamp,
          colors: getSelectedColor(isSelected),
        ),
      ),
      child: child,
    );
  }
}

List<Color> getSelectedColor(bool isSel) {
  if (isSel) {
    return [
      Colors.white,
      Colors.transparent,
    ];
  } else {
    return [
      Colors.transparent,
      Colors.transparent,
    ];
  }
}
