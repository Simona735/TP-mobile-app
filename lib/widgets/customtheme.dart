import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    bottomAppBarColor: Colors.blue
  );
  static final dark = ThemeData.dark().copyWith(
    bottomAppBarColor: Colors.blue,
    toggleableActiveColor: Colors.blue,
    colorScheme: ThemeData.dark().colorScheme.copyWith(secondary: Colors.blue),
  );
}
