import 'package:flutter_article_app/infrastructure/datasources/api/api_client.dart';
import 'package:flutter_article_app/infrastructure/models/article_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../mocks/datasources/api/api_client.dart';

void main() {
  late ArticleRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ArticleRemoteDataSource(mockHttpClient);
  });

  group('fetchArticles', () {
    test('should return a list of articles when the call is successful',
        () async {
      final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      const responsePayload = '[{"id":1,"title":"Test","body":"Test Body"}]';

      when(() => mockHttpClient.get(uri))
          .thenAnswer((_) async => http.Response(responsePayload, 200));
      final result = await dataSource.fetchArticles();

      expect(result, isA<List<ArticleModel>>());
      expect(result.length, 1);
      expect(result[0].title, 'Test');
    });

    test('should throw an exception when the call is unsuccessful', () async {
      final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');

      when(() => mockHttpClient.get(uri))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.fetchArticles();

      expect(() => call, throwsA(isA<Exception>()));
    });
  });
}
