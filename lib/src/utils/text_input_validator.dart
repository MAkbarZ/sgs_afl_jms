import 'package:flutter/material.dart';

class Validator {
  Validator();

  bool isEmployeeID(String? value) {
    //02075   = 4 to 10 digits
    String pattern = r'^(?:[0-9]{4,10})?$';

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return false;
    } else {
      return true;
    }
  }

  bool isEmail(String? value) {
    // String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    String pattern = r'^[a-z0-9]{1,20}.{0,1}[a-z0-9]{1,20}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return false;
    } else {
      return true;
    }
  }

  bool isPassword(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return false;
    } else {
      return true;
    }
  }

  bool isAlphabates(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return false;
    } else {
      return true;
    }
  }

  bool isPhoneNumber(String? value) {
    //0313-847-6361   = 13 digits
    // String pattern = r'^(?:[0]3)?([0-9]{2}[-])?([0-9]{3}[-])?([0-9]{4})?$';

    //020111999222314   = 15 digits
    // String pattern = r'^(?:[0][1-9]{1})?([0-9]{13})?$';
    //020111999222314   = 10 to 13 digits
    String pattern = r'^(0)([1-9]{1})([0-9]{8,13})$';

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return false;
    } else {
      return true;
    }
  }

  bool isMobileNumber(String? value) {
    //0313-847-6361   = 13 digits
    // String pattern = r'^(?:[0]3)?([0-9]{2}[-])?([0-9]{3}[-])?([0-9]{4})?$';

    //03138476361   = 11 digits
    // String pattern = r'^([0][3])?([0-9]{2})?([0-9]{7})?$';
    //03123456789   = 11 digits
    String pattern = r'^(0[3])([0-9]{9})$';

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return false;
    } else {
      return true;
    }
  }

  bool isAmount(String? value) {
    //search only digits
    String pattern = r'^\d+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return true;
    } else {
      return false;
    }
  }

  bool isEmpty(String? value) {
    // matches any character not with white space
    String pattern = r'^\S+$';
    RegExp regex = RegExp(pattern);
    // print(regex.pattern);
    if (!regex.hasMatch(value!)) {
      return true;
    } else {
      return false;
    }
  }

  TextStyle warningTextStyle =
      const TextStyle(color: Colors.red, fontSize: 9.0);

  Widget isEmpIDValid(bool isEmptyEmpID, bool empIDOK) {
    if (isEmptyEmpID) {
      return Text("Please enter your Employee ID.", style: warningTextStyle);
    } else {
      if (empIDOK == false) {
        return Text('Enter 4-10 digits, only. (e.g. 2075)',
            style: warningTextStyle);
      } else {
        return Container();
      }
    }
  }

  Widget isFullNameValid(bool isEmptyFullName, bool fullNameOK) {
    if (isEmptyFullName) {
      return Text("Full Name cannot be empty.", style: warningTextStyle);
    } else {
      if (fullNameOK == false) {
        return Text('Name must be in engish alphabates',
            style: warningTextStyle);
      } else {
        return Container();
      }
    }
  }

  Widget isPhoneNoValid(bool isEmptyPhoneNo, bool phoneNoOK) {
    if (isEmptyPhoneNo) {
      return Text("Please enter your Phone No.", style: warningTextStyle);
    } else {
      if (phoneNoOK == false) {
        return Text('Enter minimum 11 digits. (e.g. 021234567890)',
            style: warningTextStyle);
      } else {
        return Container();
      }
    }
  }

  Widget isMobileNoValid(bool isEmptyMobileNo, bool mobileNoOK) {
    if (isEmptyMobileNo) {
      return Text("Please enter your Mobile No.", style: warningTextStyle);
    } else {
      if (mobileNoOK == false) {
        return Text('Enter numerical digits, only. (e.g. 03123456789)',
            style: warningTextStyle);
      } else {
        return Container();
      }
    }
  }

  // Widget isEmailValid(bool isEmptyEmail, bool emailOK) {
  //   if (isEmptyEmail) {
  //     return Text("Please enter your Email address.", style: warningTextStyle);
  //   } else {
  //     if (emailOK == false) {
  //       return Text('Please enter correctly formatted Email',
  //           style: warningTextStyle);
  //     } else {
  //       return Container();
  //     }
  //   }
  // }

  Widget isHireDateValid(bool isEmptyHireDate) {
    if (isEmptyHireDate) {
      return Text("Please enter your Hired Date", style: warningTextStyle);
    } else {
      return Container();
    }
  }

  Widget isDivisionValid(bool isSelectedDivison) {
    if (isSelectedDivison == false) {
      return Text("Please enter AFL division.", style: warningTextStyle);
    } else {
      return Container();
    }
  }

  Widget isFunctionValid(bool isSelectedFunction) {
    if (isSelectedFunction == false) {
      return Text("Please enter AFL function.", style: warningTextStyle);
    } else {
      return Container();
    }
  }
}
