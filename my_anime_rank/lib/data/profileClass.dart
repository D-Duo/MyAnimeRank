import 'dart:convert';
import 'dart:io';

class ProfileClass {
  String nickname;
  String profileImage;
  String mail;
  String password;
  ProfileDate birthday;
  ProfileLocation location;
  List<ProfileRankListInfo> animeRankList;
  List<ProfileRankListInfo> characterRankList;

  ProfileClass({
    required this.nickname,
    required this.profileImage,
    required this.mail,
    required this.password,
    required this.birthday,
    required this.location,
    required this.animeRankList,
    required this.characterRankList,
  });

  factory ProfileClass.fromJson(Map<String, dynamic> json) {
    List<ProfileRankListInfo> animeRankList =
        (json['animeRanklist'] as List<dynamic>)
            .map((item) => ProfileRankListInfo.fromJson(item))
            .toList();

    List<ProfileRankListInfo> characterRankList =
        (json['characterRanklist'] as List<dynamic>)
            .map((item) => ProfileRankListInfo.fromJson(item))
            .toList();

    return ProfileClass(
      nickname: json['nickname'],
      profileImage: json['profileImage'],
      mail: json['mail'],
      password: json['password'],
      birthday: ProfileDate.fromJson(json['birthday']),
      location: ProfileLocation.fromJson(json['location']),
      animeRankList: animeRankList,
      characterRankList: characterRankList,
    );
  }

  // Constructor de fábrica para cargar desde un archivo
  static ProfileClass? fromFile(String filePath) {
    String jsonString = File(filePath).readAsStringSync();
    Map<String, dynamic> jsonData = json.decode(jsonString);

    if (jsonData.containsKey('profile')) {
      // Solo hay un perfil en el nuevo JSON
      Map<String, dynamic> profileData = jsonData['profile'];

      return ProfileClass.fromJson(profileData);
    } else {
      // Log de perfil no encontrado
      print('Perfil no encontrado.');
      return null;
    }
  }
}

class ProfileDate {
  int day, month, year;

  ProfileDate({
    required this.day,
    required this.month,
    required this.year,
  });

  factory ProfileDate.fromJson(Map<String, dynamic> json) {
    return ProfileDate(
      day: json['day'],
      month: json['month'],
      year: json['year'],
    );
  }
}

class ProfileLocation {
  String country, city;

  ProfileLocation({
    required this.country,
    required this.city,
  });

  factory ProfileLocation.fromJson(Map<String, dynamic> json) {
    return ProfileLocation(
      country: json['country'],
      city: json['city'],
    );
  }
}

class ProfileRankListInfo {
  int id, rank;

  ProfileRankListInfo({
    required this.id,
    required this.rank,
  });

  factory ProfileRankListInfo.fromJson(Map<String, dynamic> json) {
    return ProfileRankListInfo(
      id: json['id'],
      rank: json['rank'],
    );
  }
}
