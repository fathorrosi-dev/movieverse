import 'package:equatable/equatable.dart';
import 'package:movieverse/data/models/genre_model.dart';
import 'package:movieverse/domain/entities/tv/tv_series_detail.dart';

class TvSeriesDetailModel extends Equatable {
  const TvSeriesDetailModel({
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
  final List<GenreModel> genres;
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

  factory TvSeriesDetailModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailModel(
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        originalName: json["original_name"],
        // episodeRunTime: json["episode_run_time"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "original_name": originalName,
        // "episode_run_time": episodeRunTime,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      originalName: originalName,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      name: name,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

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
