import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_article_app/presentation/cubits/theme_and_localization_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');

  setUpAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'getTemporaryDirectory') {
        return '/tmp';
      }
      return null;
    });

    final directory = Directory('/tmp');
    Hive.init(directory.path);
  });

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('ThemeAndLocalizationCubit', () {
    late ThemeAndLocalizationCubit cubit;

    setUp(() {
      cubit = ThemeAndLocalizationCubit();
    });

    tearDown(() async {
      await Hive.close();
      cubit.close();
    });

    testWidgets('emits ThemeMode.light and locale set to "en" initially',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              expect(cubit.state.themeMode, ThemeMode.light);
              expect(cubit.state.locale, const Locale('en'));
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets(
        'toggleTheme switches to ThemeMode.dark when isDarkMode is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              cubit.toggleTheme(true);
              expect(cubit.state.themeMode, ThemeMode.dark);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets(
        'toggleTheme switches to ThemeMode.light when isDarkMode is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              cubit.toggleTheme(false);
              expect(cubit.state.themeMode, ThemeMode.light);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets(
        'changeLocale switches the language to Spanish when passed "es"',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              cubit.changeLocale(const Locale('es'));
              expect(cubit.state.locale, const Locale('es'));
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets(
        'changeLocale switches the language to Português when passed "pt"',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              cubit.changeLocale(const Locale('pt'));
              expect(cubit.state.locale, const Locale('pt'));
              return Container();
            },
          ),
        ),
      );
    });
  });
}
