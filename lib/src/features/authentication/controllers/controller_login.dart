import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/authentication/authentication_backend.dart';

class LoginController extends GetxController {
  // VARIABLES
  final _authRepo = Get.put(AuthenticationBackEnd());
  // final _userRepo = Get.put(UserRepository());

  final inputErrorText = ''.obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

// INPUT TEXT CONTROLLERS
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // TextEditingController fullNameController = TextEditingController();
  // TextEditingController phoneNoController = TextEditingController();

  bool validateForm() {
    if (loginFormKey.currentState!.validate()) {
      // print('form is ${loginFormKey.currentState!.validate()}');
      // print('email is ${emailController.text.trim()}');

      // if (Validator().isEmpty(emailController.text.trim())) {
      //   SGSSnackbar.getSnackbarRed('Error', 'Please enter an Email');
      //   return false;
      // }

      // if (Validator().isEmpty(passwordController.text.trim())) {
      //   SGSSnackbar.getSnackbarRed('Error', 'Please enter an Password');
      //   return false;
      // }

      // if (Validator().isEmail(emailController.text.trim())) {
      //   SGSSnackbar.getSnackbarRed(
      //       'Error', 'Email is not in proper format, or, is invalid.');
      //   return false;
      // }

      // if (Validator().isPassword(passwordController.text.trim())) {
      //   SGSSnackbar.getSnackbarRed(
      //       'Error', 'Password must be at least 6 characters.');

      //   return false;
      // }

      // validation complete.
      // All above objections are cleared. Good to go.
    }
    // print('form is after ${loginFormKey.currentState!.validate()}');
    // below must return true,,, otherwise, form is still invalid and need to re-check the above code.
    return loginFormKey.currentState!.validate();
  }

  // LOGIN
  void login() {
    if (validateForm()) {
      _authRepo.loginUserWithEmailAndPassword(
          emailController.text.trim(), passwordController.text.trim());
    }
  }

  // void printCurrentlyLoggedInUser() {
  //   print(_authRepo.firebaseUser.value);
  // }

//
}
