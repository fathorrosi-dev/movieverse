abstract class SharedPreferenceRepository {
  Future<String?> getEmail();
  Future<String?> getPassword();
  Future<void> saveCredentials(String email, String password);
  Future<bool> getOnboardingComplete();
  Future<void> saveOnboardingComplete();
}
