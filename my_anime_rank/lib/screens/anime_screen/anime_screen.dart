import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/anime.dart';
import 'package:my_anime_rank/screens/anime_screen/widgets/anime_appbar.dart';
import 'package:my_anime_rank/screens/anime_screen/widgets/anime_display.dart';
import 'dart:ui';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({super.key});

  @override
  AnimeScreenState createState() => AnimeScreenState();
}

class AnimeScreenState extends State<AnimeScreen> {
  int mainImageIndex = 0;

  late Future<Anime> _animeFuture;
  bool _initialized = false;

  Future<void> _reloadData(int animeId) async {
    setState(() {
      _animeFuture = loadAnimeRemote(animeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final int charId = ModalRoute.of(context)!.settings.arguments as int;
    if (!_initialized) {
      _animeFuture = loadAnimeRemote(charId);
      _initialized = true;
    }

    // Main screen scafold
    return Scaffold(
      // Container for the background image
      body: FutureBuilder(
        future: _animeFuture,
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
          final anime = snapshot.data!;
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(anime.mainImagePaths[mainImageIndex]),
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
                      image: NetworkImage(anime.mainImagePaths[mainImageIndex]),
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
                          AnimeDisplay(anime: anime),
                        ],
                      ),
                      // Appbar of the screen
                      const AnimeAppBar(),
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
