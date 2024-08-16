import 'package:flutter/material.dart';

import '../../domain/entities/article.dart';
import '../styles/app_styles.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title,
          style: AppStyles.appBarTitleStyle(context),
        ),
        backgroundColor: AppStyles.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: AppStyles.detailTitleStyle(context),
            ),
            const SizedBox(height: 16.0),
            Text(
              article.body,
              style: AppStyles.bodyTextStyle(context),
            ),
          ],
        ),
      ),
    );
  }
}
