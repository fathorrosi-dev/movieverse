import 'package:movieverse/domain/repositories/shared_preference_repository.dart';

class SetOnBoardingStatus {
  final SharedPreferenceRepository sharedPreferenceRepository;

  SetOnBoardingStatus(this.sharedPreferenceRepository);

  Future<void> execute() {
    return sharedPreferenceRepository.saveOnboardingComplete();
  }
}
