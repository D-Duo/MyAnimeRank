import 'package:flutter/material.dart';
import 'package:my_anime_rank/data_provider.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar(
      {super.key, required this.charID, required this.charRankL});

  final int charID;
  final List<RankListItem>? charRankL;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState(charID, charRankL);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool favourite = false;

  late int charID;
  late List<RankListItem>? charRankL;

  _CustomAppBarState(this.charID, this.charRankL);

  @override
  void initState() {
    super.initState();
    favourite = checkFavourite(charRankL, charID);
  }

  @override
  Widget build(BuildContext context) {
    Profile? profile = Provider.of<ProfileProvider>(context).profile;
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: true);

    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              hoverColor: const Color.fromARGB(100, 19, 28, 39),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(100, 19, 28, 39))),
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            IconButton(
              hoverColor: const Color.fromARGB(100, 19, 28, 39),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(100, 19, 28, 39))),
              icon: Icon(
                favourite ? Icons.favorite : Icons.heart_broken,
                color: favourite ? Colors.red : Colors.white,
                size: 25,
              ),
              onPressed: () {
                setState(() {
                  favourite = !favourite;
                  //if fav add to ranklist
                  if (favourite) {
                    profile?.characterRankList?.add(RankListItem(
                        id: charID,
                        rank: profile.characterRankList!.last.rank + 1));
                  } else {
                    profileProvider.removeFromList(
                        getItem(profile!.characterRankList, charID), false);
                  }
                  profileProvider.UpdateJson();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

int getRank(List<RankListItem>? list, int id) {
  for (int i = 0; i < list!.length; i++) {
    if (list[i].id == id) {
      return list[i].rank;
    }
  }
  return 0;
}

bool checkFavourite(List<RankListItem>? list, int id) {
  for (int i = 0; i < list!.length; i++) {
    if (list[i].id == id) {
      return true;
    }
  }
  return false;
}

RankListItem? getItem(List<RankListItem>? list, int id) {
  for (int i = 0; i < list!.length; i++) {
    if (list[i].id == id) {
      return list[i];
    }
  }
  return null;
}
