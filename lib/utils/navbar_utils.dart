import 'package:flutter/material.dart';
import 'package:movieverse/main.dart';

List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: '',
    icon: Icon(
      Icons.home,
      color: $styles.theme.neutralColor,
    ),
    label: 'Home',
    selectedIcon: Icon(
      Icons.home_filled,
      color: $styles.theme.tertiaryColor,
    ),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(
      Icons.movie_outlined,
      color: $styles.theme.neutralColor,
    ),
    label: 'Movie',
    selectedIcon: Icon(
      Icons.movie,
      color: $styles.theme.tertiaryColor,
    ),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(
      Icons.tv,
      color: $styles.theme.neutralColor,
    ),
    label: 'Tv',
    selectedIcon: Icon(
      Icons.live_tv_rounded,
      color: $styles.theme.tertiaryColor,
    ),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(
      Icons.bookmark,
      color: $styles.theme.neutralColor,
    ),
    label: 'Watchlist',
    selectedIcon: Icon(
      Icons.bookmark_added,
      color: $styles.theme.tertiaryColor,
    ),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(
      Icons.person,
      color: $styles.theme.neutralColor,
    ),
    label: 'Profile',
    selectedIcon: Icon(
      Icons.person_2_rounded,
      color: $styles.theme.tertiaryColor,
    ),
  )
];
