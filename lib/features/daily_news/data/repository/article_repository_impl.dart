import 'package:clean_arch/core/constants.dart';
import 'package:clean_arch/core/networking/api_error_handler.dart';
import 'package:clean_arch/core/networking/api_result.dart';
import 'package:clean_arch/core/web_service/web_service.dart';
import 'package:clean_arch/features/daily_news/data/model/article_model.dart';
import 'package:clean_arch/features/daily_news/domain/repository/article_repository.dart';
import 'package:retrofit/dio.dart';
class ArticleRepositoryImpl implements ArticleRepository {
  final WebService webService;

  ArticleRepositoryImpl({required this.webService});

  @override
  Future<ApiResult<List<ArticleModel>>> getArticles() async {
    try {
      HttpResponse httpResponse = await webService.getArticles(
          apiKey: Constants.newsAPIKey,
          category: Constants.categoryQuery,
          country: Constants.countryQuery);

      if (httpResponse.response.statusCode == 200) {
        // Assume the response.data is already a Map<String, dynamic>
        var data = httpResponse.data as Map<String, dynamic>;
        var articles = data['articles'] as List<dynamic>;
        var articleModels = articles.map((json) => ArticleModel.fromJson(json as Map<String, dynamic>)).toList();
        return ApiResult.success(articleModels);
      } else {
        return ApiResult.failure(ErrorHandler.handle(httpResponse.response.statusMessage));
      }
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}