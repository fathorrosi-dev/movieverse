import 'package:equatable/equatable.dart';
import 'package:movieverse/domain/entities/genre.dart';

class TvSeriesDetail extends Equatable {
  const TvSeriesDetail({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String originalName;
  // final int episodeRunTime;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String overview;
  final double popularity;
  final String posterPath;
  final String name;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        id,
        originalName,
        // episodeRunTime,
        numberOfEpisodes,
        numberOfSeasons,
        overview,
        popularity,
        posterPath,
        name,
        voteAverage,
        voteCount,
      ];
}
