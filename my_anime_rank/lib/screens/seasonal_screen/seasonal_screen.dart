import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/anime.dart';
import 'package:my_anime_rank/screens/home_screen/widgets/anime_gridItem.dart';

//Future<List<Character>> characters = loadCharactersLocal();

class SeasonalScreen extends StatefulWidget {
  const SeasonalScreen({super.key});

  @override
  State<SeasonalScreen> createState() => _SeasonalScreenState();
}

class _SeasonalScreenState extends State<SeasonalScreen> {
  late Future<List<Anime>> _animesFuture;

  @override
  void initState() {
    super.initState();
    _animesFuture = loadAnimes();
  }

  Future<void> _reloadData() async {
    setState(() {
      _animesFuture = loadAnimes();
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
          "Seasonal:",
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
              onPressed: () {
                // Handle favorite button press
              },
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
        future: _animesFuture,
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
          final animes = snapshot.data!;
          return GridView.builder(
            itemCount: animes.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2 / 3,
            ),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed("/animeDemo", arguments: animes[index].apiId),
                child: AnimeGridItem(
                  anime: animes[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
