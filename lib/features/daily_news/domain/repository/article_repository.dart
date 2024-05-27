import 'package:clean_arch/core/networking/api_result.dart';
import 'package:clean_arch/features/daily_news/domain/entity/article_entity.dart';

abstract class ArticleRepository{
  Future<ApiResult<List<ArticleEntity>>> getArticles();
}