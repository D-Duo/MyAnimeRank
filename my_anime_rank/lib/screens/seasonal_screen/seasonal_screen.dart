import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';
import 'package:my_anime_rank/widgets/previewItem_gridDisplay.dart';

Future<List<PreviewItem>> loadItems() async {
  List<Future<PreviewItem>> itemsFutures = [
    
    loadPreviewItemRemoteMedia(21), //one piece
    loadPreviewItemRemoteMedia(101922), //Kimetsu
    loadPreviewItemRemoteMedia(166873), //Mushoku season 2
    loadPreviewItemRemoteMedia(99423), //darling in the franxx
    loadPreviewItemRemoteMedia(16498), //shingeki
    loadPreviewItemRemoteMedia(154587), //frieren
    loadPreviewItemRemoteMedia(1535), //death note
    loadPreviewItemRemoteMedia(140960), //spy x fam
    loadPreviewItemRemoteMedia(11757), //sword art
    loadPreviewItemRemoteMedia(21087), //one punch
    loadPreviewItemRemoteMedia(127230), //chainsaw
    loadPreviewItemRemoteMedia(20657), //saenai heroine
  ];

  List<PreviewItem> items = await Future.wait(itemsFutures);

  return items;
}

class SeasonalScreen extends StatefulWidget {
  const SeasonalScreen({super.key});

  @override
  State<SeasonalScreen> createState() => _SeasonalScreenState();
}

class _SeasonalScreenState extends State<SeasonalScreen> {
  late Future<List<PreviewItem>> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _charactersFuture = loadItems();
  }

  Future<void> _reloadData() async {
    setState(() {
      _charactersFuture = loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;
    //final itemsPerRow = (screenSize.width / 150).floor();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 42, 59),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 28, 39),
        title: const Text(
          "Pick your waifu:",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: const Color.fromARGB(
            255, 29, 42, 59), // Set the color of the BottomAppBar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => Navigator.of(context).pushNamed("/profileDemo"),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => Navigator.of(context).pushNamed("/"),
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today_rounded),
              onPressed: () {
                // Handle favorite button press
              },
            ),
            IconButton(
              icon: const Icon(Icons.format_list_bulleted_rounded),
              onPressed: () => Navigator.of(context).pushNamed("/"),              
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _charactersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh_sharp),
                    onPressed: _reloadData,
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No data available'),
            );
          }
          final previewItems = snapshot.data!;
          return GridView.builder(
            itemCount: previewItems.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisExtent: 400,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (previewItems[index].type == 0) {
                    Navigator.of(context).pushNamed(
                      "/characterDemo",
                      arguments: previewItems[index].apiId,
                    );
                  } else {
                    Navigator.of(context).pushNamed(
                      "/animeDemo",
                      arguments: previewItems[index].apiId,
                    );
                  }
                },
                child: PreviewItemGridDisplay(
                  item: previewItems[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
