// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:afljms/src/features/authentication/controllers/controller_employee_auth.dart';
import 'package:afljms/src/features/authentication/models/model_emp_auth.dart';
import 'package:afljms/src/features/authentication/models/model_user.dart';
import 'package:afljms/src/features/authentication/screens/user_pending_screen.dart';
import 'package:afljms/src/features/core/employee/employee_register_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../features/authentication/controllers/controller_user.dart';
import '../../features/authentication/screens/email_verification.dart';
import '../../features/authentication/screens/login_screen.dart';
import '../../features/authentication/screens/master_screen.dart';
import '../../features/authentication/screens/sign_up_screen.dart';
import '../../features/authentication/screens/splash_screen.dart';
import '../../features/authentication/screens/welcome_screen.dart';
import '../../features/core/incharge/incharge.dart';
import '../../utils/get_snackbar.dart';
import 'auth_exception.dart';

class AuthenticationBackEnd extends GetxController {
  static AuthenticationBackEnd get instance => Get.find();

  final _firebaseAuth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  User? currentUser;

  bool userIsActive = false;
  var empActive = false.obs;
  var empAuthorityActive = false.obs;

  final box = GetStorage();

  final _userController = Get.put(UserController());
  final _empAuthController = Get.put(EmployeeAuthorityController());

  List<EmployeeAuthorityModel> authorities = [];

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_firebaseAuth.currentUser);
    firebaseUser.bindStream(_firebaseAuth.userChanges());
    // ever(firebaseUser, setInitialScreen(firebaseUser.value));
    // Get.to(() => const EmailVerification());

    setInitialScreen(firebaseUser.value);
  }

  // getUpdatedPrivileges(User? user) {
  //   // USE GET_STORAGE() TO STORE USER Privileges
  //   box.write('userUID', user!.uid);
  //   box.write('privilege', user!.uid);
  //   box.write('userEmail', user!.email);
  //   box.write('userEmail', user!.email);
  // }

  setInitialScreen(User? user) async {
    // print('Logged in user is \n$user');

    if (user?.uid == 'oNnZgAboUhc4t7xD3bzfjGP7zr32') {
      // user is MASTER
      // print('user is Master');
      Get.offAll(() => const MasterScreen());
      return;
    } else if (user?.uid == 't9hEMybV5EMfCIYLuMj59uQxYlR2') {
      // print('user is SuperAdmin');
      // user is SuperAdmin
      // Get.offAll(() => const SuperAdminScreen());
      Get.offAll(() => const InchargeDashboard());
      return;
    } else if (user?.uid == 'q4S1UNEMQ1PNGLgnlLmUHDo5dpD3') {
      // print('user is Admin');
      // user is Admin
      Get.offAll(() => const InchargeDashboard());
      return;

      //
    } else if (user != null) {
      currentUser = user;

      if (user.emailVerified == false) {
        Get.offAll(() => const EmailVerification());
      } else {
        userIsActive = await _userController.checkUserStatus(user.uid);

        if (userIsActive == false) {
          Get.offAll(() => const UserPending());
        } else if (userIsActive == true) {
          Get.offAll(() => const EmployeeRegisterScreen());
        }

        //
      }

      //
    } else if (user == null) {
      print('user is NULL');
      Get.offAll(() => SplashScreen());
      // Get.offAll(() => const EmployeeAuthScreen());
      // Get.offAll(() => const EmployeeAuthorityAdd());
      // Get.offAll(() => const EmployeeRegisterScreen());

      // USER IS NONE OF ABOVE
    } else {
      print('else if');
      return;
    }
  }

  refreshScreen() {
    setInitialScreen(firebaseUser.value);
  }

// CREATE USER - WITH EMAIL AND PASSWORD
  Future<void> createUserWithEmailAndPassword(
      String email, String password, String empId) async {
    try {
      // try CREATING NEW AUTHENTICATION
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      //     .catchError((err) {
      //   print('Error: $err'); // Prints 401.
      //   SGSSnackbar.getSnackbarRed('Error',
      //       'Sign Up failed. Please contact support. \n Error message: $err');
      // });

      // navigate to...
      if (firebaseUser.value != null) {
        // print(firebaseUser.value?.uid);

        await createAUserDoc(empId);

        setInitialScreen(firebaseUser.value);
        // return "Success";
      }
    } on FirebaseAuthException catch (e) {
      // throw FIREBASE ERROR
      AuthException.showException(e.code);
      // print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      // rethrow;
    } catch (ee) {
      // throw UNKNOWN ERROR
      SGSSnackbar.getSnackbarRed('Error during signup',
          'An Unknown error occured. Please contact support. \n$ee');
      //  rethrow;
      // print('EXCEPTION - ${ex.message}');
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      // return "Success";
      setInitialScreen(firebaseUser.value);
    } on FirebaseAuthException catch (e) {
      // throw FIREBASE ERROR
      // final ex = AuthException.code(e.code);

      // print('FIREBASE AUTH EXCEPTION - ${ex.message} \n ${e.code}');
      // errorCode = ex.message;
      // print(e.code);
      AuthException.showException(e.code);
    } catch (ee) {
      SGSSnackbar.getSnackbarRed('Error during login',
          'An Unknown error ocurred. Please contact support. \n$ee');
    }
  }

  Future<void> sendEmailVerification() async {
    await _firebaseAuth.currentUser?.sendEmailVerification();
    setInitialScreen(firebaseUser.value);
    // try {
    // } on FirebaseAuthException catch (e) {
    //   // throw FIREBASE ERROR
    //   AuthException.showException(e.code);
    //   // print('FIREBASE AUTH EXCEPTION - ${ex.message}');
    //   // throw ex;
    // } catch (_) {
    //   // throw UNKNOWN ERROR
    //   AuthException.showException(
    //       'An Unknown error occorured. Please contact support.');
    //   // print('EXCEPTION - ${ex.message}');
    // }
  }

  Future<void> logout() async {
    // Get.offAll(() => const WelcomeScreen());
    _firebaseAuth.signOut();
    setInitialScreen(firebaseUser.value);
  }

  Future<void> createAUserDoc(String empId) async {
    UserModel _data = _userController.userObj;
    _data.uid = firebaseUser.value!.uid;
    _data.empId = empId;
    _data.email = firebaseUser.value!.email.toString();
    _data.active = false;

    await _userController.create(_data);
  }

  // we will not use PHONE authentication, because it is costly
  // Future<void> phoneAuthentication(String phoneNo) async {
  //   await _firebaseAuth.verifyPhoneNumber(
  //     phoneNumber: phoneNo,
  //     verificationCompleted: (credentials) async {
  //       await _firebaseAuth.signInWithCredential(credentials);
  //     },
  //     codeSent: (verificationId, resendToken) {
  //       this.phoneVerificationId.value = verificationId;
  //     },
  //     codeAutoRetrievalTimeout: (verificationId) {
  //       this.phoneVerificationId.value = verificationId;
  //     },
  //     verificationFailed: (e) {
  //       if (e.code == 'invalide-phone-number') {
  //         Get.snackbar('Error', 'Phone number is not valid.');
  //       } else {
  //         Get.snackbar('Error', 'Unknown error. Contact support person.');
  //       }
  //     },
  //   );
  // }

  // we will not use PHONE authentication/verification, because it is costly
  // Future<bool> verifyOTP(String otp) async {
  //   var credentials = await _firebaseAuth.signInWithCredential(
  //     PhoneAuthProvider.credential(
  //         verificationId: phoneVerificationId.value, smsCode: otp),
  //   );
  //   return credentials.user != null ? true : false;
  // }
}
