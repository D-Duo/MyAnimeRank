import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class RankListItem {
  int id;
  int rank;

  RankListItem({
    required this.id,
    required this.rank,
  });
}

class ProfileDate {
  int day;
  int month;
  int year;

  ProfileDate({
    required this.day,
    required this.month,
    required this.year,
  });
}

class ProfileLocation {
  String country;
  String city;

  ProfileLocation({
    required this.country,
    required this.city,
  });
}

class Profile {
  String nickname;
  String profileImage;
  String mail;
  String password;
  ProfileDate birthday;
  ProfileLocation location;
  List<RankListItem>? animeRankList;
  List<RankListItem>? characterRankList;

  Profile({
    required this.nickname,
    required this.profileImage,
    required this.mail,
    required this.password,
    required this.birthday,
    required this.location,
    required this.animeRankList,
    required this.characterRankList,
  });

  Profile.fromJson(Map<String, dynamic> json)
      : nickname = json["nickname"],
        profileImage = json["profileImage"],
        mail = json["mail"],
        password = json["password"],
        birthday = ProfileDate(
            day: json["birthday"]["day"],
            month: json["birthday"]["month"],
            year: json["birthday"]["year"]),
        location = ProfileLocation(
            country: json["location"]["country"],
            city: json["location"]["city"]),
        animeRankList = (json["filmography"] as List<dynamic>?)
            ?.map<RankListItem>((item) => RankListItem(
                  id: item["title"] as int,
                  rank: item["imagePath"] as int,
                ))
            .toList(),
        characterRankList = (json["filmography"] as List<dynamic>?)
            ?.map<RankListItem>((item) => RankListItem(
                  id: item["title"] as int,
                  rank: item["imagePath"] as int,
                ))
            .toList();
}

Future<Profile> loadProfile() async {
  final jsonString = await rootBundle.loadString('assets/profile.json');
  final jsonData = jsonDecode(jsonString);

  Profile profile = Profile.fromJson(jsonData);
  return profile;
}
