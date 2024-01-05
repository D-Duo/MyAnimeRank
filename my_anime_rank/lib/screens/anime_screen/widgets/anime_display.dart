import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/anime.dart';
import 'package:my_anime_rank/screens/anime_screen/widgets/anime_description.dart';
//import 'package:my_anime_rank/screens/anime_screen/widgets/basic_description.dart';
import 'package:my_anime_rank/widgets/titleItem_widgets.dart';

class AnimeDisplay extends StatelessWidget {
  const AnimeDisplay({
    super.key,
    required this.anime,
  });

  final Anime anime;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    //double scalingFactor = (screenSize.width) * 0.002;
    final double sidesPadding = screenSize.width <= 440
        ? 20
        : 20 + ((screenSize.width - 440) / 60) * 20;
    return Container(
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 29, 42, 59),
              // Top color gradient
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color.fromARGB(255, 29, 42, 59),
                ],
              ),
            ),
          ),
          Positioned(
            top: 200,
            bottom: 00,
            left: 0,
            right: 0,
            child: Container(
              color: const Color.fromARGB(255, 29, 42, 59),
            ),
          ),
          // Main column for the anime details
          Column(
            children: [
              Center(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 100,
                      left: sidesPadding,
                      right: sidesPadding,
                    ),
                    child: AnimeDescription(
                      anime: anime,
                    ),
                  ),
                ),
              ),
              // if (anime.filmography != null)
              //   Column(
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.only(
              //           left: sidesPadding,
              //           right: sidesPadding,
              //         ),
              //         child: const Align(
              //           alignment: Alignment.centerLeft,
              //           child: Text(
              //             "Filmography:",
              //             style: TextStyle(
              //               color: Color.fromARGB(255, 174, 184, 197),
              //               fontSize: 20,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       Align(
              //         alignment: Alignment.centerLeft,
              //         child: TitlesScrollableHorizontalDisplay(
              //             titles: character.filmography!, initialPading: sidesPadding,),
              //       ),
              //     ],
              //   ),
              Container(
                height: 100,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 2,
                      width: 300,
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 80,
                          colors: [
                            Color(0xFF365583), // #365583
                            Color(0xFF1D2A3B), // #1D2A3B
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "MyAnimeRank is a property of D.Duo Co.,Ltd. ©2023 All Rights Reserved.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    const Text(
                      "This site is protected by Me and Myself and I.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 7,
                      ),
                    ),
                  ],
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
