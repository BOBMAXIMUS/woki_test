import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_article_app/domain/entities/article.dart';
import 'package:flutter_article_app/presentation/blocs/article_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

class FakeArticleState extends Fake implements ArticleState {}

class FakeArticleEvent extends Fake implements ArticleEvent {}

class MockArticleBloc extends MockBloc<ArticleEvent, ArticleState>
    implements ArticleBloc {}

class MockBox extends Mock implements Box<Article> {}

class MockBuildContext extends Mock implements BuildContext {}

Future<Box<Article>> mockOpenLocalizedBox(BuildContext context) async {
  return MockBox();
}
