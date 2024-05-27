import 'package:clean_arch/core/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'web_service.g.dart';

@RestApi(baseUrl: Constants.newsAPIBaseURL)
abstract class WebService {
  factory WebService(Dio dio) = _WebService;

  @GET('/top-headlines')
  Future<HttpResponse> getArticles({
    @Query('country') String? country,
    @Query('category') String? category,
    @Query('apiKey') String? apiKey,
  });
}
