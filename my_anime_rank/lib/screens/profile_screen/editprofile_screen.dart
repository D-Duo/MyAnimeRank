import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:my_anime_rank/providers/profile_provider.dart';
import 'package:my_anime_rank/screens/profile_screen/widgets/edit_secondaryinfo.dart';
import 'package:my_anime_rank/screens/profile_screen/widgets/edit_idinfo.dart';
import 'package:my_anime_rank/screens/profile_screen/widgets/edit_maininfo.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordVerficationController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  String? tempImg;
  ProfileDate? tempDate;
  ProfileGender? tempGender;
  bool init = true;

  @override
  Widget build(BuildContext context) {
    Profile? profile = Provider.of<ProfileProvider>(context).profile;
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: true);
    if (init) {
      tempImg = profile!.profileImage;

      //setting temp variables without pointer
      tempDate = ProfileDate(
          day: profile.birthday.day,
          month: profile.birthday.month,
          year: profile.birthday.year);
      //setting temp variables without pointer
      if (profile.gender == ProfileGender.male) {
        tempGender = ProfileGender.male;
      } else if (profile.gender == ProfileGender.female) {
        tempGender = ProfileGender.female;
      } else if (profile.gender == ProfileGender.other) {
        tempGender = ProfileGender.other;
      } else {
        tempGender = ProfileGender.unspecified;
      }
      init = false;
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 28, 39),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        shadowColor: const Color.fromARGB(0, 0, 0, 0),
        leading: GestureDetector(
          onTap: () {
            if (tempImg != profile!.profileImage) {
              profile.profileImage = tempImg!;
            }
            if (tempDate != profile.birthday) {
              profile.birthday = tempDate!;
            }
            if (tempGender != profile.gender) {
              profile.gender = tempGender!;
            }
            init = true;
            Navigator.of(context).pushNamed("/profileDemo");
          },
          child: const Icon(Icons.keyboard_arrow_left,
              size: 40, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              //save profile changes
              //check if password and password confirmation are the same or empty (if empty password is not being modified)
              if ((passwordController.text ==
                      passwordVerficationController.text) ||
                  (passwordController.text.isEmpty &&
                      passwordVerficationController.text.isEmpty)) {
                Navigator.of(context).pushNamed("/profileDemo");
                profileProvider.updateProfile(
                  Profile(
                      nickname: nicknameController.text.isEmpty
                          ? profile!.nickname
                          : nicknameController.text,
                      profileImage: profile!.profileImage,
                      mail: mailController.text.isEmpty
                          ? profile!.mail
                          : mailController.text,
                      password: passwordController.text.isEmpty
                          ? profile!.password
                          : passwordController.text,
                      birthday: ProfileDate(
                          day: profile!.birthday.day,
                          month: profile!.birthday.month,
                          year: profile!.birthday.year),
                      gender: profile!.gender,
                      location: ProfileLocation(
                          country: countryController.text.isEmpty
                              ? profile!.location.country
                              : countryController.text,
                          city: cityController.text.isEmpty
                              ? profile!.location.city
                              : cityController.text),
                      animeRankList: profile!.animeRankList,
                      characterRankList: profile!.characterRankList),
                );
              }
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
              EditMainInfo(
                profile: profile!,
                nicknameController: nicknameController,
              ),
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
              EditSecondaryInfo(
                profile: profile!,
                cityController: cityController,
                countryController: countryController,
              ),
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
              EditIdInfo(
                profile: profile!,
                mailController: mailController,
                passwordController: passwordController,
                passwordVerficationController: passwordVerficationController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
