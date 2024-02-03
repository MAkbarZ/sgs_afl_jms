import 'package:flutter/material.dart';

import '../theme.dart';

class SGSButtonTheme {
  SGSButtonTheme._();

  static final elevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      foregroundColor: Colors.white,
      backgroundColor: SGSAppTheme.primary,
      side: const BorderSide(color: SGSAppTheme.primary),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
    ),
  );

  static final outlinedButton = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      foregroundColor: SGSAppTheme.primary,
      side: const BorderSide(
        color: SGSAppTheme.primary,
      ),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
    ),
  );
}
