import 'package:dartz/dartz.dart';
import 'package:movieverse/domain/entities/tv/tv_series_detail.dart';
import 'package:movieverse/domain/repositories/repository.dart';
import 'package:movieverse/utils/network_exceptions.dart';

class GetTvSeriesDetail {
  final Repository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<NetworkExceptions, TvSeriesDetail>> execute(id) {
    return repository.getTvSeriesDetail(id);
  }
}
