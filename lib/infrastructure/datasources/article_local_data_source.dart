import 'package:hive/hive.dart';

import '../models/article_model.dart';

class ArticleLocalDataSource {
  final Box<ArticleModel> articleBox;

  ArticleLocalDataSource(this.articleBox);

  Future<void> cacheArticles(List<ArticleModel> articles) async {
    await articleBox.clear();
    for (var article in articles) {
      await articleBox.put(article.id, article);
    }
  }

  Future<List<ArticleModel>> getCachedArticles() async {
    return articleBox.values.toList();
  }
}
