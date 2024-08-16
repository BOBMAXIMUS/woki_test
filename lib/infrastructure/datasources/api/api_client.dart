import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/article_model.dart';

class ArticleRemoteDataSource {
  final http.Client client;

  ArticleRemoteDataSource(this.client);

  Future<List<ArticleModel>> fetchArticles() async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ArticleModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
