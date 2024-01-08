import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_anime_rank/objects/profile.dart';

class PreviewItem {
  int? apiId;
  final String mainString;
  String? secondaryString;
  final String itemImage;
  final int type; // 0 = Character | 1 = Media | ...

  PreviewItem({
    int? type_,
    required this.mainString,
    required this.itemImage,
    this.apiId,
    this.secondaryString,
  }) : type = type_ ?? 0;

  PreviewItem.characterFromJsonRemote(Map<String, dynamic> json)
      : apiId = json["id"],
        mainString = json["name"]["full"],
        secondaryString = (json["name"]["alternative"] == null)
            ? json["name"]["alternative"][0]
            : " ",
        itemImage = json["image"]["large"],
        type = 0;

  PreviewItem.mediaFromJsonRemote(Map<String, dynamic> json)
      : apiId = json["id"],
        mainString = json["title"]["romaji"],
        secondaryString = (json["genres"] as List<dynamic>).join(', '),
        itemImage = json["coverImage"]["large"],
        type = 1;
}

Future<PreviewItem> loadPreviewItemRemoteCharacter(int previewItemId) async {
  dynamic lastException;

  const query = '''
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
        }
      }
    ''';

  final variables = {'id': previewItemId};

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
    final previewItemJson = data['data']['Character'];
    final previewItem = PreviewItem.characterFromJsonRemote(previewItemJson);
    return previewItem;
  } else if (response.statusCode == 429) {
    final retryAfter = response.headers['retry-after'];
    lastException =
        '''Error in loadCharacterRemote: ${response.statusCode}. Surpassed requests per minute limit. Retry after ${retryAfter ?? 'unknown'} seconds pressing the next button.''';
    return Future.error(lastException); // Return an error future
  } else {
    lastException =
        ('Error in loadCharacterRemote: ${response.statusCode}. Retry pressing the next button.');
    return Future.error(lastException); // Return an error future
  }
}

Future<PreviewItem> loadPreviewItemRemoteMedia(int previewItemId) async {
  dynamic lastException;

  const query = '''
      query (\$id: Int) {
        Media (id: \$id) {
          id
          title {
            romaji
          }
          coverImage {
            large
          }
          genres
        }
      }
    ''';

  final variables = {'id': previewItemId};

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
    final previewItemJson = data['data']['Media'];
    final previewItem = PreviewItem.mediaFromJsonRemote(previewItemJson);
    return previewItem;
  } else if (response.statusCode == 429) {
    final retryAfter = response.headers['retry-after'];
    lastException =
        '''Error in loadCharacterRemote: ${response.statusCode}. Surpassed requests per minute limit. Retry after ${retryAfter ?? 'unknown'} seconds pressing the next button.''';
    return Future.error(lastException); // Return an error future
  } else {
    lastException =
        ('Error in loadCharacterRemote: ${response.statusCode}. Retry pressing the next button.');
    return Future.error(lastException); // Return an error future
  }
}

Future<List<PreviewItem>> loadSeasonalList(
    int ammount, String season, int seasonYear) async {
  dynamic lastException;

  const query = '''
      query(\$perPage: Int, \$season: MediaSeason, \$seasonYear: Int) {
        Page(perPage: \$perPage){
          media(season: \$season, seasonYear: \$seasonYear, sort: POPULARITY_DESC, type: ANIME) {
            id
          }
        }
      }
    ''';

  final variables = {
    'perPage': ammount,
    'season': season,
    'seasonYear': seasonYear
  };

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
    final mediaListJson = data['data']['Page']['media'];
    final idList =
        List<int>.from(mediaListJson.map((media) => media['id'] as int));

    List<PreviewItem> finalList = [];

    await Future.wait(idList.map((id) => loadPreviewItemRemoteMedia(id)))
        .then((listOfResults) {
      finalList.addAll(listOfResults);
    });

    return finalList;
  } else if (response.statusCode == 429) {
    final retryAfter = response.headers['retry-after'];
    lastException =
        '''Error in loadCharacterRemote: ${response.statusCode}. Surpassed requests per minute limit. Retry after ${retryAfter ?? 'unknown'} seconds pressing the next button.''';
    return Future.error(lastException); // Return an error future
  } else {
    lastException =
        ('Error in loadCharacterRemote: ${response.statusCode}. Retry pressing the next button.');
    return Future.error(lastException); // Return an error future
  }
}

Future<List<PreviewItem>> loadRankList(
    int amount, List<RankListItem> items, bool itemType) async {
  items.sort((a, b) => a.rank.compareTo(b.rank));

  List<PreviewItem> finalList = [];

  int count = 0;

  if (itemType) {
    await Future.forEach(items, (id) async {
      if (count < amount) {
        PreviewItem result = await loadPreviewItemRemoteMedia(id.id);
        finalList.add(result);
        count++;
      }
    });
  } else {
    await Future.forEach(items, (id) async {
      if (count < amount) {
        PreviewItem result = await loadPreviewItemRemoteCharacter(id.id);
        finalList.add(result);
        count++;
      }
    });
  }

  return finalList;
}

Future<List<PreviewItem>> loadPopularAnimes(int ammount) async {
  dynamic lastException;

  const query = '''
      query(\$perPage: Int) {
        Page(perPage: \$perPage){
          media(sort: POPULARITY_DESC, type: ANIME) {
            id
          }
        }
      }
    ''';

  final variables = {'perPage': ammount};

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
    final mediaListJson = data['data']['Page']['media'];
    final idList =
        List<int>.from(mediaListJson.map((media) => media['id'] as int));

    List<PreviewItem> finalList = [];

    await Future.wait(idList.map((id) => loadPreviewItemRemoteMedia(id)))
        .then((listOfResults) {
      finalList.addAll(listOfResults);
    });

    return finalList;
  } else if (response.statusCode == 429) {
    final retryAfter = response.headers['retry-after'];
    lastException =
        '''Error in loadCharacterRemote: ${response.statusCode}. Surpassed requests per minute limit. Retry after ${retryAfter ?? 'unknown'} seconds pressing the next button.''';
    return Future.error(lastException); // Return an error future
  } else {
    lastException =
        ('Error in loadCharacterRemote: ${response.statusCode}. Retry pressing the next button.');
    return Future.error(lastException); // Return an error future
  }
}

Future<List<PreviewItem>> loadTrendingAnimes(int ammount) async {
  dynamic lastException;

  const query = '''
      query(\$perPage: Int) {
        Page(perPage: \$perPage){
          media(sort: TRENDING_DESC, type: ANIME) {
            id
          }
        }
      }
    ''';

  final variables = {'perPage': ammount};

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
    final mediaListJson = data['data']['Page']['media'];
    final idList =
        List<int>.from(mediaListJson.map((media) => media['id'] as int));

    List<PreviewItem> finalList = [];

    await Future.wait(idList.map((id) => loadPreviewItemRemoteMedia(id)))
        .then((listOfResults) {
      finalList.addAll(listOfResults);
    });

    return finalList;
  } else if (response.statusCode == 429) {
    final retryAfter = response.headers['retry-after'];
    lastException =
        '''Error in loadCharacterRemote: ${response.statusCode}. Surpassed requests per minute limit. Retry after ${retryAfter ?? 'unknown'} seconds pressing the next button.''';
    return Future.error(lastException); // Return an error future
  } else {
    lastException =
        ('Error in loadCharacterRemote: ${response.statusCode}. Retry pressing the next button.');
    return Future.error(lastException); // Return an error future
  }
}

Future<List<PreviewItem>> loadSearchResults(
    int ammount, String searchImput) async {
  dynamic lastException;

  const query = '''
      query(\$search: String, \$perPage: Int) {
        mediaPage: Page(perPage: \$perPage){
          media(search: \$search, sort: SEARCH_MATCH, type: ANIME) {
            id
          }          
        }
        charactersPage: Page(perPage: \$perPage){
          characters(search: \$search, sort: SEARCH_MATCH) {
            id
          }         
        }        
      }
    ''';

  final variables = {
    'perPage': ammount,
    'search': searchImput,
  };

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
    final mediaListJson = data['data']['mediaPage']['media'];
    final idListMedia =
        List<int>.from(mediaListJson.map((media) => media['id'] as int));

    final characterListJson = data['data']['charactersPage']['characters'];
    final idListCharacters = List<int>.from(
        characterListJson.map((character) => character['id'] as int));

    List<PreviewItem> finalList = [];

    await Future.wait(idListMedia.map((id) async {
      try {
        return await loadPreviewItemRemoteMedia(id);
      } catch (error) {
        return null; // Return null for characters with errors
      }
    })).then((listOfResults1) {
      finalList.addAll(listOfResults1.whereType<PreviewItem>());
    });

    await Future.wait(idListCharacters.map((id) async {
      try {
        return await loadPreviewItemRemoteCharacter(id);
      } catch (error) {
        return null; // Return null for characters with errors
      }
    })).then((listOfResults2) {
      finalList.addAll(listOfResults2.whereType<PreviewItem>());
    });

    return finalList;
  } else if (response.statusCode == 429) {
    final retryAfter = response.headers['retry-after'];
    lastException =
        '''Error in loadCharacterRemote: ${response.statusCode}. Surpassed requests per minute limit. Retry after ${retryAfter ?? 'unknown'} seconds pressing the next button.''';
    return Future.error(lastException); // Return an error future
  } else {
    lastException =
        ('Error in loadCharacterRemote: ${response.statusCode}. Retry pressing the next button.');
    return Future.error(lastException); // Return an error future
  }
}
