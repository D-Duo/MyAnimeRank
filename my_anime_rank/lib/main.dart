import 'package:flutter/material.dart';
import 'package:my_anime_rank/data_provider.dart';
import 'package:my_anime_rank/screens/home_screen/home_screen.dart';
import 'package:my_anime_rank/screens/character_screen/character_screen.dart';
import 'package:my_anime_rank/screens/anime_screen/anime_screen.dart';
import 'package:my_anime_rank/screens/rank_screen/ranks_screen.dart';
import 'package:my_anime_rank/screens/profile_screen/editprofile_screen.dart';
import 'package:my_anime_rank/screens/seasonal_screen/seasonal_screen.dart';
import 'package:provider/provider.dart';

import 'screens/profile_screen/profile_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/rankListsDemo',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HomeScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Customize the transition for the characterDemo route
                // You can use different transition effects for each route
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          case '/characterDemo':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const CharacterScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Customize the transition for the characterDemo route
                // You can use different transition effects for each route
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              settings: RouteSettings(
                arguments: settings.arguments as int,
              ),
            );
          case '/animeDemo':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const AnimeScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Customize the transition for the characterDemo route
                // You can use different transition effects for each route
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              settings: RouteSettings(
                arguments: settings.arguments as int,
              ),
            );
          case '/profileDemo':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const ProfileScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Customize the transition for the characterDemo route
                // You can use different transition effects for each route
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          case '/editProfileDemo':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const EditProfileScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Customize the transition for the characterDemo route
                // You can use different transition effects for each route
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          case '/seasonalDemo':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const SeasonalScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Customize the transition for the characterDemo route
                // You can use different transition effects for each route
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          case '/rankListsDemo':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const RanksScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Customize the transition for the characterDemo route
                // You can use different transition effects for each route
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          default:
            // If the route is not found, you can return a default page or navigate to an error page
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                body: Center(
                  child: Text('Route not found'),
                ),
              ),
            );
        }
      },
    );
  }
}
