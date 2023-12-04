import 'package:flutter/material.dart';
import 'package:my_anime_rank/screens/home_screen/home_screen.dart';
import 'package:my_anime_rank/screens/character_screen/character_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (_) => const HomeScreen(),
        "/characterDemo": (_) => const CharacterScreen(),
      },
    );
  }
}
