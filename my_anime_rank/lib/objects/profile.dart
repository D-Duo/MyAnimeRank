import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class RankListItem {
  int id;
  int rank;

  RankListItem({
    required this.id,
    required this.rank,
  });
}

enum ProfileGender {
  unspecified,
  male,
  female,
  other,
}

extension ProfileGenderExtension on ProfileGender {
  int get value {
    switch (this) {
      case ProfileGender.unspecified:
        return 0;
      case ProfileGender.male:
        return 1;
      case ProfileGender.female:
        return 2;
      case ProfileGender.other:
        return 3;
    }
  }
}

String genderToString(ProfileGender gender) {
  switch (gender) {
    case ProfileGender.unspecified:
      return "Unspecified";
    case ProfileGender.male:
      return "Male";
    case ProfileGender.female:
      return "Female";
    case ProfileGender.other:
      return "Other";
    default:
      return "Unspecified";
  }
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

String monthToString(int month) {
  switch (month) {
    case 0:
      return "January";
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "Jane";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "Octover";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "January";
  }
}

int daysAmountPerMonth(ProfileDate date) {
  switch (date.month) {
    case 0:
      return 31;
    case 1:
      return 31;
    case 2: //removed 29 cz caused problem when changing years
      return 28;
    case 3:
      return 31;
    case 4:
      return 30;
    case 5:
      return 31;
    case 6:
      return 30;
    case 7:
      return 31;
    case 8:
      return 31;
    case 9:
      return 30;
    case 10:
      return 31;
    case 11:
      return 30;
    case 12:
      return 31;
    default:
      return 31;
  }
}

Future<String> pickImage() async {
  File? _imageFile;
  String? _imageUrl;

  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    _imageFile = File(pickedFile.path);

    try {
      // using Luis' api key of imgbb
      final uploadUrl = Uri.parse(
          'https://api.imgbb.com/1/upload?key=9d165bba10377e651c1398519ed5d0c0');

      // create request
      var request = http.MultipartRequest('POST', uploadUrl);

      // Adjuntar la imagen al cuerpo de la solicitud
      request.files
          .add(await http.MultipartFile.fromPath('image', _imageFile!.path));

      // Enviar la solicitud a Imgbb
      var response = await request.send();

      if (response.statusCode == 200) {
        // Analizar la respuesta JSON
        var responseBody = await response.stream.bytesToString();
        var jsonData = jsonDecode(responseBody);

        // Obtener la URL de la imagen de Imgbb
        _imageUrl = jsonData['data']['url'];

        // Imprimir la URL de la imagen
        if (_imageUrl != null) {
          return _imageUrl;
        }
      } else {
        print(
            'Error al cargar la imagen. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }
  return "";
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
  ProfileGender gender;
  ProfileLocation location;
  List<RankListItem>? animeRankList;
  List<RankListItem>? characterRankList;

  Profile({
    required this.nickname,
    required this.profileImage,
    required this.mail,
    required this.password,
    required this.birthday,
    required this.gender,
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
        gender = ProfileGender.values[json["gender"]],
        location = ProfileLocation(
            country: json["location"]["country"],
            city: json["location"]["city"]),
        animeRankList = (json["animeRanklist"] as List<dynamic>?)
            ?.map<RankListItem>((item) => RankListItem(
                  id: item["id"] as int,
                  rank: item["rank"] as int,
                ))
            .toList(),
        characterRankList = (json["characterRanklist"] as List<dynamic>?)
            ?.map<RankListItem>((item) => RankListItem(
                  id: item["id"] as int,
                  rank: item["rank"] as int,
                ))
            .toList();
}

Future<Profile> loadProfile() async {
  final appDir = await getApplicationDocumentsDirectory();
  final filePath =
          join(appDir.path, 'My Anime Rank', 'LocalData', 'profile.json');
  final file = File(filePath);

  final String jsonString;

  if (await file.exists()) {
    jsonString = await file.readAsString();
  } else {
    jsonString = await rootBundle.loadString('assets/profile.json');    
  }

  final jsonData = jsonDecode(jsonString);

  Profile profile = Profile.fromJson(jsonData);
  return profile;
}
