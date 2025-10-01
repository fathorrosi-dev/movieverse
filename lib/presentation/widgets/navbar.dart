import 'package:flutter/material.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/presentation/screens/home/home_screen.dart';
import 'package:movieverse/presentation/screens/movie/movie_screen.dart';
import 'package:movieverse/presentation/screens/profile/profile_screen.dart';
import 'package:movieverse/presentation/screens/tv/tv_screen.dart';
import 'package:movieverse/presentation/screens/watchlist/watchlist_screen.dart';
import 'package:movieverse/utils/navbar_utils.dart';

class NavigationBars extends StatefulWidget {
  const NavigationBars({
    super.key,
  });

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // App NavigationBar should get first focus.
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          backgroundColor: $styles.theme.primaryColor,
          shadowColor: $styles.theme.primaryColor,
          surfaceTintColor: $styles.theme.primaryColor,
          indicatorColor: $styles.theme.primaryColor,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: appBarDestinations),
      body: <Widget>[
        const HomeScreen(),
        const MovieScreen(),
        const TvScreen(),
        const WatchlistScreen(),
        const ProfileScreen(),
      ][selectedIndex],
    );
  }
}
