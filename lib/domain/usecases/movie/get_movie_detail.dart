import 'package:dartz/dartz.dart';
import 'package:movieverse/domain/entities/movie/movie_detail.dart';
import 'package:movieverse/domain/repositories/repository.dart';
import 'package:movieverse/utils/network_exceptions.dart';

class GetMovieDetail {
  final Repository repository;

  GetMovieDetail(this.repository);

  Future<Either<NetworkExceptions, MovieDetail>> execute(id) {
    return repository.getMovieDetail(id);
  }
}
