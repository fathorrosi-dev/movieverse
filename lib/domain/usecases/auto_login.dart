import 'package:movieverse/domain/repositories/firebase_repository.dart';

class AutoLogin {
  final FirebaseRepository firrebaseRepository;

  AutoLogin(this.firrebaseRepository);

  Future<bool> execute() {
    return firrebaseRepository.autoLogin();
  }
}
