import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/character.dart';
import 'package:my_anime_rank/screens/character_screen/widgets/character_display.dart';
import 'package:my_anime_rank/screens/character_screen/widgets/custom_appbar.dart';
import 'dart:ui';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  int mainImageIndex = 0;

  late Future<Character> _characterFuture;
  bool _initialized = false;

  Future<void> _reloadData(int charId) async {
    setState(() {
      _characterFuture = loadCharacterRemote(charId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final int charId = ModalRoute.of(context)!.settings.arguments as int;
    if (!_initialized) {
      _characterFuture = loadCharacterRemote(charId);
      _initialized = true;
    }

    // Main screen scafold
    return Scaffold(
      // Container for the background image
      body: FutureBuilder(
        future: _characterFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh_sharp),
                    onPressed: () => _reloadData(charId),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No data available'),
            );
          }
          final character = snapshot.data!;
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(character.mainImagePaths[mainImageIndex]),
                fit: BoxFit.cover,
              ),
            ),
            // Blurr effect
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.transparent,
                // Container for the second image
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          character.mainImagePaths[mainImageIndex]),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  // Main ListView of the screen
                  child: Stack(
                    children: [
                      ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          //Container to limit the view of the background
                          SizedBox(
                            height: screenSize.height <= 210
                                ? screenSize.height
                                : screenSize.height - 210,
                          ),
                          //
                          CharacterDisplay(character: character),
                        ],
                      ),
                      // Appbar of the screen
                      const CustomAppBar(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
