import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/character.dart';
import 'package:my_anime_rank/screens/character_screen/widgets/character_display.dart';
import 'package:my_anime_rank/screens/character_screen/widgets/custom_appbar.dart';
import 'dart:ui';

import '/data/profiles.json';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int mainImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;

    // Main screen scafold
    return Scaffold(
      // Container for the background image
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(character.mainImagePaths[mainImageIndex]),
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
                  image: NetworkImage(character.mainImagePaths[mainImageIndex]),
                  fit: BoxFit.fitHeight,
                ),
              ),
              // Main ListView of the screen
              child: Stack(
                children: [
                  ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      //Container to limit the view of the background
                      SizedBox(
                        height: screenSize.height <= 210
                            ? screenSize.height
                            : screenSize.height - 210,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SwapImagesButtons(character),
                        ),
                      ),
                      //
                      CharacterDisplay(character: character),
                    ],
                  ),
                  // Appbar of the screen
                  const CustomAppBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row SwapImagesButtons(Character character) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            if ((mainImageIndex - 1) >= 0) {
              setState(() {
                mainImageIndex--;
              });
            } else {
              setState(() {
                mainImageIndex = character.mainImagePaths.length - 1;
              });
            }
          },
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            if ((mainImageIndex + 1) < character.mainImagePaths.length) {
              setState(() {
                mainImageIndex++;
              });
            } else {
              setState(() {
                mainImageIndex = 0;
              });
            }
          },
        ),
      ],
    );
  }
}
