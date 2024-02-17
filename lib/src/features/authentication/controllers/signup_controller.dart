import 'package:get/get.dart';

import '../../../backend/authentication/authentication_backend.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationBackEnd());

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
    // try {
    await _authRepo.createUserWithEmailAndPassword(
      email,
      password,
    );
    // } catch (e) {
    //   SGSSnackbar.getSnackbarRed('Error',
    //       'Could not sign In. Please contact support. \n Error message: ${e.toString()}');
    // }
  }

// REGISTER - PHONE NUMBER
  // void registerUserWithPhone(String phoneNo) {
  //   _authRepo.phoneAuthentication(phoneNo);
  // }

// // LOGOUT
  void logout() {
    _authRepo.logout();
  }

//
}
