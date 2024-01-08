import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfileProvider extends ChangeNotifier {
  Profile? _profile;

  Profile? get profile => _profile;

  ProfileProvider() {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    _profile = await loadProfile();
    notifyListeners();
  }

//update nickname
  void updateNickname(String newData) {
    _profile!.nickname = newData;
    notifyListeners();
    UpdateJson();
  }

  void updateProfile(Profile newData) {
    _profile = newData;
    notifyListeners();
    UpdateJson();
  }

  Future<void> UpdateJson() async {
    if (_profile != null) {
      // Crear un mapa que representa el perfil
      final profileMap = {
        'nickname': _profile!.nickname,
        'profileImage': _profile!.profileImage,
        'mail': _profile!.mail,
        'password': _profile!.password,
        'birthday': {
          'day': _profile!.birthday.day,
          'month': _profile!.birthday.month,
          'year': _profile!.birthday.year,
        },
        'gender': _profile!.gender.value,
        'location': {
          'country': _profile!.location.country,
          'city': _profile!.location.city,
        },
        'animeRankList': _profile!.animeRankList
            ?.map((entry) => {
                  'id': entry.id,
                  'rank': entry.rank,
                })
            .toList(),
        'characterRankList': _profile!.characterRankList
            ?.map((entry) => {
                  'id': entry.id,
                  'rank': entry.rank,
                })
            .toList(),
      };

      // Convertir el mapa a JSON
      final jsonString = json.encode(profileMap);

      // Obtener la ruta del archivo profile.json
      final appDir = await getApplicationDocumentsDirectory();
      final directoryPath = join(
        appDir.path,
        'My Anime Rank',
        'LocalData',
      );

      // Create the directory if it doesn't exist
      await Directory(directoryPath).create(recursive: true);
      final filePath = join(directoryPath, 'profile.json');
      final file = File(filePath);

      // Escribir el JSON en el archivo

      await file.writeAsString(jsonString);
    }
  }
}
