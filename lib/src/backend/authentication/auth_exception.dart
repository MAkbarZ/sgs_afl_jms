import 'package:afljms/src/utils/get_snackbar.dart';

class AuthException {
  AuthException._();

  // final String message;

  // const AuthException([this.message = "An Unknown error occorured."]);

  // factory AuthException.code(String code) {
  static void showException(String code) {
    switch (code) {
      case 'week-password':
        // return const AuthException('Please enter a strong password.');
        SGSSnackbar.getSnackbarRed('Error', 'Please enter a strong password.');
        break;
      case 'wrong-password':
        SGSSnackbar.getSnackbarRed('Error', 'Please enter correct password.');
        break;
      case 'missing-password':
        SGSSnackbar.getSnackbarRed('Error', 'Please enter password.');
        break;
      case 'invalid-email':
        SGSSnackbar.getSnackbarRed(
            'Error', 'Email is not entered, is in-valid or badly formatted.');
        break;
      case 'invalid-credential':
        SGSSnackbar.getSnackbarRed(
            'Error', 'Please enter correct Email or Password.');
        break;
      case 'email-already-in-use':
        SGSSnackbar.getSnackbarRed(
            'Error', 'An account already exist for this email.');
        break;
      case 'operation-not-allowed':
        SGSSnackbar.getSnackbarRed('Error', 'Operation is not allowed.');
        break;
      case 'user-disabled':
        SGSSnackbar.getSnackbarRed(
            'Error', 'This user has been disabled. Please contact support.');
        break;
      case 'user-not-found':
        SGSSnackbar.getSnackbarRed(
            'Error', 'This user has could not be found. Please register.');
        break;

      case 'unknown':
        SGSSnackbar.getSnackbarRed('Error',
            'The supplied auth credential is incorrect, malformed or has expired.');
        break;
      default:
        // return const AuthException(;

        SGSSnackbar.getSnackbarRed('Error', 'Error occurred: \n$code');
        break;
    }
  }

  //
}
