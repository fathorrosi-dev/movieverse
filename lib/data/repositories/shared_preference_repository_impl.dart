import 'package:movieverse/data/datasources/localDataSource/shared_preference_helper.dart';
import 'package:movieverse/domain/repositories/shared_preference_repository.dart';

class SharedPreferenceRepositoryImpl implements SharedPreferenceRepository {
  final SharedPreferenceHelper sharedPreferenceHelper;

  SharedPreferenceRepositoryImpl({required this.sharedPreferenceHelper});

  @override
  Future<void> saveOnboardingComplete() {
    return sharedPreferenceHelper.saveOnboardingComplete();
  }

  @override
  Future<bool> getOnboardingComplete() {
    return sharedPreferenceHelper.getOnboardingComplete();
  }

  @override
  Future<String?> getEmail() {
    return sharedPreferenceHelper.getEmail();
  }

  @override
  Future<String?> getPassword() {
    return sharedPreferenceHelper.getPassword();
  }

  @override
  Future<void> saveCredentials(String email, String password) async {
    await sharedPreferenceHelper.setEmail(email);
    await sharedPreferenceHelper.setPassword(password);
  }
}
