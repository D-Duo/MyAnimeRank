import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/profileClass.dart';

class ProfileProvider extends ChangeNotifier {
  late Profile _profile;

  Profile get profile => _profile;

  ProfileProvider() {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    _profile = await loadProfile();
    notifyListeners();
  }

//update nickname
  void updateNickname(String newData) {
    _profile.nickname = newData;
    notifyListeners();
    UpdateJson();
  }
  
  void UpdateJson() {}
}
