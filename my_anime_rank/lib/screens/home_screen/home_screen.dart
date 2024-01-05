import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';
import 'package:my_anime_rank/widgets/previewItem_gridDisplay.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:my_anime_rank/providers/profile_provider.dart';
import 'package:provider/provider.dart';

Future<List<PreviewItem>> loadItems() async {
  List<Future<PreviewItem>> itemsFutures = [
    loadPreviewItemRemoteCharacter(124381),
    loadPreviewItemRemoteCharacter(40882),
    loadPreviewItemRemoteCharacter(176754),
    loadPreviewItemRemoteCharacter(80),
    loadPreviewItemRemoteCharacter(40),
    loadPreviewItemRemoteCharacter(16342),
    loadPreviewItemRemoteCharacter(138100),
    loadPreviewItemRemoteCharacter(169679),
    loadPreviewItemRemoteCharacter(138101),
    loadPreviewItemRemoteCharacter(138102),
    loadPreviewItemRemoteCharacter(36765),
    loadPreviewItemRemoteCharacter(36828),
    loadPreviewItemRemoteCharacter(73935),
    loadPreviewItemRemoteCharacter(81929),
    loadPreviewItemRemoteCharacter(130102),
    loadPreviewItemRemoteCharacter(137079),
    loadPreviewItemRemoteCharacter(88747),
    loadPreviewItemRemoteCharacter(88748),
    loadPreviewItemRemoteCharacter(88750),
    loadPreviewItemRemoteCharacter(88749),
  ];

  List<PreviewItem> items = await Future.wait(itemsFutures);

  return items;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PreviewItem>> _charactersFuture;
  List<bool> isSelected = [true, false];

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
    Profile profile = Provider.of<ProfileProvider>(context).profile;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 42, 59),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 28, 39),
        centerTitle: true,
        title: const Text(
          "MAR",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed("/profileDemo"),
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(profile.profileImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ToggleButtons(
              onPressed: (int index) {
                setState(
                  () {
                    isSelected[index] = true;

                    if (index == 0) {
                      isSelected[1] = !isSelected[0];
                    } else {
                      isSelected[0] = !isSelected[1];
                    }
                  },
                );
              },
              fillColor: Color.fromARGB(255, 54, 85, 131),
              isSelected: isSelected,
              children: const [
                Text(
                  "A",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "C",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
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
              onPressed: () {
                // Handle favorite button press
              },
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
