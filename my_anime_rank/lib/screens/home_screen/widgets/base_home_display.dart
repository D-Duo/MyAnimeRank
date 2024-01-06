import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';
import 'package:my_anime_rank/widgets/previewItem_gridDisplay.dart';

class BaseHomeDisplay extends StatelessWidget {
  const BaseHomeDisplay({
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
                  child: PreviewItemGridDisplay(
                    item: item,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// return GridView.builder(
//               itemCount: previewItems.length,
//               gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 250,
//                 mainAxisExtent: 400,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//               ),
//               padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     if (previewItems[index].type == 0) {
//                       Navigator.of(context).pushNamed(
//                         "/characterDemo",
//                         arguments: previewItems[index].apiId,
//                       );
//                     } else {
//                       Navigator.of(context).pushNamed(
//                         "/animeDemo",
//                         arguments: previewItems[index].apiId,
//                       );
//                     }
//                   },
//                   child: PreviewItemGridDisplay(
//                     item: previewItems[index],
//                   ),
//                 );
//               },
//             );