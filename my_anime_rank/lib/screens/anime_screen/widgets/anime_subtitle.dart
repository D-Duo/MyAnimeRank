import 'package:flutter/material.dart';

class SubtitleItem extends StatelessWidget {
  const SubtitleItem({super.key, required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 22,
        width: 300,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 6,
            colors: [
              Color(0xFF365583), // #365583
              Color(0xFF1D2A3B), // #1D2A3B
            ],
          ),
        ),
        child: Center(
          child: Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
