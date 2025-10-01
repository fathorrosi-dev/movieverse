import 'package:dartz/dartz.dart';
import 'package:movieverse/domain/entities/watchlist_item.dart';
import 'package:movieverse/domain/repositories/firebase_repository.dart';
import 'package:movieverse/utils/database_exceptions.dart';

class GetWatchlist {
  final FirebaseRepository firrebaseRepository;

  GetWatchlist(this.firrebaseRepository);

  Future<Either<DatabaseException, List<WatchlistItem>>> execute() {
    return firrebaseRepository.getWatchlist();
  }
}
