class Validator {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? validatePasswordConfirm(
      String? password, String? passwordConfirm) {
    if (passwordConfirm == null || passwordConfirm.isEmpty) {
      return 'Password confirmation is required';
    }
    if (passwordConfirm != password) {
      return 'Password confirmation does not match';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!isEmailValid(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static bool isEmailValid(String value) {
    // Simple email validation using regex
    const regex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final match = RegExp(regex).hasMatch(value);
    return match;
  }
}
