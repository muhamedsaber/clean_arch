import 'package:clean_arch/core/data/data_helper/data_state.dart';
import 'package:clean_arch/features/daily_news/domain/entity/article_entity.dart';

abstract class ArticleRepository{
 Future<DataState<List<ArticleEntity>>>getArticles();
}