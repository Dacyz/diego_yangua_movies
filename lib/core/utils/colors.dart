import 'package:flutter/material.dart';

class Decorations {
  static BoxDecoration backgroundColor() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF293037),
          Color(0xFF090E14),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  static const kPrimaryColor = Color(0xFF606060);
  static const kSecondaryColor = Color(0xFF424242);
}
