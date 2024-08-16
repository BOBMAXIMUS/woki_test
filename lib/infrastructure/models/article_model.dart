import 'package:hive/hive.dart';
import '../../domain/entities/article.dart';

part 'article_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel extends Article {
  @override
  @HiveField(0)
  final int id;

  @override
  @HiveField(1)
  final String title;

  @override
  @HiveField(2)
  final String body;

  const ArticleModel({
    required this.id,
    required this.title,
    required this.body,
  }) : super(id: id, title: title, body: body);

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
