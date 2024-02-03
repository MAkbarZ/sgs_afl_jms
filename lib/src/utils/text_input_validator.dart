class Validator {
  Validator();

  bool isEmail(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return true;
    } else {
      return false;
    }
  }

  bool isPassword(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return true;
    } else {
      return false;
    }
  }

  bool isAlphabates(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return true;
    } else {
      return false;
    }
  }

  bool isPhoneNumber(String? value) {
    // String pattern = r'^\D?(\d{4})\D?\D?(\d{3})\D?(\d{4})$';
    //
    String pattern = r'\D?(\d{4})\D?\D?(\d{3})\D?(\d{4})$';

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return true;
    } else {
      return false;
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
