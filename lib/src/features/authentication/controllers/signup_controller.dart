import 'package:afljms/src/features/core/hr/staff_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../backend/authentication/authentication_backend.dart';
import '../../../utils/get_snackbar.dart';
import '../../core/incharge/controllers/afl_division_controller.dart';
import '../../core/incharge/controllers/afl_function_controller.dart';
import 'staff_authority_controller.dart';
import 'user_controller.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationBackEnd());
  final _aflDivController = Get.put(AFLDivisionController());
  final _aflFunctionController = Get.put(AFLFunctionController());
  final _staffController = Get.put(StaffController());
  final _staffAuthorityController = Get.put(StaffAuthorityController());
  final _userController = Get.put(UserController());
  // final _userRepo = Get.put(UserRepository());

  // INPUT TEXT CONTROLLERS
  // TextEditingController employeeIdController = TextEditingController();
  // TextEditingController genderController = TextEditingController();
  // TextEditingController fullNameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController phoneNoController = TextEditingController();
  // TextEditingController mobileController = TextEditingController();
  // TextEditingController employeeApproverEmpIDController =
  //     TextEditingController();
  // TextEditingController userApproverEmpIDController = TextEditingController();

  // TextEditingController aflDivisionController = TextEditingController();
  // TextEditingController aflFunctionController = TextEditingController();
  // TextEditingController dbRoleController = TextEditingController();
  // TextEditingController authorityApproverEmpIDController =
  //     TextEditingController();

  // INPUT VARIABLES,, if could not be done throught controllers
  // bool employeeActive = false;
  // bool userIsVerified = false;
  // bool userActive = false;
  // bool authorityActive = false;
  // int hireDate = 0;

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

  Future<void> signUp(String email, String password) async {
    // validateBeforeContinue();
    try {
      await _authRepo.createUserWithEmailAndPassword(
        email,
        password,
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
      print(_authRepo.firebaseUser.value);

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

  Future<void> createStaff(Map<String, dynamic> dataStaff) async {
    await _staffController.create(dataStaff);
  }

  Future<void> createUser(Map<String, dynamic> dataUser) async {
    await _userController.create(dataUser);
  }

  Future<void> createAuthority(Map<String, dynamic> dataAuthority) async {
    await _staffAuthorityController.create(dataAuthority);
  }

// // LOGOUT
  void logout() {
    _authRepo.logout();
  }

//
}
