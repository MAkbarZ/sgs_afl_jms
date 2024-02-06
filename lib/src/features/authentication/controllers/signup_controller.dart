import 'package:afljms/src/features/core/hr/models/staff_model.dart';
import 'package:afljms/src/features/core/hr/staff_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../backend/authentication/authentication_backend.dart';
import '../../../utils/get_snackbar.dart';
import '../../core/incharge/controllers/afl_division_controller.dart';
import '../../core/incharge/controllers/afl_function_controller.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationBackEnd());
  final _aflDivController = Get.put(AFLDivisionController());
  final _aflFunctionController = Get.put(AFLFunctionController());
  final _staffController = Get.put(StaffController());
  // final _userRepo = Get.put(UserRepository());

  // INPUT TEXT CONTROLLERS
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController employeeApproverEmpIDController =
      TextEditingController();
  TextEditingController userApproverEmpIDController = TextEditingController();

  TextEditingController aflDivisionController = TextEditingController();
  TextEditingController aflFunctionController = TextEditingController();
  TextEditingController dbRoleController = TextEditingController();
  TextEditingController authorityApproverEmpIDController =
      TextEditingController();

  // INPUT VARIABLES,, if could not be done throught controllers
  bool employeeActive = false;
  bool userIsVerified = false;
  bool userActive = false;
  bool authorityActive = false;
  int hireDate = 0;

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

  // bool validateBeforeContinue() {
  //   if (!signupFormKey.currentState!.validate()) {
  //     // print(
  //     //     ' Full Name: ${fullNameController.text.trim()} \n Mobile : ${phoneNoController.text.trim()}'); // \n ' +
  //     // 'Email: ${emailController.text.trim()} \n password ${passwordController.text.trim()}');
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  Future<void> registerAndCreateUser() async {
    // validateBeforeContinue();
    try {
      await _authRepo.createUserWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      // final UserModel user;
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

  Future<QuerySnapshot<Map<String, dynamic>>> getActiveAFLDivisions() async {
    return await _aflDivController.getActiveAFLDivisions();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getActiveAFLFunctions() async {
    return await _aflFunctionController.getActiveAFLFunctions();
  }

  Future<void> createStaff() async {
    StaffModel staff = StaffModel(
        empId: employeeIdController.text.trim(),
        fullName: fullNameController.text.trim(),
        hiredDate: hireDate,
        email: emailController.text.trim(),
        mobile: mobileController.text.trim(),
        phone: phoneNoController.text.trim(),
        gender: genderController.text.trim(),
        approverEmpId: '0',
        active: false);
    print(staff);
    // _staffController.create(staff);
  }

// // LOGOUT
//   void logout() {
//     _authRepo.logout();
//   }

//
}
