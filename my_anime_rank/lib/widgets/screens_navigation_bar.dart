import 'package:flutter/material.dart';

class ScreensNavigationBar extends StatelessWidget {
  const ScreensNavigationBar({
    super.key,
    required this.screen,
  });

  final String screen;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50,
      color: const Color.fromARGB(
          255, 29, 42, 59), // Set the color of the BottomAppBar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              if (screen != "/profileDemo") {
                Navigator.of(context).pushNamed("/profileDemo");
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (screen != "/") {
                Navigator.of(context).pushNamed("/");
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today_rounded),
            onPressed: () {
              if (screen != "/seasonalDemo") {
                Navigator.of(context).pushNamed("/seasonalDemo");
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.format_list_bulleted_rounded),
            onPressed: () {
              if (screen != "/rankListsDemo") {
                Navigator.of(context).pushNamed("/rankListsDemo");
              }
            },
          ),
        ],
      ),
    );
  }
}
