import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/widget_theme/text_theme.dart';
import '../controllers/controller_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  final splashScreenController = Get.put(SplashScreenController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;

    // double fontSize;

    splashScreenController.startSplash();

    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
                image: AssetImage("assets/images/sgs_logo.png"), width: 200.0),
            const SizedBox(height: 20.0),
            Text(
              'SGS Pakistan - AFL',
              textAlign: TextAlign.center,
              style: SGSTextTheme.normalStyle13,
            ),
            const SizedBox(height: 30.0),
            Text(
              'JOB MANAGEMENT SYSTEM',
              textAlign: TextAlign.center,
              style: SGSTextTheme.titleStyle15,
            ),
            const SizedBox(height: 50.0),
            const Text(
              'Digital Innovation is already here...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 15.0,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 30.0),
            Obx(
              () => Text(
                'starting in ${splashScreenController.countDown.value}',
                textAlign: TextAlign.center,
                style: SGSTextTheme.normalStyle13
                    .copyWith(fontSize: 8.0, color: Colors.grey.shade200),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
