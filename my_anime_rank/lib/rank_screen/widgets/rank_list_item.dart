import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';

class RankListsItemDisplay extends StatelessWidget {
  const RankListsItemDisplay(
      {super.key,
      required this.previewItems,
      required this.index,
      this.showArrows = true});

  final PreviewItem previewItems;
  final int index;
  final bool showArrows;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 120,
          width: 80 * (3 / 4),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.transparent,
                Color.fromARGB(150, 204, 0, 119),
              ],
            ),
          ),
          child: Center(
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Container(
          height: 120,
          width: 120 * (3 / 4),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(previewItems.itemImage),
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
                previewItems.mainString,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                previewItems.secondaryString ?? "",
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
        const Spacer(),
        if (showArrows)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_upward_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_downward_rounded),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
