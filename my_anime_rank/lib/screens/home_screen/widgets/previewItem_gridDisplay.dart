import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';

class PreviewItemGridDisplay extends StatelessWidget {
  const PreviewItemGridDisplay({
    super.key,
    required this.item,
  });

  final PreviewItem item;

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
                item.mainString,
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
            image: NetworkImage(item.itemImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}