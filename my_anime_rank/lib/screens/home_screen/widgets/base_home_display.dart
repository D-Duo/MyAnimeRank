import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/preview_item.dart';
import 'package:my_anime_rank/screens/seasonal_screen/widgets/seasonal_filter.dart';
import 'package:my_anime_rank/widgets/previewItem_sideScrollDisplay.dart';

class BaseHomeDisplay extends StatelessWidget {
  const BaseHomeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, top: 45),
              child: const Text(
                "TENDING NOW:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            const TrendingAnimesDisplay(),
            Container(
              padding: const EdgeInsets.only(left: 20, top: 45),
              child: const Text(
                "POPULAR THIS SEASON:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            const SeasonalDemoDisplay(),
            Container(
              padding: const EdgeInsets.only(left: 20, top: 45),
              child: const Text(
                "ALL TIME POPLULAR:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            const TopAnimesDisplay(),
          ],
        ),
      ],
    );
  }
}

class SeasonalDemoDisplay extends StatefulWidget {
  const SeasonalDemoDisplay({super.key});

  @override
  State<SeasonalDemoDisplay> createState() => _SeasonalDemoDisplayState();
}

class _SeasonalDemoDisplayState extends State<SeasonalDemoDisplay> {
  late Future<List<PreviewItem>> _previewItemsFuture;

  String selectedMonth = getCurrentSeason();
  int selectedYear = DateTime.now().year.toInt();

  @override
  void initState() {
    super.initState();
    _previewItemsFuture = loadSeasonalList(4, selectedMonth, selectedYear);
  }

  Future<void> _reloadData() async {
    setState(() {
      _previewItemsFuture = loadSeasonalList(4, selectedMonth, selectedYear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _previewItemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: IconButton(
              icon: const Icon(Icons.refresh_sharp, color: Colors.white),
              onPressed: _reloadData,
            ),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text('No data available'),
          );
        }
        final previewItems = snapshot.data!;
        return Stack(
          children: [
            PreviewItemSideScrollDisplay(previewItems: previewItems),
          ],
        );
      },
    );
  }
}

class TopAnimesDisplay extends StatefulWidget {
  const TopAnimesDisplay({super.key});

  @override
  State<TopAnimesDisplay> createState() => _TopAnimesDisplayState();
}

class _TopAnimesDisplayState extends State<TopAnimesDisplay> {
  late Future<List<PreviewItem>> _previewItemsFuture;

  @override
  void initState() {
    super.initState();
    _previewItemsFuture = loadPopularAnimes(4);
  }

  Future<void> _reloadData() async {
    setState(() {
      _previewItemsFuture = loadPopularAnimes(4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _previewItemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: IconButton(
              icon: const Icon(Icons.refresh_sharp, color: Colors.white),
              onPressed: _reloadData,
            ),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text('No data available'),
          );
        }
        final previewItems = snapshot.data!;
        return Stack(
          children: [
            PreviewItemSideScrollDisplay(previewItems: previewItems),
          ],
        );
      },
    );
  }
}

class TrendingAnimesDisplay extends StatefulWidget {
  const TrendingAnimesDisplay({super.key});

  @override
  State<TrendingAnimesDisplay> createState() => _TrendingAnimesDisplayState();
}

class _TrendingAnimesDisplayState extends State<TrendingAnimesDisplay> {
  late Future<List<PreviewItem>> _previewItemsFuture;

  @override
  void initState() {
    super.initState();
    _previewItemsFuture = loadTrendingAnimes(4);
  }

  Future<void> _reloadData() async {
    setState(() {
      _previewItemsFuture = loadTrendingAnimes(4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _previewItemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: IconButton(
              icon: const Icon(Icons.refresh_sharp, color: Colors.white),
              onPressed: _reloadData,
            ),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text('No data available'),
          );
        }
        final previewItems = snapshot.data!;
        return Stack(
          children: [
            PreviewItemSideScrollDisplay(previewItems: previewItems),
          ],
        );
      },
    );
  }
}