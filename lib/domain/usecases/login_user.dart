import 'package:dartz/dartz.dart';
import 'package:movieverse/domain/repositories/firebase_repository.dart';
import 'package:movieverse/utils/database_exceptions.dart';

class LoginUser {
  final FirebaseRepository firrebaseRepository;

  LoginUser(this.firrebaseRepository);

  Future<Either<DatabaseException, void>> execute(
      String email, String password) {
    return firrebaseRepository.loginUser(email, password);
  }
}
