import 'dart:async';

import 'package:afljms/src/backend/authentication/authentication_backend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'controller_user.dart';

class UserPendingController extends GetxController {
  final _userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    // checkUserStatus();
    setTimeForAutoRedirect();
  }

  setTimeForAutoRedirect() {
    FirebaseAuth.instance.currentUser?.reload();

    Timer.periodic(const Duration(seconds: 3), (timer) {
      final currentUser = FirebaseAuth.instance.currentUser;
      _userController.checkUserStatus(currentUser!.uid).then((value) => {
            if (value)
              {
                timer.cancel(),
                AuthenticationBackEnd.instance.setInitialScreen(currentUser)
              }
          });
    });
  }
}
