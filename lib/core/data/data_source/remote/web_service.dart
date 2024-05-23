import 'package:clean_arch/core/constants.dart';
import 'package:clean_arch/features/daily_news/data/model/article_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
part 'web_service.g.dart';

@RestApi(baseUrl: Constants.newsAPIBaseURL)
abstract class WebService {
  factory WebService(Dio dio) = _WebService;

  @GET("/movie/popular")
  Future<HttpResponse<List<ArticleModel>>> getPopularMovies({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
}
