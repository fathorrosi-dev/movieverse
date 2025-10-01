import 'package:dartz/dartz.dart';
import 'package:movieverse/domain/repositories/firebase_repository.dart';
import 'package:movieverse/utils/database_exceptions.dart';

class RegisterUser {
  final FirebaseRepository firrebaseRepository;

  RegisterUser(this.firrebaseRepository);

  Future<Either<DatabaseException, void>> execute(
      String name, String email, String password) {
    return firrebaseRepository.registerUser(name, email, password);
  }
}
