import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeAndLocalizationCubit extends Cubit<ThemeAndLocalizationState> {
  ThemeAndLocalizationCubit()
      : super(ThemeAndLocalizationState(
          themeMode: ThemeMode.light,
          locale: const Locale('en'),
        ));

  void changeLocale(Locale newLocale) {
    emit(state.copyWith(locale: newLocale));
  }

  void toggleTheme(bool isDarkMode) {
    emit(state.copyWith(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
    ));
  }
}

class ThemeAndLocalizationState {
  final ThemeMode themeMode;
  final Locale locale;

  ThemeAndLocalizationState({
    required this.themeMode,
    required this.locale,
  });

  ThemeAndLocalizationState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return ThemeAndLocalizationState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
}
