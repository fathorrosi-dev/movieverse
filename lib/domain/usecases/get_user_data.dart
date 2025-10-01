import 'package:dartz/dartz.dart';
import 'package:movieverse/domain/entities/user_entity.dart';
import 'package:movieverse/domain/repositories/firebase_repository.dart';
import 'package:movieverse/utils/database_exceptions.dart';

class GetUserData {
  final FirebaseRepository firrebaseRepository;

  GetUserData(this.firrebaseRepository);

  Future<Either<DatabaseException, UserEntity>> execute() {
    return firrebaseRepository.getUserData();
  }
}
