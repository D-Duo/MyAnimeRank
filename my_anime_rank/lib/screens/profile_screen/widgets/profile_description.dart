import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/profile.dart';

class ProfileDescription extends StatelessWidget {
  const ProfileDescription({
    super.key,
    required this.profile,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Alias display
          Text(
            profile.favCharacter,
            style: const TextStyle(
              color: Color.fromARGB(255, 252, 255, 85),
            ),
          ),
          // Name display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width <= 380
                    ? MediaQuery.of(context).size.width * (2 / 3)
                    : 280,
                margin: const EdgeInsets.only(bottom: 40),
                child: Text(
                  profile.nickname,
                  style: const TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed("/editProfileDemo"),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 18, 235, 224),
                      shape: BoxShape.circle),
                  child: const Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Icon(Icons.edit, size: 22),
                        ),
                        Icon(Icons.person_outline, size: 40),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              const Icon(Icons.date_range, color: Colors.white, size: 17),
              const SizedBox(width: 10),
              Text(
                "${profile.birthday.day}/${profile.birthday.month}/${profile.birthday.year}",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Icon(Icons.mail, color: Colors.white, size: 17),
              const SizedBox(width: 10),
              Text(
                profile.mail,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              if (profile.gender == ProfileGender.male)
                const Icon(Icons.male, color: Colors.white, size: 27),
              if (profile.gender == ProfileGender.female)
                const Icon(Icons.female, color: Colors.white, size: 27),
              if (profile.gender == ProfileGender.other)
                const Icon(Icons.format_list_bulleted_rounded,
                    color: Colors.white, size: 27),
              if (profile.gender == ProfileGender.unspecified)
                const Icon(Icons.help_outline_rounded,
                    color: Colors.white, size: 27),
              const SizedBox(width: 10),
              Text(
                genderToString(profile.gender),
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
