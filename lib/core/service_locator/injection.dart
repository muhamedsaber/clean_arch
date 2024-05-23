import 'package:clean_arch/core/data/data_source/remote/web_service.dart';
import 'package:clean_arch/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:clean_arch/features/daily_news/domain/usecase/article_usecase.dart';
import 'package:clean_arch/features/daily_news/presentation/logic/cubit/get_news_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setup() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<WebService>(WebService(getIt()));
  getIt
      .registerSingleton<ArticleRepositoryImpl>(ArticleRepositoryImpl(getIt()));
  getIt.registerSingleton<ArticleUseCase>(ArticleUseCase(getIt()));
  getIt.registerSingleton(GetNewsCubit(getIt()));
}
