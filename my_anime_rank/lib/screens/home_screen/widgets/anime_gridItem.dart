import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/anime.dart';

class AnimeGridItem extends StatelessWidget {
  const AnimeGridItem({
    super.key,
    required this.anime,
  });

  final Anime anime;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridTile(
        footer: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: const Color.fromARGB(255, 19, 28, 39).withOpacity(0.5),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                anime.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            image: NetworkImage(anime.mainImagePaths.first),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
