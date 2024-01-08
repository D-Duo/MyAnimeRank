import 'package:flutter/material.dart';
import 'package:my_anime_rank/data_provider.dart';
import 'package:my_anime_rank/objects/preview_item.dart';
import 'package:my_anime_rank/objects/profile.dart';
import 'package:provider/provider.dart';

class RankListsItemDisplay extends StatefulWidget {
  RankListsItemDisplay(
      {super.key,
      required this.previewItems,
      required this.index,
      this.showArrows = true,
      this.reload,
      this.anime = true});

  final List<PreviewItem> previewItems;
  final int index;
  final bool showArrows;
  final bool anime;

  void Function()? reload;

  @override
  State<RankListsItemDisplay> createState() => _RankListsItemDisplayState();
}

class _RankListsItemDisplayState extends State<RankListsItemDisplay> {
  @override
  Widget build(BuildContext context) {
    Profile? profile = Provider.of<ProfileProvider>(context).profile;
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: true);
    return Row(
      children: [
        Container(
          height: 120,
          width: 80 * (3 / 4),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.transparent,
                Color.fromARGB(150, 204, 0, 119),
              ],
            ),
          ),
          child: Center(
            child: Text(
              "${widget.index + 1}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Container(
          height: 120,
          width: 120 * (3 / 4),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.previewItems[widget.index].itemImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.previewItems[widget.index].mainString,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                widget.previewItems[widget.index].secondaryString ?? "",
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 10,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const Spacer(),
        if (widget.showArrows)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    // swap position with the item before
                    setState(() {
                      //swap in the previewItems list
                      if (widget.index != 0) {
                        var temp = widget.previewItems[widget.index];
                        widget.previewItems[widget.index] =
                            widget.previewItems[widget.index - 1];
                        widget.previewItems[widget.index - 1] = temp;
                        widget.reload!();
                        //swap in the list of provider and json
                        //anime case and characters case
                        switch (widget.anime) {
                          case true:
                            //checking profile, its animeranklist or characterranklist exists
                            if (profile != null &&
                                profile.animeRankList != null) {
                              //looping to find in the list correct rank number to swap
                              bool done1 = false;
                              bool done2 = false;
                              for (var i = 0;
                                  i < profile.animeRankList!.length;
                                  i++) {
                                //swapping method
                                if (profile.animeRankList![i].rank - 1 ==
                                        widget.index &&
                                    !done1) {
                                  profile.animeRankList![i].rank--;
                                  done1 = true;
                                  print(
                                      "${profile.animeRankList![i].rank + 1} with id ${profile.animeRankList![i].id} now is ${profile.animeRankList![i].rank}");
                                } else if (profile.animeRankList![i].rank - 1 ==
                                        widget.index - 1 &&
                                    !done2) {
                                  profile.animeRankList![i].rank++;
                                  done2 = true;
                                  print(
                                      "${profile.animeRankList![i].rank - 1} with id ${profile.animeRankList![i].id} now is ${profile.animeRankList![i].rank}");
                                }
                              }
                            }
                          case false:
                            //checking profile, its animeranklist or characterranklist exists
                            if (profile != null &&
                                profile.characterRankList != null) {
                              //looping to find in the list correct rank number to swap
                              bool done1 = false;
                              bool done2 = false;
                              for (var i = 0;
                                  i < profile.characterRankList!.length;
                                  i++) {
                                //swapping method
                                if (profile.characterRankList![i].rank - 1 ==
                                        widget.index &&
                                    !done1) {
                                  profile.characterRankList![i].rank--;
                                  done1 = true;
                                  print(
                                      "${profile.characterRankList![i].rank + 1} with id ${profile.characterRankList![i].id} now is ${profile.characterRankList![i].rank}");
                                } else if (profile.characterRankList![i].rank -
                                            1 ==
                                        widget.index - 1 &&
                                    !done2) {
                                  profile.characterRankList![i].rank++;
                                  done2 = true;
                                  print(
                                      "${profile.characterRankList![i].rank - 1} with id ${profile.characterRankList![i].id} now is ${profile.characterRankList![i].rank}");
                                }
                              }
                            }
                          default:
                        }
                        profile!.favCharacter =
                            widget.previewItems[0].mainString;
                        profileProvider.UpdateJson();
                      }
                    });
                  },
                  icon: const Icon(Icons.arrow_upward_rounded),
                ),
                IconButton(
                  onPressed: () {
                    // swap position with the item after
                    setState(() {
                      //swap in the previewItems list
                      if (widget.index != widget.previewItems.length - 1) {
                        var temp = widget.previewItems[widget.index];
                        widget.previewItems[widget.index] =
                            widget.previewItems[widget.index + 1];
                        widget.previewItems[widget.index + 1] = temp;
                        widget.reload!();
                        //swap in the list of provider and json
                        //anime case and characters case
                        switch (widget.anime) {
                          case true:
                            //checking profile, its animeranklist or characterranklist exists
                            if (profile != null &&
                                profile.animeRankList != null) {
                              //looping to find in the list correct rank number to swap
                              bool done1 = false;
                              bool done2 = false;
                              for (var i = 0;
                                  i < profile.animeRankList!.length;
                                  i++) {
                                //swapping method
                                if (profile.animeRankList![i].rank - 1 ==
                                        widget.index &&
                                    !done1) {
                                  profile.animeRankList![i].rank++;
                                  done1 = true;
                                  print(
                                      "${profile.animeRankList![i].rank - 1} with id ${profile.animeRankList![i].id} now is ${profile.animeRankList![i].rank}");
                                } else if (profile.animeRankList![i].rank - 1 ==
                                        widget.index + 1 &&
                                    !done2) {
                                  profile.animeRankList![i].rank--;
                                  done2 = true;
                                  print(
                                      "${profile.animeRankList![i].rank + 1} with id ${profile.animeRankList![i].id} now is ${profile.animeRankList![i].rank}");
                                }
                              }
                            }
                          case false:
                            //checking profile, its animeranklist or characterranklist exists
                            if (profile != null &&
                                profile.characterRankList != null) {
                              //looping to find in the list correct rank number to swap
                              bool done1 = false;
                              bool done2 = false;
                              for (var i = 0;
                                  i < profile.characterRankList!.length;
                                  i++) {
                                //swapping method
                                if (profile.characterRankList![i].rank - 1 ==
                                        widget.index &&
                                    !done1) {
                                  profile.characterRankList![i].rank++;
                                  done1 = true;
                                  print(
                                      "${profile.characterRankList![i].rank - 1} with id ${profile.characterRankList![i].id} now is ${profile.characterRankList![i].rank}");
                                } else if (profile.characterRankList![i].rank -
                                            1 ==
                                        widget.index + 1 &&
                                    !done2) {
                                  profile.characterRankList![i].rank--;
                                  done2 = true;
                                  print(
                                      "${profile.characterRankList![i].rank + 1} with id ${profile.characterRankList![i].id} now is ${profile.characterRankList![i].rank}");
                                }
                              }
                            }
                          default:
                        }
                        profile!.favCharacter =
                            widget.previewItems[0].mainString;
                        profileProvider.UpdateJson();
                      }
                    });
                  },
                  icon: const Icon(Icons.arrow_downward_rounded),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
