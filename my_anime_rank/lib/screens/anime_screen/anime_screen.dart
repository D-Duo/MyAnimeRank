import 'package:flutter/material.dart';
import 'package:my_anime_rank/data_provider.dart';
import 'package:my_anime_rank/objects/anime.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:my_anime_rank/screens/anime_screen/widgets/anime_appbar.dart';
import 'package:my_anime_rank/screens/anime_screen/widgets/anime_display.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

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
    final int animeID = ModalRoute.of(context)!.settings.arguments as int;
    if (!_initialized) {
      _animeFuture = loadAnimeRemote(animeID);
      _initialized = true;
    }

    Profile? profile = Provider.of<ProfileProvider>(context).profile;

    // Main screen scafold
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 42, 59),
      // Container for the background image
      body: FutureBuilder(
        future: _animeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: (screenSize.width * (2 / 3)),
                        child: Text('Error: ${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 100,
                        child: const Image(
                            image: NetworkImage(
                                "https://i.redd.it/pzjkyzkqhza11.png")),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh_sharp,
                            color: Colors.white),
                        onPressed: () => _reloadData(animeID),
                      ),
                    ],
                  ),
                ),
                // Appbar of the screen
                AnimeAppBar(
                  animeID: animeID,
                  animeRankL: profile?.animeRankList,
                ),
              ],
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
                      AnimeAppBar(
                        animeID: animeID,
                        animeRankL: profile?.animeRankList,
                      ),
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
