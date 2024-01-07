import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';
import 'package:my_anime_rank/screens/seasonal_screen/widgets/seasonal_filter.dart';
import 'package:my_anime_rank/widgets/previewItem_gridDisplay.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:my_anime_rank/providers/profile_provider.dart';
import 'package:my_anime_rank/widgets/screens_navigation_bar.dart';
import 'package:provider/provider.dart';

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
  List<bool> isSelected = [true, false];

  String selectedMonth = getCurrentSeason();
  String selectedYear = DateTime.now().year.toString();

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

  void onMonthValueChanged(String value) {
    setState(() {
      selectedMonth = value;
      print('Selected Month: $selectedMonth');
    });
  }

  void onYearValueChanged(String value) {
    setState(() {
      selectedYear = value;
      print('Selected Month: $selectedYear');
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    //final itemsPerRow = (screenSize.width / 150).floor();
    Profile? profile = Provider.of<ProfileProvider>(context).profile;

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
                  image: NetworkImage(profile!.profileImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const ScreensNavigationBar(screen: "/seasonalDemo"),
      body: Stack(
        children: [
          FutureBuilder(
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
          Container(
            height: 50,
            decoration: const BoxDecoration(color: Color.fromARGB(255, 19, 28, 39)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: SeasonalFilterItem(
                    filter: 0, //Season
                    onValueChanged: onMonthValueChanged,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SeasonalFilterItem(
                    filter: 1, //Year
                    onValueChanged: onYearValueChanged,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
