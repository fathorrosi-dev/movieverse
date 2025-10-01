import 'package:dartz/dartz.dart';
import 'package:movieverse/domain/entities/tv/tv_series.dart';
import 'package:movieverse/domain/repositories/repository.dart';
import 'package:movieverse/utils/network_exceptions.dart';

class GetTvSeriesRecommendations {
  final Repository repository;

  GetTvSeriesRecommendations(this.repository);

  Future<Either<NetworkExceptions, List<TvSeries>>> execute(id) {
    return repository.getTvSeriesRecommendations(id);
  }
}
