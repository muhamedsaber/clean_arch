import 'package:bloc/bloc.dart';
import 'package:clean_arch/features/daily_news/domain/entity/article_entity.dart';
import 'package:clean_arch/features/daily_news/domain/repository/article_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit(this._articleRepository) : super(ArticlesState());
  final ArticleRepository _articleRepository;
  getArticles() async {
    emit(ArticlesStateLoading());

    final result = await _articleRepository.getArticles();
    result.when(
      success: (articles) {
        emit(ArticlesStateSuccess(entities: articles));
      },
      failure: (error) {
        emit(ArticlesStateFailure(
            error: error.apiErrorModel.message ?? "Error"));
      },
    );
  }
}
