import 'package:dartz/dartz.dart';
import 'package:movieverse/data/datasources/database/firebase_helper.dart';
import 'package:movieverse/domain/entities/user_entity.dart';
import 'package:movieverse/domain/entities/watchlist_item.dart';
import 'package:movieverse/domain/repositories/firebase_repository.dart';
import 'package:movieverse/utils/database_exceptions.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseHelper firebaseHelper;

  FirebaseRepositoryImpl({required this.firebaseHelper});

  @override
  Future<bool> autoLogin() async {
    try {
      final user = await firebaseHelper.getCurrentUser();
      if (user) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<DatabaseException, void>> registerUser(
      String name, String email, String password) async {
    try {
      await firebaseHelper.registerUser(name, email, password);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseException, void>> loginUser(
      String email, String password) async {
    try {
      await firebaseHelper.loginUser(email, password);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseException, UserEntity>> getUserData() async {
    try {
      final userModel = await firebaseHelper.getUserData();
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseException, String>> addToWatchlist(String id,
      String name, String posterPath, String release, bool isMovie) async {
    try {
      final result = await firebaseHelper.addToWatchlist(
          id, name, posterPath, release, isMovie);
      return Right(result);
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseException, String>> removeFromWatchlist(
      String id) async {
    try {
      final result = await firebaseHelper.removeFromWatchlist(id);
      return Right(result);
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseException, List<WatchlistItem>>> getWatchlist() async {
    try {
      final watchlistItemModels = await firebaseHelper.getWatchlist();
      final watchlistItems =
          watchlistItemModels.map((model) => model.toEntity()).toList();

      return Right(watchlistItems);
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<bool> getWatchlistById(String id) async {
    final exists = await firebaseHelper.getWatchlistById(id);
    return exists;
  }

  @override
  Future<bool> logoutUser() async {
    final logout = await firebaseHelper.logoutUser();
    return logout;
  }
}
