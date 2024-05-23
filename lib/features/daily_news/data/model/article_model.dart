import 'package:clean_arch/features/daily_news/domain/entity/article_entity.dart';

class ArticleModel extends ArticleEntity {
  ArticleModel({
    super.content,
    super.description,
    super.publishedAt,
    super.title,
    super.url,
    super.urlToImage,
  });
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      content: json['content'] ?? "",
      description: json['description'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
      title: json['title'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
    );
  }
}
