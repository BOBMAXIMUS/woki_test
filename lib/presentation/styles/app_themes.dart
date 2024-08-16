import 'package:flutter/material.dart';
import 'app_styles.dart';

class AppThemes {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: AppStyles.primaryColor,
      hintColor: AppStyles.accentColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: AppStyles.primaryColor,
        titleTextStyle: AppStyles.appBarTitleStyle(context),
      ),
      textTheme: TextTheme(
        displayLarge: AppStyles.articleTitleStyle(context),
        bodyLarge: AppStyles.bodyTextStyle(context),
        bodyMedium: AppStyles.bodyTextStyle(context),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        textColor: Colors.black,
        iconColor: AppStyles.primaryColor,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(AppStyles.primaryColor),
        trackColor:
            WidgetStateProperty.all(AppStyles.primaryColor.withOpacity(0.5)),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.black,
      hintColor: Colors.white,
      scaffoldBackgroundColor: Colors.grey,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle:
            AppStyles.appBarTitleStyle(context).copyWith(color: Colors.white),
      ),
      textTheme: TextTheme(
        displayLarge:
            AppStyles.articleTitleStyle(context).copyWith(color: Colors.white),
        bodyLarge:
            AppStyles.bodyTextStyle(context).copyWith(color: Colors.white),
        bodyMedium:
            AppStyles.bodyTextStyle(context).copyWith(color: Colors.white70),
      ),
      cardTheme: CardTheme(
        color: Colors.grey[850],
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        textColor: Colors.white,
        iconColor: AppStyles.accentColor,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.all(Colors.grey),
      ),
    );
  }
}
