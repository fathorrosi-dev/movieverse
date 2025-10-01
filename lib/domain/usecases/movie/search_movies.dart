import 'package:dartz/dartz.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/domain/repositories/repository.dart';
import 'package:movieverse/utils/network_exceptions.dart';

class SearchMovies {
  final Repository repository;

  SearchMovies(this.repository);

  Future<Either<NetworkExceptions, List<Movie>>> execute(query) {
    return repository.searchMovies(query);
  }
}
