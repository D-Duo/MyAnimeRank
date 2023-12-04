import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class TitleItem {
  final String title;
  final String imagePath;

  TitleItem({
    required this.title,
    required this.imagePath,
  });
}

class Character {
  final String name;
  final String descriptionShort;
  final String? descriptionLong;
  final List<String> mainImagePaths;
  final String? bestAlias;
  final int favs;
  final String rank;
  final List<TitleItem>? filmography;


  Character({
    required this.name,
    required this.descriptionShort,
    this.descriptionLong,
    required this.mainImagePaths,
    this.bestAlias,
    int? favs_,
    int? rank_,
    this.filmography,
  }) : favs = favs_ ?? 0, rank = rank_?.toString() ?? "Unranked";

  Character.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        descriptionShort = json["descriptionShort"],
        descriptionLong = json["descriptionLong"],
        bestAlias = json["bestAlias"],
        favs = json["favs"] ?? 0,
        rank = json["rank"] ?? "Unranked",
        mainImagePaths = (json["mainImagePaths"] as List<dynamic>?)
            ?.map<String>((item) => item["imagePath"] as String)
            .toList() ?? <String>[],
        filmography = (json["filmography"] as List<dynamic>?)
            ?.map<TitleItem>((item) => TitleItem(
                  title: item["title"] as String,
                  imagePath: item["imagePath"] as String,
                ))
            .toList();
}

Future<List<Character>> loadCharacters() async{
  final jsonString = await rootBundle.loadString('assets/characters.json');
  final jsonData = jsonDecode(jsonString);

  final jsonCharactersList =jsonData['characters'];

  List<Character> characters = [];
  for (final jsonCharacter in jsonCharactersList) {
    characters.add(Character.fromJson(jsonCharacter));
  }
  return characters;
}