// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  TvSeries({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  TvSeries.watchlist(
      {required this.id,
      required this.overview,
      required this.posterPath,
      required this.name});

  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int id;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? name;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        originalName,
        overview,
        popularity,
        posterPath,
        name,
        voteAverage,
        voteCount,
      ];
}
