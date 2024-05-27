import 'package:clean_arch/features/daily_news/domain/entity/article_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'article_model.g.dart';
@JsonSerializable()
class ArticleModel extends ArticleEntity {
  ArticleModel({
    required super.title,
    required super.description,
    required super.url,
    required super.urlToImage,
    required super.publishedAt,
  });
  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
