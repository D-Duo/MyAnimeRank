import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';
import 'package:my_anime_rank/widgets/previewItem_gridDisplay.dart';

class PreviewItemSideScrollDisplay extends StatelessWidget {
  const PreviewItemSideScrollDisplay({
    super.key,
    required this.previewItems,
  });

  final List<PreviewItem> previewItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              for (PreviewItem item in previewItems)
                GestureDetector(
                  onTap: () {
                    if (item.type == 0) {
                      Navigator.of(context).pushNamed(
                        "/characterDemo",
                        arguments: item.apiId,
                      );
                    } else {
                      Navigator.of(context).pushNamed(
                        "/animeDemo",
                        arguments: item.apiId,
                      );
                    }
                  },
                  child: SizedBox(
                    width: 250,
                    child: PreviewItemGridDisplay(
                      item: item,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}