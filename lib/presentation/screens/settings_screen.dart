import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubits/theme_and_localization_cubit.dart';
import '../styles/app_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: AppStyles.appBarTitleStyle(context),
        ),
        backgroundColor: AppStyles.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ThemeAndLocalizationCubit, ThemeAndLocalizationState>(
              builder: (context, state) {
                return SwitchListTile(
                  title: Text(
                    AppLocalizations.of(context)!.darkMode,
                    style: AppStyles.settingsTitleStyle(context),
                  ),
                  value: state.themeMode == ThemeMode.dark,
                  activeColor: AppStyles.primaryColor,
                  onChanged: (value) => context
                      .read<ThemeAndLocalizationCubit>()
                      .toggleTheme(value),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.changeLanguage,
              style: AppStyles.settingsTitleStyle(context),
            ),
            ListTile(
              title: Text(
                'English',
                style: AppStyles.listTileTitleStyle(context),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AppStyles.primaryColor,
              ),
              onTap: () => context
                  .read<ThemeAndLocalizationCubit>()
                  .changeLocale(const Locale('en')),
            ),
            ListTile(
              title: Text(
                'Español',
                style: AppStyles.listTileTitleStyle(context),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AppStyles.primaryColor,
              ),
              onTap: () => context
                  .read<ThemeAndLocalizationCubit>()
                  .changeLocale(const Locale('es')),
            ),
            ListTile(
              title: Text(
                'Português',
                style: AppStyles.listTileTitleStyle(context),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AppStyles.primaryColor,
              ),
              onTap: () => context
                  .read<ThemeAndLocalizationCubit>()
                  .changeLocale(const Locale('pt')),
            ),
          ],
        ),
      ),
    );
  }
}
