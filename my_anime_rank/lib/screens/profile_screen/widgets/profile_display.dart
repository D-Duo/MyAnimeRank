import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:my_anime_rank/screens/profile_screen/widgets/profile_description.dart';

class ProfileDisplay extends StatefulWidget {
  const ProfileDisplay({super.key, required this.profile});
  final Profile profile;

  @override
  State<ProfileDisplay> createState() => _ProfileDisplayState();
}

class _ProfileDisplayState extends State<ProfileDisplay> {
  bool anime = true;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    //double scalingFactor = (screenSize.width) * 0.002;
    final double sidesPadding = screenSize.width <= 440
        ? 20
        : 20 + ((screenSize.width - 440) / 60) * 20;
    return Container(
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
