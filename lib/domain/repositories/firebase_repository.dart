import 'package:dartz/dartz.dart';
import 'package:movieverse/domain/entities/user_entity.dart';
import 'package:movieverse/domain/entities/watchlist_item.dart';
import 'package:movieverse/utils/database_exceptions.dart';

abstract class FirebaseRepository {
  Future<Either<DatabaseException, void>> registerUser(
      String name, String email, String password);
  Future<Either<DatabaseException, void>> loginUser(
      String email, String password);
  Future<Either<DatabaseException, UserEntity>> getUserData();
  Future<Either<DatabaseException, String>> addToWatchlist(
      String id, String name, String posterPath, String release, bool isMovie);
  Future<Either<DatabaseException, String>> removeFromWatchlist(String id);
  Future<Either<DatabaseException, List<WatchlistItem>>> getWatchlist();
  Future<bool> getWatchlistById(String id);
  Future<bool> autoLogin();
  Future<bool> logoutUser();
}
