import 'package:afljms/src/backend/authentication/authentication_backend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/widget_theme/text_theme.dart';
import '../controllers/email_verify_controller.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    // variables
    final emailVerifyController = Get.put(EmailVerifyController());
    final screenWidth = MediaQuery.of(context).size.width;

    //Scaffold
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Container(
          padding: const EdgeInsets.only(
              top: 30.0, left: 30.0, right: 30.0, bottom: 30.0 * 2),
          width: screenWidth <= 300.0 ? double.infinity : 350.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.drafts_outlined,
                size: screenWidth <= 300.0 ? 60.0 : 100.0,
              ),
              const SizedBox(height: 10.0),
              Text(
                'Verify your email address',
                style: SGSTextTheme.titleStyle20,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              Text(
                // 'We have just send an email verification link to your email. Please check and click on the link to verify your email address. If not auto redirected after verification, click on the "Continue" button',
                'Please verify you email by checking your email inbox/junk folder and click on the link provided. \n You will be auto redirected to dashboard. \n If not, click on below button to continue',
                style: SGSTextTheme.normalStyle13,
                textAlign: TextAlign.center,
              ),
              // const SizedBox(height: 30.0),
              // SizedBox(
              //   width: 200,
              //   child: OutlinedButton(
              //     child: const Text('Continue'),
              //     onPressed: () => emailVerifyController
              //         .manuallyCheckEmailVerificationStatus(),
              //   ),
              // ),
              // const SizedBox(height: 30.0),
              // TextButton(
              //   onPressed: () => emailVerifyController.sendVerificationEmail(),
              //   child: const Text('Resend Email Link'),
              // ),
              // const SizedBox(height: 20.0),
              // TextButton(
              //   onPressed: () => AuthenticationBackEnd.instance.logout(),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       const Icon(Icons.navigate_before),
              //       const SizedBox(width: 5),
              //       Text('back to login'.tr.toLowerCase()),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      )),
    );
  }
}
