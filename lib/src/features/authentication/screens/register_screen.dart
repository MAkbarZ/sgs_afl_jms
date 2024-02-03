import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common_widgets/input_field.dart';
import '../../../theme/widget_theme/text_theme.dart';
import '../../../utils/text_input_validator.dart';
import '../controllers/signup_controller.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    SignUpController _signUpController = Get.put(SignUpController());

    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(30.0),
              width: screenWidth <= 300.0 ? double.infinity : 350.0,
              color: Colors.white,

              // Master Column
              child: Column(children: [
                const Image(
                  image: AssetImage("assets/images/sgs_logo.png"),
                  width: 150.0,
                ),
                const SizedBox(height: 15.0),
                Text(
                  'SIGN UP',
                  textAlign: TextAlign.center,
                  style: SGSTextTheme.titleStyle20,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'and, start your journey with SGS...',
                  textAlign: TextAlign.center,
                  style: SGSTextTheme.normalStyle13,
                ),
                const SizedBox(height: 20.0),
                // SignUpFormWidget(),
                // LoginFooterWidget()

                // FORM CONTROLS
                Form(
                  key: _signUpController.signupFormKey,
                  child: SizedBox(
                    width: double.infinity,
                    // color: Colors.black54,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SGSInputField(
                            title: 'Full Name',
                            hint: 'Enter your full name',
                            isObscure: false,
                            readonly: false,
                            maxLength: 25,
                            textEditingController:
                                _signUpController.fullNameController,
                            // isObscure: false,
                            validator: (value) {
                              // if (Validator().isEmpty(value)) {
                              //   return 'Please enter your full name';
                              // }

                              if (Validator().isAlphabates(value)) {
                                return 'Name must be in engish alphabates';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 1.0),
                          SGSInputField(
                            title: 'Mobile No.',
                            hint: 'Enter your Mobile No. e.g. 03001234567',
                            maxLength: 15,
                            isObscure: false,
                            readonly: false,
                            textEditingController:
                                _signUpController.phoneNoController,
                            // isObscure: false,
                            validator: (value) {
                              if (Validator().isEmpty(value)) {
                                return 'Please enter your Mobile No.';
                              }

                              if (Validator().isPhoneNumber(value)) {
                                return 'Enter 11 numerical digits, only';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 1.0),
                          SGSInputField(
                            title: 'Email',
                            hint: 'Enter your email',
                            readonly: false,
                            isObscure: false,
                            maxLength: 25,
                            textEditingController:
                                _signUpController.emailController,
                            // isObscure: false,
                            validator: (value) {
                              if (Validator().isEmpty(value)) {
                                return 'Please enter your email address';
                              }

                              if (Validator().isEmail(value)) {
                                return 'Please enter correctly formatted Email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 1.0),
                          SGSInputField(
                            title: 'Password',
                            hint: 'Enter your password',
                            maxLength: 20,
                            readonly: false,
                            textEditingController:
                                _signUpController.passwordController,
                            isObscure: hidePassword,
                            validator: (value) {
                              if (Validator().isEmpty(value)) {
                                return 'Please enter your password';
                              }

                              if (Validator().isPassword(value)) {
                                return 'Password must be at least 6 characters.';
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 15.0,
                                ),
                                // onPressed: () => _signUpController.toggleShowHidePassword(),
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

                                if (_signUpController
                                    .validateBeforeContinue()) {
                                  _signUpController.registerAndCreateUser();
                                } else {
                                  // print('input is wrongly entered.');
                                  return;
                                }
                                // return null;
                                // _signUpController.signIn2();
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');

                                // return null;
                                // _signUpController.login();
                                Get.to(() => const LoginScreen());
                              },
                              child: const Text('Login'),
                            ),
                          ),
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
