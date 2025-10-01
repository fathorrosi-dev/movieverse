import 'package:dartz/dartz.dart';
import 'package:movieverse/data/datasources/remoteDataSource/remote_data_source.dart';
import 'package:movieverse/data/services/api_result.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/domain/entities/movie/movie_detail.dart';
import 'package:movieverse/domain/entities/tv/tv_series.dart';
import 'package:movieverse/domain/entities/tv/tv_series_detail.dart';
import 'package:movieverse/domain/repositories/repository.dart';
import 'package:movieverse/utils/network_exceptions.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;

  RepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<NetworkExceptions, List<Movie>>> getPopularMovies() async {
    try {
      final result = await remoteDataSource.getPopularMovies();
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<Movie>>> getTopRatedMovies() async {
    try {
      final result = await remoteDataSource.getTopRatedMovies();
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<Movie>>> getNowPlayingMovies() async {
    try {
      final result = await remoteDataSource.getNowPlayingMovies();
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<Movie>>> getDiscoverMovies() async {
    try {
      final result = await remoteDataSource.getDiscoverMovies();
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<Movie>>> getTrendingMovies() async {
    try {
      final result = await remoteDataSource.getTrendingMovies();
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<Movie>>> getUpcomingMovies() async {
    try {
      final result = await remoteDataSource.getUpcomingMovies();
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, MovieDetail>> getMovieDetail(int id) async {
    try {
      final result = await remoteDataSource.getMovieDetail(id);
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) => Right(data!.toEntity()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<Movie>>> getMovieRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.getMovieRecommendations(id);
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<Movie>>> searchMovies(
      String query) async {
    try {
      final result = await remoteDataSource.searchMovies(query);
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<TvSeries>>>
      getAiringTodayTvSeries() async {
    try {
      final result = await remoteDataSource.getAiringTodayTvSeries();
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<TvSeries>>> getPopularTvSeries() async {
    try {
      final result = await remoteDataSource.getPopularTvSeries();
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<TvSeries>>>
      getTopRatedTvSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTvSeries();
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<TvSeries>>>
      getDiscoverTvSeries() async {
    try {
      final result = await remoteDataSource.getDiscoverTvSeries();
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<TvSeries>>>
      getTrendingTvSeries() async {
    try {
      final result = await remoteDataSource.getTrendingTvSeries();
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<TvSeries>>>
      getOnTheAirTvSeries() async {
    try {
      final result = await remoteDataSource.getOnTheAirTvSeries();
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, TvSeriesDetail>> getTvSeriesDetail(
      int id) async {
    try {
      final result = await remoteDataSource.getTvSeriesDetail(id);
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) => Right(data!.toEntity()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<TvSeries>>> getTvSeriesRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.getTvSeriesRecommendations(id);
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, List<TvSeries>>> searchTvSeries(
      String query) async {
    try {
      final result = await remoteDataSource.searchTvSeries(query);
      const networkException = NetworkExceptions.unexpectedError();
      return result.when(
          success: (data) =>
              Right(data!.map((model) => model.toEntity()).toList()),
          failure: (error) => const Left(networkException));
    } catch (e) {
      return const Left(NetworkExceptions.unexpectedError());
    }
  }
}
