import 'dart:convert';
import 'package:http/http.dart' as http;

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
        secondaryString = json["name"]["alternative"][0],
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

Future<List<PreviewItem>> loadItems() async {
  List<Future<PreviewItem>> itemsFutures = [
    loadPreviewItemRemoteMedia(16498),
    loadPreviewItemRemoteMedia(101922),
    loadPreviewItemRemoteMedia(166873),
    loadPreviewItemRemoteCharacter(124381),
    loadPreviewItemRemoteCharacter(40882),
    //loadPreviewItemRemoteCharacter(176754),
    //loadPreviewItemRemoteCharacter(80),
    //loadPreviewItemRemoteCharacter(40),
    //loadPreviewItemRemoteCharacter(16342),
    //loadPreviewItemRemoteCharacter(138100),
    //loadPreviewItemRemoteCharacter(169679),
    //loadPreviewItemRemoteCharacter(138101),
    //loadPreviewItemRemoteCharacter(138102),
    //loadPreviewItemRemoteCharacter(36765),
    //loadPreviewItemRemoteCharacter(36828),
    //loadPreviewItemRemoteCharacter(73935),
    //loadPreviewItemRemoteCharacter(81929),
    //loadPreviewItemRemoteCharacter(130102),
    //loadPreviewItemRemoteCharacter(137079),
    //loadPreviewItemRemoteCharacter(88747),
    //loadPreviewItemRemoteCharacter(88748),
    //loadPreviewItemRemoteCharacter(88750),
    //loadPreviewItemRemoteCharacter(88749),
  ];

  List<PreviewItem> items = await Future.wait(itemsFutures);

  return items;
}
