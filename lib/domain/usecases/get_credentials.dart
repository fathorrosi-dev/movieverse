import 'package:movieverse/domain/repositories/shared_preference_repository.dart';

class GetCredentials {
  final SharedPreferenceRepository sharedPreferenceRepository;

  GetCredentials(this.sharedPreferenceRepository);

  Future<String?> getEmail() {
    return sharedPreferenceRepository.getEmail();
  }

  Future<String?> getPassword() {
    return sharedPreferenceRepository.getPassword();
  }
}
