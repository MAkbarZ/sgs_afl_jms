import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common_widgets/input_field.dart';
import '../../../theme/widget_theme/text_theme.dart';
import '../../../utils/text_input_validator.dart';
import '../controllers/controller_signup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _controller = Get.put(SignUpController());

  bool _hidePassword = true;

  String _empId = '';
  String _email = '';
  String _password = '';

  bool _isEmptyEmpId = true;
  bool _empIdOK = false;

  bool _isEmptyEmail = true;
  bool _emailOK = false;

  bool _isEmptyPassword = true;
  bool _passwordOK = false;

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
                      // Employee ID
                      const SizedBox(height: 5.0),
                      SGSInputField(
                          title: 'Employee ID',
                          hint: 'e.g. 2075',
                          readonly: false,
                          isObscure: false,
                          maxLength: 10,
                          width: _defaultInputWidth,
                          onChanged: (textValue) {
                            setState(() {
                              if (textValue.trim() != "") {
                                setState(() {
                                  _isEmptyEmpId = false;
                                  _empIdOK =
                                      Validator().isEmployeeID(textValue);

                                  if (_isEmptyEmpId == false &&
                                      _empIdOK == true) {
                                    _empId = textValue;
                                  } else {
                                    _empId = '';
                                  }
                                });
                              } else {
                                setState(() => _isEmptyEmpId = true);
                                return;
                              }
                            });
                          }),
                      _isEmptyEmpId
                          ? Text("Please enter your Employee ID.",
                              style: warningTextStyle)
                          : _empIdOK == false
                              ? Text(
                                  'Enter 15 numerical digits, only. (e.g. 02075)',
                                  style: warningTextStyle)
                              : Container(),

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
                                  _isEmptyEmail = false;
                                  _emailOK = Validator().isEmail(textValue);

                                  if (_isEmptyEmail == false &&
                                      _emailOK == true) {
                                    _email = textValue;
                                  } else {
                                    _email = '';
                                  }
                                });
                              } else {
                                setState(() => _isEmptyEmail = true);
                                return;
                              }
                            });
                          }),
                      _isEmptyEmail
                          ? Text("Please enter your Email address.",
                              style: warningTextStyle)
                          : _emailOK == false
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
                                  _isEmptyPassword = false;
                                  _passwordOK =
                                      Validator().isPassword(textValue);
                                  if (_isEmptyPassword == false &&
                                      _passwordOK == true) {
                                    _password = textValue;
                                  } else {
                                    _password = '';
                                  }
                                });
                              } else {
                                setState(() => _isEmptyPassword = true);
                                return;
                              }
                            });
                          }),
                      _isEmptyPassword
                          ? Text("Please enter your Password.",
                              style: warningTextStyle)
                          : _passwordOK == false
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
                              _controller.signUp('${_email.trim()}@sgs.com',
                                  _password.trim(), _empId);
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
    if (_isEmptyEmail == false &&
        _emailOK == true &&
        _isEmptyPassword == false &&
        _passwordOK == true) {
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
