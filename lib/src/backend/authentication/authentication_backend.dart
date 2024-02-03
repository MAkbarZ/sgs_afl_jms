import 'package:afljms/src/features/authentication/screens/register_screen.dart';
import 'package:afljms/src/utils/get_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../features/authentication/screens/email_verification.dart';
import '../../features/authentication/screens/login_screen.dart';
import '../../features/authentication/screens/splash_screen.dart';
import '../../features/core/incharge/incharge.dart';
import 'auth_exception.dart';

class AuthenticationBackEnd extends GetxController {
  static AuthenticationBackEnd get instance => Get.find();
  // VARIABLES
  final _firebaseAuth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  // var phoneVerificationId = ''.obs;
  String errorCode = '';

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_firebaseAuth.currentUser);
    firebaseUser.bindStream(_firebaseAuth.userChanges());
    // ever(firebaseUser, setInitialScreen(firebaseUser.value));
    // Get.to(() => const EmailVerification());
    setInitialScreen(firebaseUser.value);
  }

  setInitialScreen(User? user, {String? section}) {
    Get.to(() => const RegisterScreen());
    print(user);
    if (user == null) {
      Get.to(() => SplashScreen());
      // Get.to(() => const SignUpScreen());
    }

    if (user != null && user.email == 'm.akbar6@outlook.com') {
      //  ||  user.email == 'incharge@sgs.com') {
      // print('user is incharge');
      Get.off(() => const InchargeDashboard());
      // Get.offAll(() => const DashboardScreen(
      //       title: 'Dashboard',
      //     ));
      // Get.offAll(() => const CRUDMain());
      // Get.to(() => const LoginScreen());
    }

    // if (user != null && user.emailVerified) {
    //   // get user's role
    //   // and
    //   // redirect user to specific Dashboard...
    //   // print('user is verified. !!!');
    //   Get.offAll(() => const BDDashboard());
    //   // Get.offAll(() => const Dashboard());

    //   // if user has logged in but email IS NOT verified
    //   // go to Splash Screen
    // }

    if (user != null && !user.emailVerified) {
      Get.offAll(() => const EmailVerification());
    }
  }

// CREATE USER - WITH EMAIL AND PASSWORD
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      // try CREATING NEW AUTHENTICATION
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      // navigate to...
      if (firebaseUser.value != null) {
        // print(firebaseUser.value?.uid);
        //
        setInitialScreen(firebaseUser.value);
        return "Success";
      }
      return "no success";
    } on FirebaseAuthException catch (e) {
      // throw FIREBASE ERROR
      return AuthException.showException(e.code);
      // print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      // rethrow;
    } catch (_) {
      // throw UNKNOWN ERROR
      return AuthException.showException(
          'An Unknown error occorured. Please contact support.');
      //  rethrow;
      // print('EXCEPTION - ${ex.message}');
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // return "Success";
      setInitialScreen(firebaseUser.value);
    } on FirebaseAuthException catch (e) {
      // throw FIREBASE ERROR
      // final ex = AuthException.code(e.code);

      // print('FIREBASE AUTH EXCEPTION - ${ex.message} \n ${e.code}');
      // errorCode = ex.message;

      SGSSnackbar.getSnackbarRed("Error", AuthException.showException(e.code));
    } catch (_) {
      SGSSnackbar.getSnackbarRed(
          "Error",
          AuthException.showException(
              'An Unknown error occorured. Please contact support.'));
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _firebaseAuth.currentUser?.sendEmailVerification();
      setInitialScreen(firebaseUser.value);
    } on FirebaseAuthException catch (e) {
      // throw FIREBASE ERROR
      SGSSnackbar.getSnackbarRed("Error", AuthException.showException(e.code));
      // print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      // throw ex;
    } catch (_) {
      // throw UNKNOWN ERROR
      SGSSnackbar.getSnackbarRed(
          "Error",
          AuthException.showException(
              'An Unknown error occorured. Please contact support.'));
      // print('EXCEPTION - ${ex.message}');
    }
  }

  Future<void> logout() async {
    // Get.offAll(() => const WelcomeScreen());
    _firebaseAuth.signOut();
    setInitialScreen(firebaseUser.value);
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
