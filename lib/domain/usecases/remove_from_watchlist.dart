import 'package:dartz/dartz.dart';
import 'package:movieverse/domain/repositories/firebase_repository.dart';
import 'package:movieverse/utils/database_exceptions.dart';

class RemoveFromWatchlist {
  final FirebaseRepository firrebaseRepository;

  RemoveFromWatchlist(this.firrebaseRepository);

  Future<Either<DatabaseException, String>> execute(String id) {
    return firrebaseRepository.removeFromWatchlist(id);
  }
}
