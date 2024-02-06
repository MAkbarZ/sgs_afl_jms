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
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
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
    String pattern = r'^(?:[0][1-9]{1})?([0-9]{13})?$';

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
    String pattern = r'^(?:[0][3]{1})?([0-9]{2})?([0-9]{7})?$';

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
}
