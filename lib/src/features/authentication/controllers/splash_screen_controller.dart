import 'dart:async';
import 'package:get/get.dart';
import '../screens/welcome_screen.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  RxBool isSplashStart = false.obs;
  var countDown = 5.obs;

  // late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    setCountdown();
  }

  Future startSplash() async {
    await Future.delayed(const Duration(milliseconds: 500));
    isSplashStart.value = true;
    await Future.delayed(const Duration(milliseconds: 5000));
    Get.offAll(() => const WelcomeScreen());
  }

  void setCountdown() {
    // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countDown.value >= 0) {
        countDown.value--;
        // print(countDown);
      } else {
        timer.cancel();
      }
    });
  }
}
