import 'package:dartz/dartz.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/domain/entities/movie/movie_detail.dart';
import 'package:movieverse/domain/entities/tv/tv_series.dart';
import 'package:movieverse/domain/entities/tv/tv_series_detail.dart';
import 'package:movieverse/utils/network_exceptions.dart';

abstract class Repository {
  Future<Either<NetworkExceptions, List<Movie>>> getPopularMovies();
  Future<Either<NetworkExceptions, List<Movie>>> getTopRatedMovies();
  Future<Either<NetworkExceptions, List<Movie>>> getNowPlayingMovies();
  Future<Either<NetworkExceptions, List<Movie>>> getDiscoverMovies();
  Future<Either<NetworkExceptions, List<Movie>>> getTrendingMovies();
  Future<Either<NetworkExceptions, List<Movie>>> getUpcomingMovies();
  Future<Either<NetworkExceptions, MovieDetail>> getMovieDetail(int id);
  Future<Either<NetworkExceptions, List<Movie>>> getMovieRecommendations(
      int id);
  Future<Either<NetworkExceptions, List<Movie>>> searchMovies(String query);
  Future<Either<NetworkExceptions, List<TvSeries>>> getAiringTodayTvSeries();
  Future<Either<NetworkExceptions, List<TvSeries>>> getPopularTvSeries();
  Future<Either<NetworkExceptions, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<NetworkExceptions, List<TvSeries>>> getDiscoverTvSeries();
  Future<Either<NetworkExceptions, List<TvSeries>>> getTrendingTvSeries();
  Future<Either<NetworkExceptions, List<TvSeries>>> getOnTheAirTvSeries();
  Future<Either<NetworkExceptions, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<NetworkExceptions, List<TvSeries>>> getTvSeriesRecommendations(
      int id);
  Future<Either<NetworkExceptions, List<TvSeries>>> searchTvSeries(
      String query);
}
