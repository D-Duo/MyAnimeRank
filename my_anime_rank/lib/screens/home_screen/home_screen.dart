import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';
import 'package:my_anime_rank/screens/home_screen/widgets/previewItem_gridDisplay.dart';

//Future<List<Character>> characters = loadCharactersLocal();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              onPressed: () => Navigator.of(context).pushNamed("/discoverDemo"),
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today_rounded),
              onPressed: () => Navigator.of(context).pushNamed("/seasonalDemo"),
            ),
            IconButton(
              icon: const Icon(Icons.format_list_bulleted_rounded),
              onPressed: () {
                // Handle favorite button press
              },
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
