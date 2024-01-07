import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:my_anime_rank/providers/profile_provider.dart';
import 'package:my_anime_rank/widgets/screens_navigation_bar.dart';
import 'package:my_anime_rank/rank_screen/widgets/rank_list_item.dart';
import 'package:provider/provider.dart';

Future<List<PreviewItem>> loadItems() async {
  List<Future<PreviewItem>> itemsFutures = [
    loadPreviewItemRemoteMedia(21), //one piece
    loadPreviewItemRemoteMedia(101922), //Kimetsu
    loadPreviewItemRemoteMedia(166873), //Mushoku season 2
    loadPreviewItemRemoteMedia(99423), //darling in the franxx
    // loadPreviewItemRemoteCharacter(124381),
    // loadPreviewItemRemoteCharacter(40882),
    // loadPreviewItemRemoteCharacter(176754),
    // loadPreviewItemRemoteCharacter(80),
    // loadPreviewItemRemoteCharacter(40),
    // loadPreviewItemRemoteCharacter(16342),
    // loadPreviewItemRemoteCharacter(138100),
    // loadPreviewItemRemoteCharacter(169679),
    // loadPreviewItemRemoteCharacter(138101),
    // loadPreviewItemRemoteCharacter(138102),
    // loadPreviewItemRemoteCharacter(36765),
    // loadPreviewItemRemoteCharacter(36828),
    // loadPreviewItemRemoteCharacter(73935),
    // loadPreviewItemRemoteCharacter(81929),
    // loadPreviewItemRemoteCharacter(130102),
    // loadPreviewItemRemoteCharacter(137079),
    // loadPreviewItemRemoteCharacter(88747),
    // loadPreviewItemRemoteCharacter(88748),
    // loadPreviewItemRemoteCharacter(88750),
    // loadPreviewItemRemoteCharacter(88749),
  ];

  List<PreviewItem> items = await Future.wait(itemsFutures);

  return items;
}

class RanksScreen extends StatefulWidget {
  const RanksScreen({super.key});

  @override
  State<RanksScreen> createState() => _RanksScreenState();
}

class _RanksScreenState extends State<RanksScreen> {
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
    final screenSize = MediaQuery.of(context).size;
    //final itemsPerRow = (screenSize.width / 150).floor();
    Profile? profile = Provider.of<ProfileProvider>(context).profile;

    if (profile != null) {
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
            padding: const EdgeInsets.only(left: 20.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed("/profileDemo"),
              child: Container(
                height: 15,
                width: 15,
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
        bottomNavigationBar:
            const ScreensNavigationBar(screen: "/rankListsDemo"),
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
                    SizedBox(
                      width: (screenSize.width * (2 / 3)),
                      child: Text('Error: ${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 100,
                      child: const Image(
                          image: NetworkImage(
                              "https://i.redd.it/pzjkyzkqhza11.png")),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.refresh_sharp, color: Colors.white),
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
            return ListView.separated(
              itemCount: previewItems.length,
              itemBuilder: (BuildContext context, int index) {
                return RankListsItemDisplay(
                    previewItems: previewItems[index], index: index);
              },
              separatorBuilder: (BuildContext context, int index) => Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: screenSize.width,
                    colors: const [
                      Color.fromARGB(255, 54, 85, 131),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
