import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/character.dart';
import 'package:my_anime_rank/objects/profileClass.dart';
import 'package:my_anime_rank/providers/profile_provider.dart';
import 'package:my_anime_rank/screens/character_screen/widgets/character_display.dart';
import 'package:my_anime_rank/screens/character_screen/widgets/custom_appbar.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    Profile profile = Provider.of<ProfileProvider>(context).profile;
    // Main screen scafold
    return Scaffold(
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
              onPressed: () => Navigator.of(context).pushNamed("/"),
            ),
            IconButton(
              icon: const Icon(Icons.format_list_bulleted_rounded),
              onPressed: () => Navigator.of(context).pushNamed("/"),
            ),
          ],
        ),
      ),
      // Container for the background image
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(profile.profileImage),
            fit: BoxFit.cover,
          ),
        ),
        // Blurr effect
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.transparent,
            // Container for the second image
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(profile.profileImage),
                  fit: BoxFit.fitHeight,
                ),
              ),
              // Main ListView of the screen
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  //Container to limit the view of the background
                  SizedBox(
                    height: screenSize.height <= 210
                        ? screenSize.height
                        : screenSize.height - 210,
                  ),
                  // profile display
                  //to do
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
