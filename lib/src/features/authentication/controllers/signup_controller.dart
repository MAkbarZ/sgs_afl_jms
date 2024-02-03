import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../backend/authentication/authentication_backend.dart';
import '../../../utils/get_snackbar.dart';
import '../models/user_model.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationBackEnd());
  // final _userRepo = Get.put(UserRepository());

  // INPUT TEXT CONTROLLERS
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // togle
  // void toggleShowHidePassword() {
  //   showPassword.value = !showPassword.value;
  //   // update();
  // }

// // REGISTER - EMAIL and PASSWORD
//   void registerUser(String email, String password) {
//     _authRepo.createUserWithEmailAndPassword(
//       emailController.text.trim(),
//       passwordController.text.trim(),
//     );
//   }

  bool validateBeforeContinue() {
    if (!signupFormKey.currentState!.validate()) {
      // print(
      //     ' Full Name: ${fullNameController.text.trim()} \n Mobile : ${phoneNoController.text.trim()}'); // \n ' +
      // 'Email: ${emailController.text.trim()} \n password ${passwordController.text.trim()}');
      return false;
    } else {
      return true;
    }
  }

  Future<void> registerAndCreateUser() async {
    // validateBeforeContinue();
    try {
      await _authRepo.createUserWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      final UserModel user;
      // final user = UserModel(
      // fullName: fullNameController.text.trim(),
      // email: emailController.text.trim(),
      // phoneNo: phoneNoController.text.trim(),
      // password: passwordController.text.trim(),
      // userDbRole: 'unknown',
      // );

      // print(user);
      // await _userRepo.createUser(user);
      //get current user
      // print(_authRepo.firebaseUser.value);

      _authRepo.setInitialScreen(FirebaseAuth.instance.currentUser);
    } catch (e) {
      SGSSnackbar.getSnackbarRed('Error',
          'Could not sign In. Please contact support. \n Error message: ${e.toString()}');
    }
  }

// REGISTER - PHONE NUMBER
  // void registerUserWithPhone(String phoneNo) {
  //   _authRepo.phoneAuthentication(phoneNo);
  // }

// LOGOUT
  void logout() {
    _authRepo.logout();
  }

//
}
