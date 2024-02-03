import 'package:flutter/material.dart';

import 'widget_theme/button_theme.dart';
import 'widget_theme/text_theme.dart';

class SGSAppTheme {
  SGSAppTheme._();

  static const Color primary = Color(0xFFCA4300);
  static const Color yellowClr = Color(0xFFFFB746);
  static const Color pinkClr = Color(0xFFFF4667);
  static const Color whiteClr = Colors.white;

// static const Color darkGrey = Color(0xFF121212);
// static const Color darkHeader = Color(0xFF424242);

//for a Background
  static const Color greySectionBG = Color(0xFF3c515b);

// Text - Heading
  static const Color greyHeading = Color(0xFF252525);
// Text - Paragraph
  static const Color greyParaText = Color(0xFF555555);

// Text - hints - e.g. Business News . Knowledge
  static const Color bluishGrey = Color(0xFF49738B);

  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    textTheme: SGSTextTheme.defaultText,

    outlinedButtonTheme: SGSButtonTheme.outlinedButton,
    elevatedButtonTheme: SGSButtonTheme.elevatedButton,
    // inputDecorationTheme: SGSTextFormFieldTheme.inputDecorationTheme,
    useMaterial3: true,
    fontFamily: 'Arial',
  );
}
