import 'package:flutter_article_app/domain/entities/article.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

Future<Box<Article>> openLocalizedBox(BuildContext context) async {
  final locale = Localizations.localeOf(context);
  final languageCode = locale.languageCode;

  final articleBox = await Hive.openBox<Article>('articles_$languageCode');
  return articleBox;
}
