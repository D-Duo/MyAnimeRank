import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';
import 'package:my_anime_rank/widgets/screens_navigation_bar.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:my_anime_rank/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/base_home_display.dart';

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
    final screenSize = MediaQuery.of(context).size;
    //final itemsPerRow = (screenSize.width / 150).floor();
    Profile? profile = Provider.of<ProfileProvider>(context).profile;

    if (profile != null) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 29, 42, 59),
        appBar: AppBar(
          scrolledUnderElevation: 0,
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
        ),
        bottomNavigationBar: const ScreensNavigationBar(screen: "/"),
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
            return Stack(
              children: [
                BaseHomeDisplay(previewItems: previewItems),
              ],
            );
          },
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
