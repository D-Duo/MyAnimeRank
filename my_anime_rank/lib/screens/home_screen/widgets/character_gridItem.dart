import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/character.dart';

class CharacterGridItem extends StatelessWidget {
  const CharacterGridItem({
    super.key,
    required this.character,
  });

  final Character character;

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
                character.name,
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
            image: AssetImage(character.mainImagePaths.first),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}