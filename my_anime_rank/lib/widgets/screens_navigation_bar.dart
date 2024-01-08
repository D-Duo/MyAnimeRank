import 'package:flutter/material.dart';
import 'package:my_anime_rank/widgets/show_selected_screen.dart';

double barHeight = 50;

class ScreensNavigationBar extends StatelessWidget {
  const ScreensNavigationBar({
    super.key,
    required this.screen,
    required this.screenId,
  });

  final String screen;
  final int screenId;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomAppBar(
          elevation: 0,
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          height: barHeight,
          color: const Color.fromARGB(
              255, 29, 42, 59), // Set the color of the BottomAppBar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ShowSelectedScreenGradient(
                  barHeight: barHeight,
                  isSelected: screenId == 1 ? true : false,
                  child: IconButton(
                    icon: const Icon(Icons.person,
                        color: Color.fromARGB(255, 252, 217, 217)),
                    onPressed: () {
                      if (screen != "/profileDemo") {
                        Navigator.of(context).pushNamed("/profileDemo");
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: ShowSelectedScreenGradient(
                  barHeight: barHeight,
                  isSelected: screenId == 2 ? true : false,
                  child: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      if (screen != "/") {
                        Navigator.of(context).pushNamed("/");
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: ShowSelectedScreenGradient(
                  barHeight: barHeight,
                  isSelected: screenId == 3 ? true : false,
                  child: IconButton(
                    icon: const Icon(Icons.calendar_today_rounded,
                        color: Colors.white),
                    onPressed: () {
                      if (screen != "/seasonalDemo") {
                        Navigator.of(context).pushNamed("/seasonalDemo");
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: ShowSelectedScreenGradient(
                  barHeight: barHeight,
                  isSelected: screenId == 4 ? true : false,
                  child: IconButton(
                    icon: const Icon(Icons.format_list_bulleted_rounded,
                        color: Colors.white),
                    onPressed: () {
                      if (screen != "/rankListsDemo") {
                        Navigator.of(context).pushNamed("/rankListsDemo");
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        //ShowSelectedScreenGradient(barHeight: barHeight, screenId: screenId),
      ],
    );
  }
}
