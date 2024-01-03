import 'dart:convert';
import 'package:http/http.dart' as http;

class TitleItem {
  final String title;
  final String imagePath;

  TitleItem({
    required this.title,
    required this.imagePath,
  });
}

class Character {
  int? apiId;
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
  })  : favs = favs_ ?? 0,
        rank = rank_?.toString() ?? "Unranked";

  Character.fromJsonRemote(Map<String, dynamic> json)
      : apiId = json["id"],
        name = json["name"]["full"],
        descriptionShort = json["description"],
        descriptionLong = json["descriptionLong"],
        bestAlias = json["name"]["alternative"][0],
        favs = json["favourites"] ?? 0,
        rank = json["rank"] ?? "Unranked",
        mainImagePaths = [json["image"]["large"]],
        filmography = (json["filmography"] as List<dynamic>?)
            ?.map<TitleItem>((item) => TitleItem(
                  title: item["title"] as String,
                  imagePath: item["imagePath"] as String,
                ))
            .toList();
}

Future<Character> loadCharacterRemote(int characterId) async {
  dynamic lastException;

  final query = '''
      query (\$id: Int) {
        Character (id: \$id) {
          id
          name {
            full
            alternative
          }
          image {
            large
          }
          description
          favourites
        }
      }
    ''';

  final variables = {'id': characterId};

  final url = 'https://graphql.anilist.co';
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  final body = {'query': query, 'variables': variables};

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: json.encode(body),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final characterJson = data['data']['Character'];
    final character = Character.fromJsonRemote(characterJson);
    return character;
  } else if (response.statusCode == 429) {
    final retryAfter = response.headers['retry-after'];
    lastException = '''Error in loadCharacterRemote: ${response.statusCode}. Surpassed requests per minute limit.
    Retry after ${retryAfter ?? 'unknown'} seconds pressing the next button.''';
    return Future.error(lastException); // Return an error future
  } else {
    lastException = ('Error in loadCharacterRemote: ${response.statusCode}. Retry pressing the next button.');
    return Future.error(lastException); // Return an error future
  }
}


Future<List<Character>> loadCharacters() async {
  List<Future<Character>> characterFutures = [
    loadCharacterRemote(124381),
    loadCharacterRemote(40882),
    loadCharacterRemote(176754),
    loadCharacterRemote(80),
    loadCharacterRemote(40),
    loadCharacterRemote(16342),
    loadCharacterRemote(138100),
    loadCharacterRemote(169679),
    loadCharacterRemote(138101),
    loadCharacterRemote(138102),
    loadCharacterRemote(36765),
    loadCharacterRemote(36828),
    loadCharacterRemote(73935),
    loadCharacterRemote(81929),
    loadCharacterRemote(130102),
    loadCharacterRemote(137079),
    loadCharacterRemote(88747),
    loadCharacterRemote(88748),
    loadCharacterRemote(88750),
    loadCharacterRemote(88749),
  ];

  List<Character> characters = await Future.wait(characterFutures);

  return characters;
}
