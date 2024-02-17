import 'package:afljms/src/enums/enums.dart';
import 'package:afljms/src/features/core/employee/employee_controller.dart';
import 'package:afljms/src/features/core/employee/employee_register_screen_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../theme/widget_theme/text_theme.dart';
import '../../../utils/text_input_validator.dart';
import 'employee_register_screen_desktop.dart';

class EmployeeRegisterScreen extends StatefulWidget {
  const EmployeeRegisterScreen({super.key});

  @override
  State<EmployeeRegisterScreen> createState() => _EmployeeRegisterScreenState();
}

class _EmployeeRegisterScreenState extends State<EmployeeRegisterScreen> {
  final EmployeeController _controller = Get.put(EmployeeController());

  List<String> _divList = [];
  List<String> _functionList = [];

  @override
  void initState() {
    super.initState();

    _controller.m_gender = 'male';
    _controller.m_email = _controller.getCurrentUser()?.email ?? "blank";

    getAllActiveDivisions();
    getAllActiveFunctions();

    // _controller.m_selectedDivison = _divList[0].toString();
    // _controller.m_selectedFunction = _functionList[0].toString();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              logoAndHeader,
              Center(
                child: screenWidth <= 600.0
                    ? EmployeeRegisterScreenMobile(
                        isEmpIDValid: isEmpIDValid(),
                        isFullNameValid: isFullNameValid(),
                        isPhoneNoValid: isPhoneNoValid(),
                        isMobileNoValid: isMobileNoValid(),
                        // isEmailValid: isEmailValid(),
                        isHireDateValid: isHireDateValid(),
                        isDivisionValid: isDivisionValid(),
                        isFunctionValid: isFunctionValid(),
                        isInputDataOK: _controller.isInputDataOK(),
                        divisionList: _divList,
                        functionList: _functionList,
                        selectedDivison: _controller.m_selectedDivison,
                        selectedFunction: _controller.m_selectedFunction,
                        selectedGender: _controller.enumGender,
                        selectedHireDate: _controller.selectedDate,
                        onChangedEmplID: onChangedEmplID,
                        onSelectionChangedGender: onSelectionChangedGender,
                        onChangedFullName: onChangedFullName,
                        // onChangedEmail: onChangedEmail,
                        onChangedMobileNo: onChangedMobileNo,
                        onChangedPhoneNo: onChangedPhoneNo,
                        onChangedFunctions: onChangedFunctions,
                        onChangedDivisions: onChangedDivisions,
                        onPressedHireDate: onPressedHireDate,
                        onPressedSubmit: _controller.onSubmit,
                        initialValueEmail: _controller.m_email,
                      )
                    :

                    //CONTAINER For >= 450.00
                    EmployeeRegisterScreenDesktop(
                        isEmpIDValid: isEmpIDValid(),
                        isFullNameValid: isFullNameValid(),
                        isPhoneNoValid: isPhoneNoValid(),
                        isMobileNoValid: isMobileNoValid(),
                        // isEmailValid: isEmailValid(),
                        isHireDateValid: isHireDateValid(),
                        isDivisionValid: isDivisionValid(),
                        isFunctionValid: isFunctionValid(),
                        isInputDataOK: _controller.isInputDataOK(),
                        divisionList: _divList,
                        functionList: _functionList,
                        selectedDivison: _controller.m_selectedDivison,
                        selectedFunction: _controller.m_selectedFunction,
                        selectedGender: _controller.enumGender,
                        selectedHireDate: _controller.selectedDate,
                        onChangedEmplID: onChangedEmplID,
                        onSelectionChangedGender: onSelectionChangedGender,
                        onChangedFullName: onChangedFullName,
                        // onChangedEmail: onChangedEmail,
                        onChangedMobileNo: onChangedMobileNo,
                        onChangedPhoneNo: onChangedPhoneNo,
                        onChangedFunctions: onChangedFunctions,
                        onChangedDivisions: onChangedDivisions,
                        onPressedHireDate: onPressedHireDate,
                        onPressedSubmit: _controller.onSubmit,
                        initialValueEmail: _controller.m_email,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget isEmpIDValid() {
    if (_controller.isEmptyEmpID) {
      return Text("Please enter your Employee ID.", style: warningTextStyle);
    } else {
      if (_controller.empIDOK == false) {
        return Text('Enter 15 numerical digits, only. (e.g. 02075)',
            style: warningTextStyle);
      } else {
        return Container();
      }
    }
  }

  Widget isFullNameValid() {
    if (_controller.isEmptyFullName) {
      return Text("Full Name cannot be empty.", style: warningTextStyle);
    } else {
      if (_controller.fullNameOK == false) {
        return Text('Name must be in engish alphabates',
            style: warningTextStyle);
      } else {
        return Container();
      }
    }
  }

  Widget isPhoneNoValid() {
    if (_controller.isEmptyPhoneNo) {
      return Text("Please enter your Phone No.", style: warningTextStyle);
    } else {
      if (_controller.phoneNoOK == false) {
        return Text('Enter 15 numerical digits, only. (e.g. 020111999222314)',
            style: warningTextStyle);
      } else {
        return Container();
      }
    }
  }

  Widget isMobileNoValid() {
    if (_controller.isEmptyMobileNo) {
      return Text("Please enter your Mobile No.", style: warningTextStyle);
    } else {
      if (_controller.mobileNoOK == false) {
        return Text('Enter 11 numerical digits, only. (e.g. 03138476361)',
            style: warningTextStyle);
      } else {
        return Container();
      }
    }
  }

  // Widget isEmailValid() {
  //   if (_IsEmptyEmail) {
  //     return Text("Please enter your Email address.", style: warningTextStyle);
  //   } else {
  //     if (_EmailOK == false) {
  //       return Text('Please enter correctly formatted Email',
  //           style: warningTextStyle);
  //     } else {
  //       return Container();
  //     }
  //   }
  // }

  Widget isHireDateValid() {
    if (_controller.isEmptyHireDate) {
      return Text("Please enter your Hired Date", style: warningTextStyle);
    } else {
      return Container();
    }
  }

  Widget isDivisionValid() {
    if (_controller.isSelectedDivison == false) {
      return Text("Please enter AFL division.", style: warningTextStyle);
    } else {
      return Container();
    }
  }

  Widget isFunctionValid() {
    if (_controller.isSelectedFunction == false) {
      return Text("Please enter AFL function.", style: warningTextStyle);
    } else {
      return Container();
    }
  }

  // METHODS

  getAllActiveDivisions() async {
    await _controller.getActiveAFLDivisions().then((querySnapshot) {
      // print("Successfully completed");

      for (var docSnapshot in querySnapshot.docs) {
        // print('${docSnapshot.id} => ${docSnapshot.data()}');
        // list.add({docSnapshot.id: docSnapshot.data()});
        _divList.add(docSnapshot.data()['divisionName']);
      }
      setState(() {
        _controller.m_selectedDivison = _divList.first;
        _controller.isSelectedDivison = true;
        // print(_divList.first);
      });
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
      setState(() {
        _controller.m_selectedFunction = _functionList.first;
        _controller.isSelectedFunction = true;
      });
      // print(_divList);
    });
  }

  void onChangedEmplID(textValue) {
    setState(() {
      if (textValue.trim() != "") {
        setState(() {
          _controller.isEmptyEmpID = false;
          _controller.empIDOK = Validator().isEmployeeID(textValue);

          if (_controller.isEmptyEmpID == false &&
              _controller.empIDOK == true) {
            _controller.m_empId = textValue;
          } else {
            _controller.m_empId = "";
          }
        });
      } else {
        setState(() => _controller.isEmptyEmpID = true);
        return;
      }
    });
  }

  void onSelectionChangedGender(selected) {
    // print('Selected $selected');
    // print('Selected 0 ${selected.elementAt(0)}');
    setState(() {
      if (selected.elementAt(0) == SGSEnumGender.male) {
        _controller.m_gender = 'male';
      } else {
        _controller.m_gender = 'female';
      }
      _controller.enumGender = selected;
    });
  }

  void onChangedFullName(textValue) {
    setState(() {
      if (textValue.trim() != "") {
        setState(() {
          _controller.isEmptyFullName = false;
          _controller.fullNameOK = Validator().isAlphabates(textValue);

          if (_controller.isEmptyFullName == false &&
              _controller.fullNameOK == true) {
            _controller.m_fullName = textValue;
          } else {
            _controller.m_fullName = '';
          }
        });
      } else {
        setState(() => _controller.isEmptyFullName = true);
        return;
      }
    });
  }

  void onChangedPhoneNo(textValue) {
    setState(() {
      if (textValue.trim() != "") {
        setState(() {
          _controller.isEmptyPhoneNo = false;
          _controller.phoneNoOK = Validator().isPhoneNumber(textValue);

          if (_controller.isEmptyPhoneNo == false &&
              _controller.phoneNoOK == true) {
            _controller.m_phone = textValue;
          } else {
            _controller.m_phone = '';
          }
        });
      } else {
        setState(() => _controller.isEmptyPhoneNo = true);
        return;
      }
    });
  }

  void onChangedMobileNo(textValue) {
    setState(() {
      if (textValue.trim() != "") {
        setState(() {
          _controller.isEmptyMobileNo = false;
          _controller.mobileNoOK = Validator().isMobileNumber(textValue);
          if (_controller.isEmptyMobileNo == false &&
              _controller.mobileNoOK == true) {
            _controller.m_mobile = textValue;
          } else {
            _controller.m_mobile = '';
          }
        });
      } else {
        setState(() => _controller.isEmptyMobileNo = true);
        return;
      }
    });
  }

  // void onChangedEmail(textValue) {
  //   setState(() {
  //     if (textValue.trim() != "") {
  //       setState(() {
  //         _IsEmptyEmail = false;
  //         _EmailOK = Validator().isEmail(textValue);

  //         if (_IsEmptyEmail == false && _EmailOK == true) {
  //           m_email = textValue;
  //         } else {
  //           m_email = '';
  //         }
  //       });
  //     } else {
  //       setState(() => _IsEmptyEmail = true);
  //       return;
  //     }
  //   });
  // }

  void onPressedHireDate() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2049));

    setState(() {
      if (_pickerDate != null) {
        _controller.selectedDate = DateFormat.yMMMd().format(_pickerDate);

        _controller.m_hiredDate = _pickerDate.year.toString() +
            NumberFormat('00', 'en_US').format(_pickerDate.month) +
            NumberFormat('00', 'en_US').format(_pickerDate.day);

        _controller.isEmptyHireDate = false;
      } else {
        _controller.isEmptyHireDate = true;
      }
    });
  }

  void onChangedDivisions(dynamic value) {
    if (value != null || value.toString() != "") {
      setState(() {
        _controller.m_selectedDivison = value.toString();
        _controller.isSelectedDivison = true;
      });
    } else {
      setState(() {
        _controller.m_selectedDivison = "Enter your AFL Division";
        _controller.isSelectedDivison = false;
      });
    }
  }

  void onChangedFunctions(dynamic value) {
    if (value != null || value.toString() != "") {
      setState(() {
        _controller.m_selectedFunction = value.toString();
        _controller.isSelectedFunction = true;
      });
    } else {
      setState(() {
        _controller.m_selectedFunction = "Enter your AFL Function";
        _controller.isSelectedFunction = false;
      });
    }
  }

  void onSelectedFunctions(String? value) {
    if (value != null || value != "") {
      setState(() {
        _controller.m_selectedFunction = value.toString();
        _controller.isSelectedFunction = true;
      });
    } else {
      setState(() {
        _controller.m_selectedFunction = "Enter your AFL Function";
        _controller.isSelectedFunction = false;
      });
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
              'REGISTER YOURSELF',
              textAlign: TextAlign.start,
              style: SGSTextTheme.titleStyle20,
            ),
            // const SizedBox(height: 10.0),
            Text(
              "First thing,,,, first",
              textAlign: TextAlign.start,
              style: SGSTextTheme.normalStyle13,
            ),
          ],
        ),
      ],
    ),
  );
}
