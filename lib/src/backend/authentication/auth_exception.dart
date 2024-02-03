class AuthException {
  AuthException._();

  // final String message;

  // const AuthException([this.message = "An Unknown error occorured."]);

  // factory AuthException.code(String code) {
  static String showException(String code) {
    switch (code) {
      case 'week-password':
        // return const AuthException('Please enter a strong password.');
        return 'Please enter a strong password.';

      case 'missing-password':
        return 'Please enter password.';

      case 'invalid-email':
        return 'Email is not entered, is in-valid or badly formatted.';

      case 'invalid-credential':
        return 'Please enter correct Email or Password.';

      case 'email-already-in-use':
        return 'An account already exist for this email.';

      case 'operation-not-allowed':
        return 'Operation is not allowed.';

      case 'user-disabled':
        return 'This user has been disabled. Please contact support.';

      default:
        // return const AuthException(;
        return code;
    }
  }

  //
}
