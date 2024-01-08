import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:my_anime_rank/rank_screen/widgets/rank_list_item.dart';
import 'package:my_anime_rank/screens/profile_screen/widgets/profile_description.dart';

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

Future<List<PreviewItem>> loadCharacters() async {
  List<Future<PreviewItem>> itemsFutures = [
    // loadPreviewItemRemoteMedia(21), //one piece
    // loadPreviewItemRemoteMedia(101922), //Kimetsu
    // loadPreviewItemRemoteMedia(166873), //Mushoku season 2
    // loadPreviewItemRemoteMedia(99423), //darling in the franxx
    loadPreviewItemRemoteCharacter(124381),
    loadPreviewItemRemoteCharacter(40882),
    loadPreviewItemRemoteCharacter(176754),
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

class ProfileDisplay extends StatefulWidget {
  const ProfileDisplay({super.key, required this.profile});
  final Profile profile;

  @override
  State<ProfileDisplay> createState() => _ProfileDisplayState();
}

class _ProfileDisplayState extends State<ProfileDisplay> {
  bool anime = true;
  late Future<List<PreviewItem>> _animesFuture;
  late Future<List<PreviewItem>> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _animesFuture = loadItems();
    _charactersFuture = loadCharacters();
  }

  Future<void> _reloadData() async {
    setState(() {
      _animesFuture = loadItems();
      _charactersFuture = loadCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    //double scalingFactor = (screenSize.width) * 0.002;
    final double sidesPadding = screenSize.width <= 440
        ? 20
        : 20 + ((screenSize.width - 440) / 60) * 20;
    return SizedBox(
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 29, 42, 59),
              // Top color gradient
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color.fromARGB(255, 29, 42, 59),
                ],
              ),
            ),
          ),
          Positioned(
            top: 200,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: const Color.fromARGB(255, 29, 42, 59),
            ),
          ),
          // Main column for the character details
          Column(
            children: [
              Center(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 100,
                      left: sidesPadding,
                      right: sidesPadding,
                    ),
                    child: ProfileDescription(profile: widget.profile),
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        anime = true;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      decoration: BoxDecoration(
                          color: anime
                              ? const Color.fromARGB(255, 54, 85, 131)
                              : Colors.white),
                      child: Center(
                        child: Text(
                          'Anime',
                          style: TextStyle(
                              fontSize: 20,
                              color: !anime
                                  ? const Color.fromARGB(255, 54, 85, 131)
                                  : Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        anime = false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      decoration: BoxDecoration(
                          color: !anime
                              ? const Color.fromARGB(255, 54, 85, 131)
                              : Colors.white),
                      child: Center(
                        child: Text(
                          'Character',
                          style: TextStyle(
                              fontSize: 20,
                              color: anime
                                  ? const Color.fromARGB(255, 54, 85, 131)
                                  : Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              FutureBuilder(
                future: anime ? _animesFuture : _charactersFuture,
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
                            icon: const Icon(Icons.refresh_sharp,
                                color: Colors.white),
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
                  return Column(
                    children: [
                      for (int i = 0;
                          i <
                              (previewItems.length < 5
                                  ? previewItems.length
                                  : 5);
                          i++)
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (previewItems[i].type == 0) {
                                  Navigator.of(context).pushNamed(
                                    "/characterDemo",
                                    arguments: previewItems[i].apiId,
                                  );
                                } else {
                                  Navigator.of(context).pushNamed(
                                    "/animeDemo",
                                    arguments: previewItems[i].apiId,
                                  );
                                }
                              },
                              child: RankListsItemDisplay(
                                previewItems: previewItems[i],
                                index: i,
                                showArrows: false,
                              ),
                            ),
                            if (i <
                                (previewItems.length < 5
                                        ? previewItems.length
                                        : 5) -
                                    1)
                              Container(
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
                              )
                          ],
                        )
                    ],
                  );
                },
              ),
              Container(
                height: 100,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 1,
                      width: 300,
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 400,
                          colors: [
                            Color.fromARGB(255, 54, 85, 131),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "MyAnimeRank is a property of D.Duo Co.,Ltd. ©2023 All Rights Reserved.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    const Text(
                      "This site is protected by Me and Myself and I.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 7,
                      ),
                    ),
                  ],
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
