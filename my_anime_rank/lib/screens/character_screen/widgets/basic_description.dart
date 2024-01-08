import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/character.dart';
import 'package:my_anime_rank/widgets/custom_expandable.dart';

class BasicDescription extends StatelessWidget {
  const BasicDescription({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Alias display
          Text(
            character.bestAlias ?? '',
            style: const TextStyle(
              color: Color.fromARGB(255, 252, 255, 85),
            ),
          ),
          // Name display
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              character.name,
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
                  "RANK: ${character.rank}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "FAVOURITES: ${character.favs}",
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
            height: 40,
          ),
          // Expandable text
          CustomExpandable(
            shortText: character.descriptionShort!,
            longText: character.descriptionLong,
            triggerTextMore: "Show spoilers...",
            triggerTextLess: "Hide spoilers...",
          ),
        ],
      ),
    );
  }
}
