import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/widget_theme/text_theme.dart';
import '../controllers/controller_user_pending.dart';

class UserPending extends StatefulWidget {
  const UserPending({super.key});

  @override
  State<UserPending> createState() => _UserPendingState();
}

class _UserPendingState extends State<UserPending> {
  @override
  Widget build(BuildContext context) {
    // variables
    final userPendingController = Get.put(UserPendingController());
    // final _authRepo = Get.put(AuthenticationBackEnd());
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
                'Your user account has not been approved.\nPlease contact the administrator.',
                style: SGSTextTheme.titleStyle20,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30.0),

              // Obx(
              //   () => Text(
              //     // 'We have just send an email verification link to your email. Please check and click on the link to verify your email address. If not auto redirected after verification, click on the "Continue" button',
              //     // 'User status is ${_authRepo.userActive.value} \nEmployee status is ${_authRepo.empActive.value} \nAuthority status is ${_authRepo.empAuthorityActive.value}',
              //     'User status is ${_authRepo.userActive.value}.',
              //     style: SGSTextTheme.normalStyle13,
              //     textAlign: TextAlign.start,
              //   ),
              // ),
            ],
          ),
        ),
      )),
    );
  }
}
