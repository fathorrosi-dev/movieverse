import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieverse/data/models/movie/movie_detail_model.dart';
import 'package:movieverse/data/models/movie/movie_model.dart';
import 'package:movieverse/data/models/movie/movie_response.dart';
import 'package:movieverse/data/models/tv/tv_series_detail_model.dart';
import 'package:movieverse/data/models/tv/tv_series_model.dart';
import 'package:movieverse/data/models/tv/tv_series_response.dart';
import 'package:movieverse/data/services/api_result.dart';
import 'package:movieverse/utils/network_exceptions.dart';
import 'package:movieverse/env/env.dart';

abstract class RemoteDataSource {
  Future<ApiResult<List<MovieModel>>> getPopularMovies();
  Future<ApiResult<List<MovieModel>>> getTopRatedMovies();
  Future<ApiResult<List<MovieModel>>> getNowPlayingMovies();
  Future<ApiResult<List<MovieModel>>> getDiscoverMovies();
  Future<ApiResult<List<MovieModel>>> getTrendingMovies();
  Future<ApiResult<List<MovieModel>>> getUpcomingMovies();
  Future<ApiResult<MovieDetailResponse>> getMovieDetail(int id);
  Future<ApiResult<List<MovieModel>>> getMovieRecommendations(int id);
  Future<ApiResult<List<MovieModel>>> searchMovies(String query);
  Future<ApiResult<List<TvSeriesModel>>> getAiringTodayTvSeries();
  Future<ApiResult<List<TvSeriesModel>>> getPopularTvSeries();
  Future<ApiResult<List<TvSeriesModel>>> getTopRatedTvSeries();
  Future<ApiResult<List<TvSeriesModel>>> getDiscoverTvSeries();
  Future<ApiResult<List<TvSeriesModel>>> getTrendingTvSeries();
  Future<ApiResult<List<TvSeriesModel>>> getOnTheAirTvSeries();
  Future<ApiResult<TvSeriesDetailModel>> getTvSeriesDetail(int id);
  Future<ApiResult<List<TvSeriesModel>>> getTvSeriesRecommendations(int id);
  Future<ApiResult<List<TvSeriesModel>>> searchTvSeries(String query);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  final Map<String, String> _header = {
    'accept': 'application/json',
    'Authorization': 'Bearer ${Env.tmdbApiKey}'
  };
  final String _baseUrl = "http://api.themoviedb.org/3";

  @override
  Future<ApiResult<List<MovieModel>>> getPopularMovies() async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/movie/popular?"),
          headers: _header);

      if (response.statusCode == 200) {
        final movieList =
            MovieResponse.fromJson(jsonDecode(response.body)).movieList;
        return ApiResult.success(data: movieList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<MovieModel>>> getTopRatedMovies() async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/movie/top_rated?"),
          headers: _header);

      if (response.statusCode == 200) {
        final movieList =
            MovieResponse.fromJson(jsonDecode(response.body)).movieList;
        return ApiResult.success(data: movieList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<MovieModel>>> getNowPlayingMovies() async {
    try {
      final response = await client
          .get(Uri.parse("$_baseUrl/movie/now_playing?"), headers: _header);

      if (response.statusCode == 200) {
        final movieList =
            MovieResponse.fromJson(jsonDecode(response.body)).movieList;
        return ApiResult.success(data: movieList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<MovieModel>>> getDiscoverMovies() async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/discover/movie?"),
          headers: _header);

      if (response.statusCode == 200) {
        final movieList =
            MovieResponse.fromJson(jsonDecode(response.body)).movieList;
        return ApiResult.success(data: movieList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<MovieModel>>> getTrendingMovies() async {
    try {
      final response = await client
          .get(Uri.parse("$_baseUrl/trending/movie/day?"), headers: _header);

      if (response.statusCode == 200) {
        final movieList =
            MovieResponse.fromJson(jsonDecode(response.body)).movieList;
        return ApiResult.success(data: movieList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<MovieModel>>> getUpcomingMovies() async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/movie/upcoming?"),
          headers: _header);

      if (response.statusCode == 200) {
        final movieList =
            MovieResponse.fromJson(jsonDecode(response.body)).movieList;
        return ApiResult.success(data: movieList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<MovieDetailResponse>> getMovieDetail(int id) async {
    try {
      final response =
          await client.get(Uri.parse("$_baseUrl/movie/$id?"), headers: _header);

      if (response.statusCode == 200) {
        final movieDetail =
            MovieDetailResponse.fromJson(jsonDecode(response.body));
        return ApiResult.success(data: movieDetail);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<MovieModel>>> getMovieRecommendations(int id) async {
    try {
      final response = await client.get(
          Uri.parse("$_baseUrl/movie/$id/recommendations?"),
          headers: _header);

      if (response.statusCode == 200) {
        final movieList =
            MovieResponse.fromJson(jsonDecode(response.body)).movieList;
        return ApiResult.success(data: movieList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<MovieModel>>> searchMovies(String query) async {
    try {
      final response = await client.get(
          Uri.parse("$_baseUrl/search/movie?query=$query"),
          headers: _header);

      if (response.statusCode == 200) {
        final movieList =
            MovieResponse.fromJson(jsonDecode(response.body)).movieList;
        return ApiResult.success(data: movieList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<TvSeriesModel>>> getAiringTodayTvSeries() async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/tv/airing_today?"),
          headers: _header);

      if (response.statusCode == 200) {
        final tvList =
            TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
        return ApiResult.success(data: tvList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<TvSeriesModel>>> getPopularTvSeries() async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/tv/popular?"),
          headers: _header);

      if (response.statusCode == 200) {
        final tvList =
            TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
        return ApiResult.success(data: tvList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<TvSeriesModel>>> getTopRatedTvSeries() async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/tv/top_rated?"),
          headers: _header);

      if (response.statusCode == 200) {
        final tvList =
            TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
        return ApiResult.success(data: tvList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<TvSeriesModel>>> getDiscoverTvSeries() async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/discover/tv?"),
          headers: _header);

      if (response.statusCode == 200) {
        final tvList =
            TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
        return ApiResult.success(data: tvList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<TvSeriesModel>>> getTrendingTvSeries() async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/trending/tv/day?"),
          headers: _header);

      if (response.statusCode == 200) {
        final tvList =
            TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
        return ApiResult.success(data: tvList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<TvSeriesModel>>> getOnTheAirTvSeries() async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/tv/on_the_air?"),
          headers: _header);

      if (response.statusCode == 200) {
        final tvList =
            TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
        return ApiResult.success(data: tvList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<TvSeriesDetailModel>> getTvSeriesDetail(int id) async {
    try {
      final response =
          await client.get(Uri.parse("$_baseUrl/tv/$id?"), headers: _header);

      if (response.statusCode == 200) {
        final tvDetail =
            TvSeriesDetailModel.fromJson(jsonDecode(response.body));
        return ApiResult.success(data: tvDetail);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<TvSeriesModel>>> getTvSeriesRecommendations(
      int id) async {
    try {
      final response = await client.get(
          Uri.parse("$_baseUrl/tv/$id/recommendations?"),
          headers: _header);

      if (response.statusCode == 200) {
        final tvList =
            TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
        return ApiResult.success(data: tvList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }

  @override
  Future<ApiResult<List<TvSeriesModel>>> searchTvSeries(String query) async {
    try {
      final response = await client
          .get(Uri.parse("$_baseUrl/search/tv?query=$query"), headers: _header);

      if (response.statusCode == 200) {
        final tvList =
            TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
        return ApiResult.success(data: tvList);
      } else {
        final networkException = NetworkExceptions.getHttpException(response);
        return ApiResult.failure(error: networkException);
      }
    } catch (e) {
      final response = http.Response('', 500);
      final networkException = NetworkExceptions.getHttpException(response);
      return ApiResult.failure(error: networkException);
    }
  }
}
