import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:my_anime_rank/providers/profile_provider.dart';
import 'package:my_anime_rank/screens/profile_screen/widgets/profile_display.dart';
import 'package:my_anime_rank/widgets/screens_navigation_bar.dart';
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
    Profile? profile = Provider.of<ProfileProvider>(context).profile;
    // Main screen scafold
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 42, 59),
      bottomNavigationBar: const ScreensNavigationBar(screen: "/profileDemo"),
      // Container for the background image
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(profile!.profileImage),
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
                    height: screenSize.height <= 260
                        ? screenSize.height
                        : screenSize.height - 260,
                  ),
                  // profile display
                  //to do
                  ProfileDisplay(profile: profile),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
