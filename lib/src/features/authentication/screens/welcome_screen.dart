import 'package:afljms/src/features/authentication/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/widget_theme/text_theme.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          color: Colors.white,
          // width: screenWidth,
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/images/sgs_logo.png"),
                width: 200.0,
              ),
              const SizedBox(height: 15.0),
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
              const SizedBox(height: 10.0),
              Text(
                'Choose your way,,, in',
                textAlign: TextAlign.center,
                style: SGSTextTheme.normalStyle13,
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: 300.0,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const SignUpScreen());
                        },
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

// end of build
  }
}
