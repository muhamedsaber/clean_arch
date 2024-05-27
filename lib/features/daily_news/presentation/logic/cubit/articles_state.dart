part of 'articles_cubit.dart';

@freezed
class ArticlesState {}
class ArticlesStateInitial extends ArticlesState {
  
}
class ArticlesStateLoading extends ArticlesState {
  
}
class ArticlesStateSuccess extends ArticlesState {
   List<ArticleEntity>entities;
  ArticlesStateSuccess({required this.entities});
}
class ArticlesStateFailure extends ArticlesState {
  final String error;
  ArticlesStateFailure({required this.error});
}