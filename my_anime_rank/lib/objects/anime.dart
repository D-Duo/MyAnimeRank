import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

class TitleItem {
  final String title;
  final String imagePath;

  TitleItem({
    required this.title,
    required this.imagePath,
  });
}

class CharacterItem {
  final String Cname;
  final String CimagePath;
  final String role;
  final String VAname;
  final String VAimagePath;

  CharacterItem({
    required this.Cname,
    required this.CimagePath,
    required this.role,
    required this.VAname,
    required this.VAimagePath,
  });
}

class StatsItem {
  final int score;
  final int amount;

  StatsItem({
    required this.score,
    required this.amount,
  });
}

class Anime {
  int? apiId;
  final String title;
  final String type;
  final String format;
  final String status;
  final String descriptionShort;
  final String? descriptionLong;
  final int startDateYear;
  final int startDateMonth;
  final int endDateYear;
  final int endDateMonth;
  final String season;
  final int episodes;
  final String source;
  final List<String> mainImagePaths;
  final List<String> genres;
  final List<String> studios;
  final int statsScore;
  final int statsAmount;
  final int favs;
  final String rank;
  final List<CharacterItem>? character;

  Anime({
    required this.title,
    required this.type,
    required this.format,
    required this.status,
    required this.descriptionShort,
    this.descriptionLong,
    required this.startDateYear,
    required this.startDateMonth,
    required this.endDateYear,
    required this.endDateMonth,
    required this.season,
    required this.episodes,
    required this.source,
    required this.mainImagePaths,
    required this.genres,
    required this.studios,
    required this.statsScore,
    required this.statsAmount,
    int? favs_,
    int? rank_,
    this.character,
  })  : favs = favs_ ?? 0,
        rank = rank_?.toString() ?? "Unranked";

  Anime.fromJsonRemote(Map<String, dynamic> json)
      : apiId = json["id"],
        title = json["title"]["english"],
        type = json["type"],
        format = json["format"],
        status = json["status"],
        descriptionShort = json["description"],
        descriptionLong = json["descriptionLong"],
        startDateYear = json["startDate"]["year"],
        startDateMonth = json["startDate"]["month"],
        endDateYear = json["endDate"]["year"],
        endDateMonth = json["endDate"]["month"],
        season = json["season"],
        episodes = json["episodes"],
        source = json["source"],
        mainImagePaths = [json["image"]["large"]],
        genres = json["genres"],
        studios = json["studios"]["nodes"],
        statsScore = json["scoreDistribution"]["score"],
        statsAmount = json["scoreDistribution"]["amount"],
        favs = json["favourites"] ?? 0,
        rank = json["rank"] ?? "Unranked",
        character = (json["characters"]["edges"] as List<dynamic>?)
            ?.map<CharacterItem>((item) {
          final node = item["node"];
          return CharacterItem(
            Cname: node["name"]["full"] as String,
            CimagePath: node["image"] as String,
            role: item["role"] as String,
            VAname: (node["voiceActors"] as List<dynamic>).isNotEmpty
                ? node["voiceActors"][0]["name"]["full"] as String
                : "",
            VAimagePath: (node["voiceActors"] as List<dynamic>).isNotEmpty
                ? node["voiceActors"][0]["image"] as String
                : "",
          );
        }).toList();
}
// final String Cname;
//   final List<String> CimagePath;
//   final String role;
//   final String VAname;
//   final List<String> VAimagePath;

Future<Anime> loadAnimeRemote(int characterId) async {
  dynamic lastException;

  const query = '''
      query (\$id: Int) {
        Media (id: \$id) {
          id
          title {
            english (stylised: \$Boolean)
          }
          type
          format
          status (\$version: Int)
          description (\$asHtml: Boolean)
          startDate {
            year
            month
          }
          endDate {
            year
            month
          }
          season
          episodes
          source (\$version: Int)
          coverImage {
            large
          }
          genres
          favourites
          characters (\$sort: [CharacterSort]) {
            edges {
              node {
                id
                name {
                  full
                }
                image
              }
              role
              voiceActors {
                id
                name {
                  full
                }
                image
              }
            }    
          }
          studios (\$sort: [StudioSort]) {
            nodes {
              name
            }
          }
          stats {
            scoreDistribution {
              score
              amount
            }
          }

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
    final anime = Anime.fromJsonRemote(characterJson);
    return anime;
  } else if (response.statusCode == 429) {
    final retryAfter = response.headers['retry-after'];
    lastException =
        '''Error in loadAnimeRemote: ${response.statusCode}. Surpassed requests per minute limit.
    Retry after ${retryAfter ?? 'unknown'} seconds pressing the next button.''';
    return Future.error(lastException); // Return an error future
  } else {
    lastException =
        ('Error in loadAnimeRemote: ${response.statusCode}. Retry pressing the next button.');
    return Future.error(lastException); // Return an error future
  }
}

Future<List<Anime>> loadCharacters() async {
  List<Future<Anime>> animeFuture = [
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
    loadAnimeRemote(124381),
  ];

  List<Anime> animes = await Future.wait(animeFuture);

  return animes;
}
