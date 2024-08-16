import 'package:hive_flutter/hive_flutter.dart';

import 'models/article_model.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleModelAdapter());
  await Hive.openBox<ArticleModel>('articles');
}
