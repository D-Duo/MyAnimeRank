import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';
import 'package:my_anime_rank/screens/seasonal_screen/widgets/seasonal_filter.dart';
import 'package:my_anime_rank/widgets/previewItem_gridDisplay.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:my_anime_rank/data_provider.dart';
import 'package:my_anime_rank/widgets/screens_navigation_bar.dart';
import 'package:provider/provider.dart';

class SeasonalScreen extends StatefulWidget {
  const SeasonalScreen({super.key});

  @override
  State<SeasonalScreen> createState() => _SeasonalScreenState();
}

class _SeasonalScreenState extends State<SeasonalScreen> {
  late Future<List<PreviewItem>> _charactersFuture;
  List<bool> isSelected = [true, false];

  String selectedMonth = getCurrentSeason();
  int selectedYear = DateTime.now().year.toInt();

  @override
  void initState() {
    super.initState();
    _charactersFuture = loadSeasonalList(4, selectedMonth, selectedYear);
  }

  Future<void> _reloadData() async {
    setState(() {
      _charactersFuture = loadSeasonalList(4, selectedMonth, selectedYear);
    });
  }

  void onMonthValueChanged(int value) {
    setState(() {
      String text;
      switch (value) {
        case 0:
          text = 'WINTER';
          break;
        case 1:
          text = 'SPRING';
          break;
        case 2:
          text = 'SUMMER';
          break;
        case 3:
          text = 'FALL';
          break;
        default:
          text = ''; // Handle unexpected values
      }
      selectedMonth = text;
      _reloadData();
    });
  }

  void onYearValueChanged(int value) {
    setState(() {
      selectedYear = value;
      _reloadData();
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
        title: Image.asset("assets/MyAnimeRank_Logo_emptyBackground.png",
            width: 80),
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
      bottomNavigationBar: const ScreensNavigationBar(
        screen: "/seasonalDemo",
        screenId: 3,
      ),
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
                padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
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
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 19, 28, 39)),
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
