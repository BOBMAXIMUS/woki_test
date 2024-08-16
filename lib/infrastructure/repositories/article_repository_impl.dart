import 'dart:async';
import 'dart:io';

import '../../domain/entities/article.dart';
import '../../domain/repositories/article_repository.dart';
import '../datasources/api/api_client.dart';
import '../datasources/article_local_data_source.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;
  final ArticleLocalDataSource localDataSource;

  final _articleStreamController = StreamController<List<Article>>.broadcast();

  ArticleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Article>> getArticles() async {
    try {
      final articles = await remoteDataSource.fetchArticles();
      await localDataSource.cacheArticles(articles);

      _articleStreamController.add(articles);

      return articles;
    } on SocketException {
      final cachedArticles = await localDataSource.getCachedArticles();

      _articleStreamController.add(cachedArticles);

      return cachedArticles;
    }
  }

  @override
  Stream<List<Article>> get articleStream => _articleStreamController.stream;

  void dispose() {
    _articleStreamController.close();
  }
}
