import 'package:movieverse/domain/repositories/shared_preference_repository.dart';

class SaveCredentials {
  final SharedPreferenceRepository sharedPreferenceRepository;

  SaveCredentials(this.sharedPreferenceRepository);

  Future<void> execute(String email, String password) {
    return sharedPreferenceRepository.saveCredentials(email, password);
  }
}
