import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:my_anime_rank/providers/profile_provider.dart';
import 'package:my_anime_rank/screens/profile_screen/widgets/edit%20secondaryinfo.dart';
import 'package:my_anime_rank/screens/profile_screen/widgets/edit_idinfo.dart';
import 'package:my_anime_rank/screens/profile_screen/widgets/edit_maininfo.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Profile profile = Provider.of<ProfileProvider>(context).profile;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 28, 39),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        shadowColor: const Color.fromARGB(0, 0, 0, 0),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/profileDemo");
          },
          child: const Icon(Icons.keyboard_arrow_left,
              size: 40, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              //TODO: update profile to json
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Save",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.09),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //EDIT MAIN INFO PROFILE
              EditMainInfo(profile: profile),
              //DEDORATION
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 30),
                height: 10,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: MediaQuery.of(context).size.width * 0.06,
                    colors: const [
                      Color.fromARGB(255, 54, 85, 131),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              //EDIT MAIN INFO PROFILE
              EditSecondaryInfo(profile: profile),
              //DEDORATION
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 30),
                height: 10,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: MediaQuery.of(context).size.width * 0.06,
                    colors: const [
                      Color.fromARGB(255, 54, 85, 131),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              //EDIT MAIN INFO PROFILE
              EditIdInfo(profile: profile),
            ],
          ),
        ),
      ),
    );
  }
}
