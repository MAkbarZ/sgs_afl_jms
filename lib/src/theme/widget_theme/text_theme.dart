import 'package:flutter/material.dart';

import '../theme.dart';
// import 'package:google_fonts/google_fonts.dart';

class SGSTextTheme {
  SGSTextTheme._();

  static TextTheme defaultText = const TextTheme(
    headlineMedium: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black, fontSize: 24),
    titleMedium: TextStyle(color: Colors.black, fontSize: 20),
  );

  static TextStyle titleStyle20 = const TextStyle(
    fontFamily: 'Arial',
    fontSize: 20.0,
    color: SGSAppTheme.primary,
    decoration: TextDecoration.none,
  );

  static TextStyle titleStyle15 = const TextStyle(
    fontFamily: 'Arial',
    fontSize: 15.0,
    color: SGSAppTheme.primary,
    decoration: TextDecoration.none,
  );

  static TextStyle headingStyle15 = const TextStyle(
    fontFamily: 'Arial',
    fontSize: 15.0,
    fontWeight: FontWeight.w800,
    color: SGSAppTheme.greyHeading,
    decoration: TextDecoration.none,
  );

  static TextStyle headingStyle12 = const TextStyle(
    fontFamily: 'Arial',
    fontSize: 12.0,
    fontWeight: FontWeight.w800,
    color: SGSAppTheme.greyHeading,
    decoration: TextDecoration.none,
  );

  static TextStyle normalStyle13 = const TextStyle(
    fontFamily: 'Arial',
    fontSize: 13.0,
    color: SGSAppTheme.greyParaText,
    decoration: TextDecoration.none,
  );

  static TextStyle textInputStyle14 = const TextStyle(
    fontFamily: 'Arial',
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: SGSAppTheme.greyParaText,
    decoration: TextDecoration.none,
  );

  static TextStyle textInputStyle12 = const TextStyle(
    fontFamily: 'Arial',
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: SGSAppTheme.greyParaText,
    decoration: TextDecoration.none,
  );

  static TextStyle textInputStyle10 = const TextStyle(
    fontFamily: 'Arial',
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    color: SGSAppTheme.greyParaText,
    decoration: TextDecoration.none,
  );

  static TextStyle textInputHintStyleRed10 = const TextStyle(
    fontFamily: 'Arial',
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    color: Colors.red,
    decoration: TextDecoration.none,
  );

//
}
