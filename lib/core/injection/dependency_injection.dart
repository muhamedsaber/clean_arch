import 'package:clean_arch/config/database/cache/cache_helper.dart';
import 'package:clean_arch/core/networking/dio_factory.dart';
import 'package:clean_arch/core/web_service/web_service.dart';
import 'package:clean_arch/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:clean_arch/features/daily_news/presentation/logic/cubit/articles_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
setup() async {
  getIt.registerSingleton<Dio>(DioFactory.getDio());
  getIt.registerSingleton<WebService>(WebService(getIt()));
  getIt.registerSingleton<ArticleRepositoryImpl>(
      ArticleRepositoryImpl(webService: getIt()));
  getIt.registerSingleton<ArticlesCubit>(
      ArticlesCubit(getIt<ArticleRepositoryImpl>()));

  //cache setup
  await CacheFactory.getCache();
  getIt.registerSingleton<CacheFactory>(CacheFactory());
}
