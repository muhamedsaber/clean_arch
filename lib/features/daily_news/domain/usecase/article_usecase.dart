import 'package:clean_arch/core/data/data_helper/data_state.dart';
import 'package:clean_arch/core/usecase/usecase.dart';
import 'package:clean_arch/features/daily_news/domain/entity/article_entity.dart';
import 'package:clean_arch/features/daily_news/domain/repository/article_repository.dart';

class ArticleUseCase implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository repository;
  ArticleUseCase(this.repository);
  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return repository.getArticles();
  }
}
