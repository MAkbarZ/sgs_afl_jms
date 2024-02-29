import 'dart:async';

import 'package:afljms/src/backend/authentication/authentication_backend.dart';
import 'package:afljms/src/utils/get_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmailVerifyController extends GetxController {
  // late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    sendVerificationEmail();
    setTimeForAutoRedirect();
  }

  Future<void> sendVerificationEmail() async {
    // print('sent email verfi. link');
    try {
      await AuthenticationBackEnd.instance.sendEmailVerification();
    } catch (e) {
      // Helper.errorSnackBar(title: 'On Snap', message: e.toString());
    }
  }

  void setTimeForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      // Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser!.emailVerified) {
        timer.cancel();
        AuthenticationBackEnd.instance.setInitialScreen(currentUser);
      }
    });
  }

  void manuallyCheckEmailVerificationStatus() {
    SGSSnackbar.getSnackbarGreen(
        'Signup Success', 'You are now re-directed to next step');
  }
}
