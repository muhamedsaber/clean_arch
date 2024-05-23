part of 'get_news_cubit.dart';

sealed class GetNewsState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? error;
  const GetNewsState({this.articles, this.error});
  @override
  List<Object?> get props => [articles, error];
}

final class GetLoadingState extends GetNewsState {
  const GetLoadingState();
}

final class GetSuccessState extends GetNewsState {
  const GetSuccessState(List<ArticleEntity> articles)
      : super(articles: articles);
}

final class GetFailedState extends GetNewsState {
  const GetFailedState(DioException error) : super(error: error);
}
