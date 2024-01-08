import 'package:flutter/material.dart';
import 'package:my_anime_rank/screens/home_screen/widgets/search_item_display.dart';
import 'package:my_anime_rank/objects/preview_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  late Future<List<PreviewItem>> _searchItemsFuture;
  bool _initialized = false;

  Future<void> _reloadData(String search) async {
    setState(() {
      _searchItemsFuture = loadSearchResults(4, search);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final String searchImput =
        ModalRoute.of(context)!.settings.arguments as String;
    if (!_initialized) {
      _searchItemsFuture = loadSearchResults(4, searchImput);
      _initialized = true;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 42, 59),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 28, 39),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Search results for: $searchImput'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: FutureBuilder(
        future: _searchItemsFuture,
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
                    icon: const Icon(Icons.refresh_sharp, color: Colors.white),
                    onPressed: () => _reloadData(searchImput),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No results"),
            );
          }
          final search_results = snapshot.data!;
          return ListView.separated(
            itemCount: search_results.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Column(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 54, 85, 131),
                      child:  Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          (search_results[index].type == 0) ? "Characters:" : "Animes:",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (search_results[index].type == 0) {
                          Navigator.of(context).pushNamed(
                            "/characterDemo",
                            arguments: search_results[index].apiId,
                          );
                        } else {
                          Navigator.of(context).pushNamed(
                            "/animeDemo",
                            arguments: search_results[index].apiId,
                          );
                        }
                      },
                      child:
                          SearchItemDisplay(previewItem: search_results[index]),
                    ),
                  ],
                );
              } else if ((search_results[index-1].type == 1) &&
                  (index + 1 < search_results.length &&
                      search_results[index].type == 0)) {
                return Column(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 54, 85, 131),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          (search_results[index].type == 0) ? "Characters:" : "Animes:",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (search_results[index].type == 0) {
                          Navigator.of(context).pushNamed(
                            "/characterDemo",
                            arguments: search_results[index].apiId,
                          );
                        } else {
                          Navigator.of(context).pushNamed(
                            "/animeDemo",
                            arguments: search_results[index].apiId,
                          );
                        }
                      },
                      child:
                          SearchItemDisplay(previewItem: search_results[index]),
                    ),
                  ],
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    if (search_results[index].type == 0) {
                      Navigator.of(context).pushNamed(
                        "/characterDemo",
                        arguments: search_results[index].apiId,
                      );
                    } else {
                      Navigator.of(context).pushNamed(
                        "/animeDemo",
                        arguments: search_results[index].apiId,
                      );
                    }
                  },
                  child: SearchItemDisplay(previewItem: search_results[index]),
                );
              }
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
  }
}
