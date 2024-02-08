import 'package:afljms/src/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common_widgets/input_field.dart';
import '../../../theme/widget_theme/text_theme.dart';
import '../../../utils/text_input_validator.dart';
import '../controllers/signup_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final SignUpController _controller = Get.put(SignUpController());

  bool _hidePassword = true;

  // staff
  String m_empId = '';
  String m_fullName = '';
  String m_hiredDate = '';
  String m_email = '';
  String m_mobile = '';
  String m_phone = '';
  String m_gender = 'male';

  //user
  String m_password = '';

  //staff authority
  // String m_afl_division = '';
  // String m_afl_function = '';

  bool _IsEmptyEmpID = true;
  bool _EmpIDOK = false;
  bool _IsEmptyFullName = true;
  bool _FullNameOK = false;
  bool _IsEmptyPhoneNo = true;
  bool _PhoneNoOK = false;
  bool _IsEmptyMobileNo = true;
  bool _MobileNoOK = false;
  bool _IsEmptyEmail = true;
  bool _EmailOK = false;
  bool _IsEmptyHireDate = true;
  // bool _HireDateOK = false;
  bool _IsEmptyPassword = true;
  bool _PasswordOK = false;

  String _selectedDate =
      'Enter your hired date e.g ${DateFormat.yMMMd().format(DateTime.now())}';

  Set<SGSEnumGender> _enumGender = <SGSEnumGender>{
    SGSEnumGender.male, // SGSEnumActivation.deactivate
  };

  String m_selectedDivison = "Enter your AFL Division";
  bool _isSelectedDivison = false;
  List _divList = [];

  String m_selectedFunction = "Enter your AFL Function";
  bool _isSelectedFunction = false;
  List _functionList = [];

  @override
  void initState() {
    super.initState();

    m_gender = 'male';

    getAllActiveDivisions();
    getAllActiveFunctions();
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
              Center(
                  child: screenWidth <= 500.0
                      ? Container(
                          padding: const EdgeInsets.all(30.0),
                          width: screenWidth <= 300.0 ? double.infinity : 350.0,
                          color: Colors.white,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  // color: Colors.black54,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SGSInputField(
                                            title: 'Employee ID',
                                            hint: 'e.g. 02075',
                                            maxLength: 10,
                                            isObscure: false,
                                            readonly: false,
                                            onChanged: (textValue) {
                                              setState(() {
                                                if (textValue.trim() != "") {
                                                  setState(() {
                                                    _IsEmptyEmpID = false;
                                                    _EmpIDOK = Validator()
                                                        .isEmployeeID(
                                                            textValue);

                                                    if (_IsEmptyEmpID ==
                                                            false &&
                                                        _EmpIDOK == true) {
                                                      m_empId = textValue;
                                                    } else {
                                                      m_empId = "";
                                                    }
                                                  });
                                                } else {
                                                  setState(() =>
                                                      _IsEmptyEmpID = true);
                                                  return;
                                                }
                                              });
                                            }),
                                        _IsEmptyEmpID
                                            ? Text(
                                                "Please enter your Employee ID.",
                                                style: warningTextStyle)
                                            : _EmpIDOK == false
                                                ? Text(
                                                    'Enter 15 numerical digits, only. (e.g. 02075)',
                                                    style: warningTextStyle)
                                                : Container(),

                                        const SizedBox(height: 5.0),

                                        //gender
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            'Gender',
                                            style: SGSTextTheme.headingStyle12,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        // ACTIVE SEGMENTED BUTTON
                                        SizedBox(
                                          // width: 20,
                                          height: 25,
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child:
                                                SegmentedButton<SGSEnumGender>(
                                              segments: const [
                                                ButtonSegment<SGSEnumGender>(
                                                    value: SGSEnumGender.male,
                                                    label: Text('Male')),
                                                // ButtonSegment(
                                                //     value: 'Month', label: Text('Month')),
                                                ButtonSegment<SGSEnumGender>(
                                                    value: SGSEnumGender.female,
                                                    label: Text('Female')),
                                              ],
                                              onSelectionChanged: (selected) {
                                                // print('Selected $selected');
                                                // print('Selected 0 ${selected.elementAt(0)}');
                                                setState(() {
                                                  if (selected.elementAt(0) ==
                                                      SGSEnumGender.male) {
                                                    m_gender = 'male';
                                                  } else {
                                                    m_gender = 'female';
                                                  }
                                                  _enumGender = selected;
                                                });
                                              },
                                              selected: _enumGender,
                                              emptySelectionAllowed: false,
                                              multiSelectionEnabled: false,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 10.0),

// Full Name
                                        SGSInputField(
                                            title: 'Full Name',
                                            hint: 'Enter your full name',
                                            isObscure: false,
                                            readonly: false,
                                            maxLength: 25,
                                            // textEditingController:
                                            //     _controller.fullNameController,
                                            // isObscure: false,

                                            onChanged: (textValue) {
                                              setState(() {
                                                if (textValue.trim() != "") {
                                                  setState(() {
                                                    _IsEmptyFullName = false;
                                                    _FullNameOK = Validator()
                                                        .isAlphabates(
                                                            textValue);

                                                    if (_IsEmptyFullName ==
                                                            false &&
                                                        _FullNameOK == true) {
                                                      m_fullName = textValue;
                                                    } else {
                                                      m_fullName = '';
                                                    }
                                                  });
                                                } else {
                                                  setState(() =>
                                                      _IsEmptyFullName = true);
                                                  return;
                                                }
                                              });
                                            }),
                                        _IsEmptyFullName
                                            ? Text("Full Name cannot be empty.",
                                                style: warningTextStyle)
                                            : _FullNameOK == false
                                                ? Text(
                                                    'Name must be in engish alphabates',
                                                    style: warningTextStyle)
                                                : Container(),

                                        const SizedBox(height: 5.0),

                                        SGSInputField(
                                            title: 'Phone No.',
                                            hint: 'e.g. 020111999222314',
                                            maxLength: 15,
                                            isObscure: false,
                                            readonly: false,
                                            onChanged: (textValue) {
                                              setState(() {
                                                if (textValue.trim() != "") {
                                                  setState(() {
                                                    _IsEmptyPhoneNo = false;
                                                    _PhoneNoOK = Validator()
                                                        .isPhoneNumber(
                                                            textValue);

                                                    if (_IsEmptyPhoneNo ==
                                                            false &&
                                                        _PhoneNoOK == true) {
                                                      m_phone = textValue;
                                                    } else {
                                                      m_phone = '';
                                                    }
                                                  });
                                                } else {
                                                  setState(() =>
                                                      _IsEmptyPhoneNo = true);
                                                  return;
                                                }
                                              });
                                            }),
                                        _IsEmptyPhoneNo
                                            ? Text(
                                                "Please enter your Phone No.",
                                                style: warningTextStyle)
                                            : _PhoneNoOK == false
                                                ? Text(
                                                    'Enter 15 numerical digits, only. (e.g. 020111999222314)',
                                                    style: warningTextStyle)
                                                : Container(),
                                        const SizedBox(height: 5.0),

                                        // Mobile No.
                                        SGSInputField(
                                            title: 'Mobile No.',
                                            hint: 'e.g. 0313-847-6361',
                                            maxLength: 11,
                                            isObscure: false,
                                            readonly: false,
                                            // textEditingController:
                                            // _signUpController
                                            //     .phoneNoController,
                                            // isObscure: false,
                                            // validator: (value) {
                                            //   if (Validator().isEmpty(value)) {
                                            //     return 'Please enter your Mobile No.';
                                            //   }

                                            //   if (Validator()
                                            //       .isPhoneNumber(value)) {
                                            //     return 'Enter 11 numerical digits, only';
                                            //   }
                                            //   return null;
                                            // },
                                            onChanged: (textValue) {
                                              setState(() {
                                                if (textValue.trim() != "") {
                                                  setState(() {
                                                    _IsEmptyMobileNo = false;
                                                    _MobileNoOK = Validator()
                                                        .isMobileNumber(
                                                            textValue);
                                                    if (_IsEmptyMobileNo ==
                                                            false &&
                                                        _MobileNoOK == true) {
                                                      m_mobile = textValue;
                                                    } else {
                                                      m_mobile = '';
                                                    }
                                                  });
                                                } else {
                                                  setState(() =>
                                                      _IsEmptyMobileNo = true);
                                                  return;
                                                }
                                              });
                                            }),
                                        _IsEmptyMobileNo
                                            ? Text(
                                                "Please enter your Mobile No.",
                                                style: warningTextStyle)
                                            : _MobileNoOK == false
                                                ? Text(
                                                    'Enter 11 numerical digits, only. (e.g. 03138476361)',
                                                    style: warningTextStyle)
                                                : Container(),

                                        // Email
                                        const SizedBox(height: 5.0),
                                        SGSInputField(
                                            title: 'Email',
                                            hint: 'Enter your email',
                                            readonly: false,
                                            isObscure: false,
                                            maxLength: 25,
                                            // textEditingController:
                                            //     _signUpController
                                            //         .emailController,
                                            // isObscure: false,
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
                                                    _EmailOK = Validator()
                                                        .isEmail(textValue);

                                                    if (_IsEmptyEmail ==
                                                            false &&
                                                        _EmailOK == true) {
                                                      m_email = textValue;
                                                    } else {
                                                      m_email = '';
                                                    }
                                                  });
                                                } else {
                                                  setState(() =>
                                                      _IsEmptyEmail = true);
                                                  return;
                                                }
                                              });
                                            }),
                                        _IsEmptyEmail
                                            ? Text(
                                                "Please enter your Email address.",
                                                style: warningTextStyle)
                                            : _EmailOK == false
                                                ? Text(
                                                    'Please enter correctly formatted Email',
                                                    style: warningTextStyle)
                                                : Container(),

                                        // Hired Date
                                        const SizedBox(height: 5.0),
                                        SGSInputField(
                                          title: 'Hired Date',
                                          hint: _selectedDate,
                                          readonly: true,
                                          isObscure: false,
                                          // maxLength: 25,
                                          suffixIcon: IconButton(
                                              icon: const Icon(
                                                Icons.calendar_today_outlined,
                                                size: 15.0,
                                                color: Colors.grey,
                                              ),
                                              // onPressed: () => _signUpController.toggleShowHidePassword(),
                                              onPressed: () async {
                                                DateTime? _pickerDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(1980),
                                                        lastDate:
                                                            DateTime(2049));

                                                setState(() {
                                                  if (_pickerDate != null) {
                                                    _selectedDate =
                                                        DateFormat.yMMMd()
                                                            .format(
                                                                _pickerDate);

                                                    m_hiredDate = _pickerDate
                                                            .year
                                                            .toString() +
                                                        NumberFormat(
                                                                '00', 'en_US')
                                                            .format(_pickerDate
                                                                .month) +
                                                        _pickerDate.day
                                                            .toString();

                                                    _IsEmptyHireDate = false;
                                                  } else {
                                                    _IsEmptyHireDate = true;
                                                  }
                                                });
                                              }),
                                        ),

                                        _IsEmptyHireDate
                                            ? Text(
                                                "Please enter your Hired Date",
                                                style: warningTextStyle)
                                            : Container(),

                                        // PASSWORD
                                        const SizedBox(height: 5.0),
                                        SGSInputField(
                                            title: 'Password',
                                            hint: 'Enter your password',
                                            maxLength: 20,
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
                                                    _hidePassword =
                                                        !_hidePassword;
                                                  });
                                                }),
                                            onChanged: (textValue) {
                                              setState(() {
                                                if (textValue.trim() != "") {
                                                  setState(() {
                                                    _IsEmptyPassword = false;
                                                    _PasswordOK = Validator()
                                                        .isPassword(textValue);
                                                    if (_IsEmptyPassword ==
                                                            false &&
                                                        _PasswordOK == true) {
                                                      m_password = textValue;
                                                    } else {
                                                      m_password = '';
                                                    }
                                                  });
                                                } else {
                                                  setState(() =>
                                                      _IsEmptyPassword = true);
                                                  return;
                                                }
                                              });
                                            }),
                                        _IsEmptyPassword
                                            ? Text(
                                                "Please enter your Password.",
                                                style: warningTextStyle)
                                            : _PasswordOK == false
                                                ? Text(
                                                    'Password must be at least 6 characters.',
                                                    style: warningTextStyle)
                                                : Container(),

                                        // AFL DIVISION
                                        const SizedBox(height: 5.0),
                                        SGSInputField(
                                          title: 'AFL Division',
                                          hint: m_selectedDivison,
                                          // maxLength: 20,
                                          readonly: true,
                                          isObscure: false,
                                          suffixIcon: DropdownButton(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            underline: Container(height: 0.0),
                                            elevation: 4,
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 25.0,
                                              color: Colors.grey,
                                            ),
                                            // iconSize: 32,
                                            style:
                                                SGSTextTheme.textInputStyle14,
                                            items: _divList
                                                .map<DropdownMenuItem<String>>(
                                                    (value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              if (value != null ||
                                                  value != "") {
                                                setState(() {
                                                  m_selectedDivison = value!;
                                                  _isSelectedDivison = true;
                                                });
                                              } else {
                                                setState(() {
                                                  m_selectedDivison =
                                                      "Enter your AFL Division";
                                                  _isSelectedDivison = false;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        _isSelectedDivison == false
                                            ? Text("Please enter AFL division.",
                                                style: warningTextStyle)
                                            : Container(),

                                        // AFL FUNCTION
                                        const SizedBox(height: 5.0),
                                        SGSInputField(
                                          title: 'AFL Function',
                                          hint: m_selectedFunction,
                                          // maxLength: 20,
                                          readonly: true,
                                          isObscure: false,
                                          suffixIcon: DropdownButton(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            underline: Container(height: 0.0),
                                            elevation: 4,
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 25.0,
                                              color: Colors.grey,
                                            ),
                                            // iconSize: 32,
                                            style:
                                                SGSTextTheme.textInputStyle14,
                                            items: _functionList
                                                .map<DropdownMenuItem<String>>(
                                                    (value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              if (value != null ||
                                                  value != "") {
                                                setState(() {
                                                  m_selectedFunction = value!;
                                                  _isSelectedFunction = true;
                                                });
                                              } else {
                                                setState(() {
                                                  m_selectedFunction =
                                                      "Enter your AFL Function";
                                                  _isSelectedFunction = false;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        _isSelectedFunction == false
                                            ? Text("Please enter AFL function.",
                                                style: warningTextStyle)
                                            : Container(),

                                        //
                                      ]),
                                ),
                                const SizedBox(height: 15.0),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.hide');

                                      // if (_signUpController
                                      //     .validateBeforeContinue()) {
                                      //   _signUpController
                                      //       .registerAndCreateUser();
                                      // } else {
                                      //   // print('input is wrongly entered.');
                                      //   return;
                                      // }
                                      // return null;
                                      print('printing start');
                                      Map<String, dynamic> dataStaff = {};
                                      Map<String, dynamic> dataUser = {};
                                      Map<String, dynamic> dataAuthority = {};
                                      if (isInputDataOK()) {
                                        dataStaff = {
                                          "empId": m_empId,
                                          "fullName": m_fullName,
                                          "hiredDate": m_hiredDate,
                                          "email": m_email,
                                          "mobile": m_mobile,
                                          "phone": m_phone,
                                          "gender": m_gender,
                                          "approverEmpId": '',
                                          "active": false,
                                        };
                                        dataUser = {
                                          "empId": m_empId,
                                          "isVerified": false,
                                          "approverEmpId": '',
                                          "active": false,
                                        };
                                        dataAuthority = {
                                          "empId": m_empId,
                                          "aflDivision": m_selectedDivison,
                                          "aflFunction": m_selectedFunction,
                                          "approverEmpId": '',
                                          "active": false,
                                        };
                                      }

                                      print(dataStaff);
                                      print(dataUser);
                                      print(dataAuthority);

                                      _controller.createStaff(dataStaff);
                                      _controller.createUser(dataUser);
                                      _controller
                                          .createAuthority(dataAuthority);
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ),
                              ]),
                        )
                      :

                      //CONTAINER For > 300.00
                      Container(
                          color: Colors.pink,
                          width: double.infinity,
                          height: 600,
                        )),
            ],
          ),
        ),
      ),
    );
  }

  // METHODS

  bool isInputDataOK() {
    if (_IsEmptyEmpID == false &&
        _EmpIDOK == true &&
        _IsEmptyFullName == false &&
        _FullNameOK == true &&
        _IsEmptyPhoneNo == false &&
        _PhoneNoOK == true &&
        _IsEmptyMobileNo == false &&
        _MobileNoOK == true &&
        _IsEmptyEmail == false &&
        _EmailOK == true &&
        _IsEmptyHireDate == false &&
        //  _HireDateOK == true &&
        _IsEmptyPassword == false &&
        _PasswordOK == true &&
        _isSelectedDivison == true &&
        _isSelectedFunction == true) {
      return true;
    } else {
      return false;
    }
  }

  getAllActiveDivisions() async {
    await _controller.getActiveAFLDivisions().then((querySnapshot) {
      // print("Successfully completed");

      for (var docSnapshot in querySnapshot.docs) {
        // print('${docSnapshot.id} => ${docSnapshot.data()}');
        // list.add({docSnapshot.id: docSnapshot.data()});
        _divList.add(docSnapshot.data()['divisionName']);
      }
      setState(() {});
      // print(_divList);
    });
  }

  getAllActiveFunctions() async {
    await _controller.getActiveAFLFunctions().then((querySnapshot) {
      // print("Successfully completed");

      for (var docSnapshot in querySnapshot.docs) {
        // print('${docSnapshot.id} => ${docSnapshot.data()}');
        // list.add({docSnapshot.id: docSnapshot.data()});
        _functionList.add(docSnapshot.data()['functionName']);
      }
      setState(() {});
      // print(_divList);
    });
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
              "let's start...",
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
