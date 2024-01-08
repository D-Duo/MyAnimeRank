import 'package:flutter/material.dart';
import 'package:my_anime_rank/widgets/screens_navigation_bar.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:my_anime_rank/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_anime_rank/screens/home_screen/widgets/base_home_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;
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
        bottomNavigationBar: const ScreensNavigationBar(
          screen: "/",
          screenId: 2,
        ),
        body: Stack(
          children: [
            const BaseHomeDisplay(),
            Container(
              height: 50,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 19, 28, 39)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 52, 72, 95), // fontcolor of hint
                          fontSize: 14.0, // fontsize of hint
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              String temp = searchController.text;
                              searchController.text = "";
                              Navigator.of(context).pushNamed("/searchDemo", arguments: temp);
                            });
                          },
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white, // text color inside textfield
                        fontSize: 18.0, // fontsize inside textfield
                      ),
                      cursorColor: Colors.blue, // cursor color
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
