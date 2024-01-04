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
  final String description;
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
  final List<CharacterItem>? character;

  Anime({
    required this.title,
    required this.type,
    required this.format,
    required this.status,
    required this.description,
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
    this.character,
  }) : favs = favs_ ?? 0;

  Anime.fromJsonRemote(Map<String, dynamic> json)
      : apiId = json["id"],
        title = json["title"]["romaji"],
        type = json["type"],
        format = json["format"],
        status = json["status"],
        description = json["description"],
        startDateYear = json["startDate"]["year"],
        startDateMonth = json["startDate"]["month"],
        endDateYear = json["endDate"]["year"],
        endDateMonth = json["endDate"]["month"],
        season = json["season"],
        episodes = json["episodes"],
        source = json["source"],
        mainImagePaths = [json["coverImage"]["large"]],
        genres = json["genres"],
        studios = (json["studios"]["nodes"] as List<dynamic>)
            .map<String>((studio) => studio["name"] as String)
            .toList(),
        statsScore = json["stats"]["scoreDistribution"]["score"],
        statsAmount = json["stats"]["scoreDistribution"]["amount"],
        favs = json["favourites"] ?? 0,
        character = (json["characters"]["edges"] as List<dynamic>?)
            ?.map<CharacterItem>((item) {
          final node = item["node"];
          return CharacterItem(
            Cname: node["name"]["full"] as String,
            CimagePath: node["image"] as String,
            role: item["role"] as String,
            VAname: (item["voiceActors"] != null)
                ? item["voiceActors"]["name"]["full"] as String
                : "",
            VAimagePath: (item["voiceActors"] != null)
                ? item["voiceActors"]["image"] as String
                : "",
          );
        }).toList();
}
// final String Cname;
//   final List<String> CimagePath;
//   final String role;
//   final String VAname;
//   final List<String> VAimagePath;

Future<Anime> loadAnimeRemote(int animeId) async {
  dynamic lastException;

  const query = '''
      query (\$id: Int) {
        Media (id: \$id, type: ANIME) {
          id
          title {
            romaji
          }
          type
          format
          status
          description (asHtml: false)
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
          source
          coverImage {
            large
          }
          genres
          favourites
          characters (sort: [MAIN]) {
            edges {
              node {
                id
                name {
                  full
                }
                image {
                  large
                }
              }
              role
              voiceActors (language: JAPANESE) {
                id
                name {
                  full
                }
                image {
                  large
                }
              }
            }    
          }
          studios {
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

  final variables = {'id': animeId};

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
    final animeJson = data['data']['Media'];
    final anime = Anime.fromJsonRemote(animeJson);
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

Future<List<Anime>> loadAnimes() async {
  List<Future<Anime>> animeFuture = [
    loadAnimeRemote(21), //one piece
    loadAnimeRemote(99423), //darling in the franxx
    loadAnimeRemote(16498), //shingeki
    loadAnimeRemote(154587), //frieren
    //loadAnimeRemote(1535), //death note
    //loadAnimeRemote(140960), //spy x fam
    //loadAnimeRemote(11757), //sword art
    //loadAnimeRemote(21087), //one punch
    //loadAnimeRemote(127230), //chainsaw
    //loadAnimeRemote(20657), //saenai heroine
    //loadAnimeRemote(12438), //
    //loadAnimeRemote(1243), //
    //loadAnimeRemote(124), //
    //loadAnimeRemote(12), //
    //loadAnimeRemote(1), //
    //loadAnimeRemote(2), //
    //loadAnimeRemote(3), //
    //loadAnimeRemote(4), //
  ];

  List<Anime> animes = await Future.wait(animeFuture);

  return animes;
}
