import 'package:movieverse/domain/repositories/firebase_repository.dart';

class LogoutUser {
  final FirebaseRepository firrebaseRepository;

  LogoutUser(this.firrebaseRepository);

  Future<bool> execute() {
    return firrebaseRepository.logoutUser();
  }
}
