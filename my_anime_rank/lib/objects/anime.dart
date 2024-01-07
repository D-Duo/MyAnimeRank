import 'dart:convert';
import 'package:http/http.dart' as http;

class CharacterItem {
  int Cid;
  final String Cname;
  final String CimagePath;

  CharacterItem({
    required this.Cid,
    required this.Cname,
    required this.CimagePath,
  });
}

class VoiceActorItem {
  final int VAid;
  final String VAname;
  final String VAimagePath;

  VoiceActorItem({
    required this.VAid,
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
  String description;
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
  final bool isAdult;
  final List<CharacterItem>? characters;
  final int favs;
  final String rank;

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
    required this.isAdult,
    this.characters,
    int? favs_,
    String? rank_,
  })  : favs = favs_ ?? 0,
        rank = rank_?.toString() ?? "Unranked";

  Anime.fromJsonRemote(Map<String, dynamic> json)
      : apiId = json["id"] ?? 0,
        title = json["title"]["romaji"] ?? "Unknown Title",
        type = ((json["type"] ?? "Unknown Type") as String),
        format = ((json["format"] ?? "Unknown Format") as String),
        status = ((json["status"] ?? "Unknown Status") as String),
        description = json["description"] ?? "Unknown Description",
        startDateYear = json["startDate"]["year"] ?? 0,
        startDateMonth = json["startDate"]["month"] ?? 0,
        endDateYear = json["endDate"]["year"] ?? 0,
        endDateMonth = json["endDate"]["month"] ?? 0,
        season = ((json["season"] ?? "Unknown Season") as String),
        episodes = json["episodes"] ?? 0,
        source = ((json["source"] ?? "Unknown Source") as String),
        mainImagePaths = [json["coverImage"]["large"]],
        genres = (json["genres"] as List<dynamic>)
            .map<String>((studio) => studio as String)
            .toList(),
        studios = (json["studios"]["edges"] as List<dynamic>)
            .map<String>((studio) => studio["node"]["name"] as String)
            .toList(),
        isAdult = json["isAdult"],
        favs = json["favourites"] ?? 0,
        rank = json["rank"] ?? "Unranked",
        characters = (json["characters"]["edges"] as List<dynamic>?)
            ?.map<CharacterItem>(
              (item) => CharacterItem(
                Cid: item["node"]["id"],
                Cname: item["node"]["name"]["full"],
                CimagePath: item["node"]["image"]["large"],
              ),
            )
            .toList() {
    description = description.replaceAll('<br>', '\n');
  }
}

Future<Anime> loadAnimeRemote(int animeId) async {
  dynamic lastException;

  const query = '''
      query (\$id: Int) {
        Media (id: \$id) {
          id
          title {
            romaji
          }
          type
          format
          status
          description
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
          characters (role: MAIN) {
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
            }
          }          
          studios {
            edges {
              node {
                name
              }
            }
          }
          isAdult
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

  // Print the GraphQL query and variables
  print('GraphQL Query: $query');
  print('Variables: $variables');

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
    //loadAnimeRemote(21), //one piece
    //loadAnimeRemote(99423), //darling in the franxx
    //loadAnimeRemote(16498), //shingeki
    //loadAnimeRemote(154587), //frieren
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
