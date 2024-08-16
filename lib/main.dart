import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'domain/usecases/get_articles.dart';
import 'infrastructure/datasources/api/api_client.dart';
import 'infrastructure/datasources/article_local_data_source.dart';
import 'infrastructure/hive_init.dart';
import 'infrastructure/models/article_model.dart';
import 'infrastructure/repositories/article_repository_impl.dart';
import 'presentation/blocs/article_bloc.dart';
import 'presentation/cubits/theme_and_localization_cubit.dart';
import 'presentation/screens/article_list_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'presentation/styles/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHive();

  final httpClient = http.Client();
  final apiClient = ArticleRemoteDataSource(httpClient);
  final articleBox = Hive.box<ArticleModel>('articles');
  final localDataSource = ArticleLocalDataSource(articleBox);
  final repository = ArticleRepositoryImpl(
    remoteDataSource: apiClient,
    localDataSource: localDataSource,
  );
  final getArticles = GetArticles(repository);

  runApp(MyApp(getArticles: getArticles));
}

class MyApp extends StatelessWidget {
  final GetArticles getArticles;

  const MyApp({super.key, required this.getArticles});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeAndLocalizationCubit(),
        ),
        BlocProvider(
          create: (context) => ArticleBloc(getArticles),
        ),
      ],
      child: BlocBuilder<ThemeAndLocalizationCubit, ThemeAndLocalizationState>(
        builder: (context, state) {
          return MaterialApp(
            title: AppLocalizations.of(context)?.appTitle ?? '',
            theme: AppThemes.lightTheme(context),
            darkTheme: AppThemes.darkTheme(context),
            themeMode: state.themeMode,
            locale: state.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: const ArticleListScreen(),
          );
        },
      ),
    );
  }
}
