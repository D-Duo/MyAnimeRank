import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/anime.dart';

class CharStaffHorizontalDisplay extends StatelessWidget {
  const CharStaffHorizontalDisplay({
    super.key,
    required this.charItem,
  });

  final List<CharacterItem> charItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (CharacterItem char in charItem)
            CharStaffItem(
              charItem: char,
            ),
        ],
      ),
    );
  }
}

class CharStaffItem extends StatelessWidget {
  const CharStaffItem({
    super.key,
    required this.charItem,
  });

  final CharacterItem charItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed("/characterDemo", arguments: charItem.Cid),
      child: Container(
        width: 150,
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(charItem.CimagePath),
                  fit: BoxFit.cover,
                ),
              ),
              margin: const EdgeInsets.all(8.0),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 54, 85, 131),
                ),
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Center(
                  child: Text(
                    charItem.Cname,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 174, 184, 197),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
