import 'package:dartz/dartz.dart';
import 'package:movieverse/domain/repositories/firebase_repository.dart';
import 'package:movieverse/utils/database_exceptions.dart';

class AddToWatchlist {
  final FirebaseRepository firrebaseRepository;

  AddToWatchlist(this.firrebaseRepository);

  Future<Either<DatabaseException, String>> execute(
      String id, String name, String posterPath, String release, bool isMovie) {
    return firrebaseRepository.addToWatchlist(
        id, name, posterPath, release, isMovie);
  }
}
