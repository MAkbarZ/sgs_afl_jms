import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common_widgets/input_field.dart';
import '../../../theme/widget_theme/text_theme.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.put(LoginController());
    // _loginController.printCurrentlyLoggedInUser();
    final screenWidth = MediaQuery.of(context).size.width;
    // return const ResponsiveLayout(
    //   mobileScaffold: LoginScreenMobile(),
    //   tabletScaffold: LoginScreenTablet(),
    //   desktopScaffold:
    //       LoginScreenTablet(), // showing tablet mode in desktop as well
    // );
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              // width: double.infinity,
              width: screenWidth <= 300.0 ? double.infinity : 350.0,
              // color: const Color.fromARGB(255, 255, 228, 148),
              color: Colors.white,
              // Master Column
              child: Column(children: [
                // Logo and Page title
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage("assets/images/sgs_logo.png"),
                      width: 150.0,
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'LOGIN',
                      textAlign: TextAlign.center,
                      style: SGSTextTheme.titleStyle20,
                    ),
                    const SizedBox(height: 20.0),
                    // LoginFooterWidget()
                  ],
                ),

                // FORM CONTROLS
                // const LoginFormWidget(),
                Form(
                  key: _loginController.loginFormKey,
                  child: SizedBox(
                    width: double.infinity,
                    // color: Colors.black54,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SGSInputField(
                            title: 'Email',
                            hint: 'Enter your email',
                            maxLength: 25,
                            textEditingController:
                                _loginController.emailController,
                            isObscure: false,
                            readonly: false,
                            // onChanged: (value) {
                            //   if (Validator().isEmpty(value)) {
                            //     return 'Please enter your email address';
                            //   }

                            //   if (Validator().isEmail(value)) {
                            //     return 'Please enter correctly formatted Email';
                            //   }
                            //   return null;
                            // },
                          ),
                          const SizedBox(height: 15.0),
                          SGSInputField(
                            title: 'Password',
                            hint: 'Enter your password',
                            readonly: false,
                            maxLength: 20,
                            textEditingController:
                                _loginController.passwordController,
                            isObscure: hidePassword,
                            suffixIcon: IconButton(
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 15.0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                }),
                          ),
                          const SizedBox(height: 15.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                                _loginController.login();
                              },
                              child: const Text('Login'),
                            ),
                          ),
                          const SizedBox(height: 15.0),
                        ]),
                  ),
                ),

                // end of master column
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

// Input controls
