import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/profileClass.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileClass _profile = ProfileClass.fromFile();

  ProfileClass get profile => _profile;

  void UpdateJson() {}

//update nickname
  void updateNickname(String newData) {
    _profile.nickname = newData;
    notifyListeners();
    UpdateJson();
  }
}
