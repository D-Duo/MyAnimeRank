import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/character.dart';
import 'package:my_anime_rank/screens/home_screen/widgets/character_gridItem.dart';

//Future<List<Character>> characters = loadCharactersLocal();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Character>> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _charactersFuture = loadCharacters();
  }

  Future<void> _reloadData() async {
    setState(() {
      _charactersFuture = loadCharacters();
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
              onPressed: () {
                // Handle favorite button press
              },
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
                    const SizedBox(height: 20,),
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
          final characters = snapshot.data!;
          return GridView.builder(
            itemCount: characters.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2 / 3,
            ),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pushNamed("/characterDemo",
                    arguments: characters[index].apiId),
                child: CharacterGridItem(
                  character: characters[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
