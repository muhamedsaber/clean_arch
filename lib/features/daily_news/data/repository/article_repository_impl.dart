import 'dart:io';

import 'package:clean_arch/core/constants.dart';
import 'package:clean_arch/core/data/data_helper/data_state.dart';
import 'package:clean_arch/core/data/data_source/remote/web_service.dart';
import 'package:clean_arch/features/daily_news/domain/entity/article_entity.dart';
import 'package:clean_arch/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final WebService webService;
  ArticleRepositoryImpl(this.webService);
  @override
  Future<DataState<List<ArticleEntity>>> getArticles() async {
    try {
      final httpResopnse = await webService.getPopularMovies(
          apiKey: Constants.newsAPIKey,
          category: Constants.categoryQuery,
          country: Constants.countryQuery);
      if (httpResopnse.response.statusCode == HttpStatus.ok) {
        return DataState(data: httpResopnse.data);
      } else {
        return DataFailed(DioException(
            error: httpResopnse.response.statusMessage,
            response: httpResopnse.response,
            type: DioExceptionType.unknown,
            requestOptions: httpResopnse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
