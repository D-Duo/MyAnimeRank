import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/anime.dart';
import 'package:my_anime_rank/screens/anime_screen/widgets/anime_charStaffItem.dart';
import 'package:my_anime_rank/screens/anime_screen/widgets/anime_general_info.dart';
import 'package:my_anime_rank/screens/anime_screen/widgets/anime_subtitle.dart';
import 'package:my_anime_rank/widgets/custom_expandable.dart';

const double paddingSpace = 20;

class AnimeDescription extends StatelessWidget {
  const AnimeDescription({
    super.key,
    required this.anime,
  });

  final Anime anime;

  SizedBox _space(double h) => SizedBox(height: h);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Alias display
          Text(
            anime.title,
            style: const TextStyle(
              color: Color.fromARGB(255, 252, 255, 85),
            ),
          ),
          // Name display
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              anime.title,
              style: const TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Like & Rank display
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 54, 85, 131),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "RANK: ${anime.rank}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "FAVOURITES: ${anime.favs}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(160, 60, 94, 143),
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10), bottom: Radius.zero)),
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "${anime.format}, ${anime.startDateYear}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      anime.status,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 0, 204, 174),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "${anime.episodes} eps / 24 min",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(130, 136, 162, 200),
              borderRadius: BorderRadius.vertical(
                  top: Radius.zero, bottom: Radius.circular(10)),
            ),
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < anime.genres.length; i++)
                    Text(
                      anime.genres[i],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 85),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Expandable text
          CustomExpandable(
            shortText: anime.description,
            longText: anime.description,
            triggerTextMore: "Show spoilers...",
            triggerTextLess: "Hide spoilers...",
          ),
          _space(paddingSpace),
          const SubtitleItem(
            subtitle: "General Information",
          ),
          _space(paddingSpace),
          GeneralInformation(
            anime: anime,
          ),
          _space(paddingSpace),
          const SubtitleItem(
            subtitle: "Characters",
          ),
          _space(paddingSpace),
          CharStaffHorizontalDisplay(
            charItem: anime.characters!,
          ),
        ],
      ),
    );
  }
}
