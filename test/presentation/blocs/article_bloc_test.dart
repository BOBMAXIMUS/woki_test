import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_article_app/domain/entities/article.dart';
import 'package:flutter_article_app/presentation/blocs/article_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/usecases/get_articles.mocks.dart';
import 'package:mockito/mockito.dart';

void main() {
  late ArticleBloc bloc;
  late MockGetArticles mockGetArticles;

  setUp(() {
    mockGetArticles = MockGetArticles();
    bloc = ArticleBloc(mockGetArticles);
  });

  test('initial state should be ArticleInitial', () {
    expect(bloc.state, equals(ArticleInitial()));
  });

  blocTest<ArticleBloc, ArticleState>(
    'emits [ArticleLoading, ArticleLoaded] when FetchArticles is added',
    build: () {
      when(mockGetArticles.call()).thenAnswer((_) async =>
          [const Article(id: 1, title: 'Test', body: 'Test Body')]);
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchArticles(
      articles: [
        Article(id: 1, title: 'Test', body: 'Test Body'),
      ],
    )),
    expect: () => [
      ArticleLoading(),
      const ArticleLoaded([Article(id: 1, title: 'Test', body: 'Test Body')]),
      if (bloc.state is ArticleError)
        const ArticleError('Failed to fetch articles'),
    ],
  );
}
