import 'package:flutter/material.dart';
import 'package:flutter_article_app/domain/entities/article.dart';
import 'package:flutter_article_app/presentation/screens/article_detail_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ArticleDetailScreen displays article details correctly',
      (WidgetTester tester) async {
    const article = Article(
      id: 1,
      title: 'Test Article',
      body: 'This is a test article body.',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: ArticleDetailScreen(article: article),
      ),
    );

    expect(find.text('Test Article'), findsNWidgets(2));
    expect(find.text('This is a test article body.'), findsOneWidget);
  });
}
