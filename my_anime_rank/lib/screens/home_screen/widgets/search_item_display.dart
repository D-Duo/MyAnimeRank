import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';

class SearchItemDisplay extends StatelessWidget {
  const SearchItemDisplay(
      {super.key,
      required this.previewItem});

  final PreviewItem previewItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 120,
          width: 120 * (3 / 4),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(previewItem.itemImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                previewItem.mainString,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                previewItem.secondaryString ?? "",
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 10,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}