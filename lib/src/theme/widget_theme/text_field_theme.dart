import 'package:flutter/material.dart';

import '../theme.dart';

class SGSTextFormFieldTheme {
  SGSTextFormFieldTheme._();

  static InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      borderSide: BorderSide(width: 1, color: SGSAppTheme.primary),
    ),
    prefixIconColor: SGSAppTheme.primary,
    floatingLabelStyle: TextStyle(color: SGSAppTheme.primary),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      borderSide: BorderSide(width: 2, color: SGSAppTheme.primary),
    ),
  );
}
