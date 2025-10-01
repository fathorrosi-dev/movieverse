import 'package:movieverse/domain/repositories/shared_preference_repository.dart';

class CheckOnboardingStatus {
  final SharedPreferenceRepository sharedPreferenceRepository;

  CheckOnboardingStatus(this.sharedPreferenceRepository);

  Future<bool> execute() {
    return sharedPreferenceRepository.getOnboardingComplete();
  }
}
