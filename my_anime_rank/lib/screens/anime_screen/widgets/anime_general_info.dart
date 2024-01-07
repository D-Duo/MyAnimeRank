import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/anime.dart';

const double paddingSize = 12;
const double GIfontSize = 16;

class GeneralInformation extends StatelessWidget {
  const GeneralInformation({
    super.key,
    required this.anime,
  });

  final Anime anime;

  SizedBox _space(double h) => SizedBox(height: h);
  String MonthToString(int m) {
    switch (m) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "Month not found";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Title",
                      style:
                          TextStyle(color: Colors.white, fontSize: GIfontSize),
                    ),
                    Text(anime.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: GIfontSize)),
                    _space(paddingSize),
                    const Text("Source",
                        style: TextStyle(
                            color: Colors.white, fontSize: GIfontSize)),
                    Text(anime.source,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: GIfontSize,
                            fontWeight: FontWeight.w600)),
                    _space(paddingSize),
                    const Text("Studio",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: GIfontSize,
                            fontWeight: FontWeight.w600)),
                    Text(anime.studios.first,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: GIfontSize,
                            fontWeight: FontWeight.w600)),
                    _space(paddingSize),
                    const Text("Rating",
                        style: TextStyle(
                            color: Colors.white, fontSize: GIfontSize)),
                    Text(anime.isAdult == true ? "PG-13" : "PG-18",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: GIfontSize,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 200,
              width: 3,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 35,
                  colors: [
                    Color(0xFF365583), // #365583
                    Color(0xFF1D2A3B), // #1D2A3B
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Season",
                        style: TextStyle(
                            color: Colors.white, fontSize: GIfontSize)),
                    Text("${anime.season} ${anime.startDateYear == 0 ? anime.startDateYear : "Not released"}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: GIfontSize,
                            fontWeight: FontWeight.w600)),
                    _space(paddingSize),
                    const Text("Aired",
                        style: TextStyle(
                            color: Colors.white, fontSize: GIfontSize)),
                    Text(
                      anime.startDateYear == 0 ? "${MonthToString(anime.startDateMonth)}/${anime.startDateYear} to ${anime.status == "FINISHED" || anime.status == "CANCELLED" ? "${MonthToString(anime.endDateMonth)}/${anime.endDateYear}" : "?"}" : "Not released",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: GIfontSize,
                          fontWeight: FontWeight.w600),
                      softWrap: true, // Enable text wrapping
                      maxLines: 2,
                    ),
                    _space(paddingSize),
                    const Text("Licensor",
                        style: TextStyle(
                            color: Colors.white, fontSize: GIfontSize)),
                    const Text("Funanimation",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: GIfontSize,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
