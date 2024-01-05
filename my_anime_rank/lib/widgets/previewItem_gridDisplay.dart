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
    return Column(
      children: [
        Container(
          height: 300,
          child: Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image(
                image: NetworkImage(item.itemImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.mainString,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),                  
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.secondaryString ?? "",
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
