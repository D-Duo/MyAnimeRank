import 'package:flutter/material.dart';

//Future<List<Character>> characters = loadCharactersLocal();

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;
    //final itemsPerRow = (screenSize.width / 150).floor();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 42, 59),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: Color.fromARGB(255, 29, 42, 59), // Set the color of the BottomAppBar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () => Navigator.of(context)
                    .pushNamed("/"),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Handle favorite button press
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_today_rounded),
              onPressed: () => Navigator.of(context)
                    .pushNamed("/"),
            ),
            IconButton(
              icon: Icon(Icons.format_list_bulleted_rounded),
              onPressed: () => Navigator.of(context)
                    .pushNamed("/"),
            ),
          ],
        ),
      ),
    );
  }
}