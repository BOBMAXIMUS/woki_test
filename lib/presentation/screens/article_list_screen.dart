import 'package:flutter/material.dart';
import 'package:flutter_article_app/presentation/screens/article_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/article.dart';
import '../../infrastructure/datasources/hive_localization_helper.dart';
import '../blocs/article_bloc.dart';
import '../styles/app_styles.dart';
import 'settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Box<Article>>(
      future: openLocalizedBox(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppStyles.primaryColor,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: AppStyles.errorTextStyle(context),
              ),
            ),
          );
        } else {
          final articleBox = snapshot.data;
          final articles = articleBox!.values.toList();
          context.read<ArticleBloc>().add(
                FetchArticles(
                  articles: articles,
                ),
              );

          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.articles,
                style: AppStyles.appBarTitleStyle(context),
              ),
              backgroundColor: AppStyles.primaryColor,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: BlocBuilder<ArticleBloc, ArticleState>(
              builder: (context, state) {
                if (state is ArticleLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppStyles.primaryColor,
                    ),
                  );
                } else if (state is ArticleLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      final article = state.articles[index];
                      return Container(
                        decoration: AppStyles.cardDecoration(context),
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(
                            16.0,
                          ),
                          title: Text(
                            article.title,
                            style: AppStyles.articleTitleStyle(context),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: AppStyles.primaryColor,
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleDetailScreen(
                                article: article,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ArticleError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: AppStyles.errorTextStyle(context),
                    ),
                  );
                }
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.noArticles,
                    style: AppStyles.noArticlesTextStyle(context),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
