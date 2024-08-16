import 'package:flutter/material.dart';

class AppStyles {
  static const Color primaryColor = Colors.teal;
  static const Color accentColor = Colors.tealAccent;
  static const Color errorColor = Colors.red;
  static const Color titleColor = Colors.teal;
  static const Color lightTextColor = Colors.black87;
  static const Color darkTextColor = Colors.white;

  static TextStyle appBarTitleStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.dark
          ? darkTextColor
          : Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  static TextStyle articleTitleStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).brightness == Brightness.dark
          ? darkTextColor
          : titleColor,
      fontSize: 18,
    );
  }

  static TextStyle detailTitleStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).brightness == Brightness.dark
          ? darkTextColor
          : titleColor,
      fontSize: 24,
    );
  }

  static TextStyle bodyTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white70
          : Colors.grey[800],
      fontSize: 16,
    );
  }

  static TextStyle errorTextStyle(BuildContext context) {
    return const TextStyle(
      color: errorColor,
      fontSize: 16,
    );
  }

  static TextStyle noArticlesTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white70
          : Colors.grey[800],
      fontSize: 16,
    );
  }

  static TextStyle settingsTitleStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Theme.of(context).brightness == Brightness.dark
          ? darkTextColor
          : lightTextColor,
    );
  }

  static TextStyle listTileTitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      color: Theme.of(context).brightness == Brightness.dark
          ? darkTextColor
          : lightTextColor,
    );
  }

  static BoxDecoration cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[850]
          : Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black54
              : Colors.black26,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
