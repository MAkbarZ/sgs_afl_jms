import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common_widgets/input_field.dart';
import '../../../theme/widget_theme/text_theme.dart';
import '../../../utils/text_input_validator.dart';
import '../controllers/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _controller = Get.put(SignUpController());

  bool _hidePassword = true;

  String m_email = '';
  String m_password = '';

  bool _IsEmptyEmail = true;
  bool _EmailOK = false;

  bool _IsEmptyPassword = true;
  bool _PasswordOK = false;

  final double _defaultInputWidth = 300.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              logoAndHeader,

              //body
              Center(
                child: Container(
                  padding: const EdgeInsets.all(30.0),
                  width: screenWidth <= 300.0 ? double.infinity : 350.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email
                      const SizedBox(height: 5.0),
                      SGSInputField(
                          title: 'Email ID',
                          hint: 'Enter your email (without "@sgs.com")',
                          readonly: false,
                          isObscure: false,
                          maxLength: 20,
                          width: _defaultInputWidth,
                          // textEditingController:
                          //     _signUpController
                          //         .emailController,

                          // validator: (value) {
                          //   if (Validator().isEmpty(value)) {
                          //     return 'Please enter your email address';
                          //   }

                          //   if (Validator().isEmail(value)) {
                          //     return 'Please enter correctly formatted Email';
                          //   }
                          //   return null;
                          // },
                          onChanged: (textValue) {
                            setState(() {
                              if (textValue.trim() != "") {
                                setState(() {
                                  _IsEmptyEmail = false;
                                  _EmailOK = Validator().isEmail(textValue);

                                  if (_IsEmptyEmail == false &&
                                      _EmailOK == true) {
                                    m_email = textValue;
                                  } else {
                                    m_email = '';
                                  }
                                });
                              } else {
                                setState(() => _IsEmptyEmail = true);
                                return;
                              }
                            });
                          }),
                      _IsEmptyEmail
                          ? Text("Please enter your Email address.",
                              style: warningTextStyle)
                          : _EmailOK == false
                              ? Text('Please enter correctly formatted Email',
                                  style: warningTextStyle)
                              : Container(),

                      // PASSWORD
                      const SizedBox(height: 5.0),
                      SGSInputField(
                          title: 'Password',
                          hint: 'Enter your password',
                          maxLength: 20,
                          width: _defaultInputWidth,
                          readonly: false,
                          // textEditingController:
                          //     _signUpController
                          //         .passwordController,
                          isObscure: _hidePassword,
                          // validator: (value) {
                          //   if (Validator().isEmpty(value)) {
                          //     return 'Please enter your password';
                          //   }

                          //   if (Validator()
                          //       .isPassword(value)) {
                          //     return 'Password must be at least 6 characters.';
                          //   }
                          //   return null;
                          // },
                          suffixIcon: IconButton(
                              icon: Icon(
                                _hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 15.0,
                                color: Colors.grey,
                              ),
                              // onPressed: () => _signUpController.toggleShowHidePassword(),
                              onPressed: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              }),
                          onChanged: (textValue) {
                            setState(() {
                              if (textValue.trim() != "") {
                                setState(() {
                                  _IsEmptyPassword = false;
                                  _PasswordOK =
                                      Validator().isPassword(textValue);
                                  if (_IsEmptyPassword == false &&
                                      _PasswordOK == true) {
                                    m_password = textValue;
                                  } else {
                                    m_password = '';
                                  }
                                });
                              } else {
                                setState(() => _IsEmptyPassword = true);
                                return;
                              }
                            });
                          }),
                      _IsEmptyPassword
                          ? Text("Please enter your Password.",
                              style: warningTextStyle)
                          : _PasswordOK == false
                              ? Text('Password must be at least 6 characters.',
                                  style: warningTextStyle)
                              : Container(),

                      // SUBMIT BUTTON
                      Container(
                        margin: const EdgeInsets.only(top: 30.0),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');

                            if (isInputDataOK()) {
                              _controller.signUp('${m_email.trim()}@sgs.com',
                                  m_password.trim());
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // METHODS

  bool isInputDataOK() {
    if (_IsEmptyEmail == false &&
        _EmailOK == true &&
        _IsEmptyPassword == false &&
        _PasswordOK == true) {
      return true;
    } else {
      return false;
    }
  }

  // VARIABLES

  TextStyle warningTextStyle =
      const TextStyle(color: Colors.red, fontSize: 9.0);

  var logoAndHeader = Container(
    padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
    margin: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Image(
          image: AssetImage("assets/images/sgs_logo.png"),
          width: 100.0,
        ),
        const SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SIGN UP',
              textAlign: TextAlign.start,
              style: SGSTextTheme.titleStyle20,
            ),
            // const SizedBox(height: 10.0),
            Text(
              "Let's start...",
              textAlign: TextAlign.start,
              style: SGSTextTheme.normalStyle13,
            ),
          ],
        ),
      ],
    ),
  );

//
}
