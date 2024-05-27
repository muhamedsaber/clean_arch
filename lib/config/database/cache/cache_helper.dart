import 'dart:convert';
import 'package:clean_arch/features/daily_news/data/model/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheFactory {
  static SharedPreferences? sharedPreferences;

  static Future<SharedPreferences> getCache() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    return sharedPreferences!;
  }

  Future<bool> storeArticle(ArticleModel article) async {
    String key = article.url.toString();
    List<String> keys = sharedPreferences?.getKeys().toList() ?? [];
    if (keys.contains(key)) {
      return false;
    } else {
      String jsonString = jsonEncode(article);
      sharedPreferences?.setString(article.url.toString(), jsonString);
      return true;
    }
  }

  Future<ArticleModel?> retrieveArticle(String url) async {
    String? jsonString = sharedPreferences?.getString(url);
    if (jsonString != null) {
      return ArticleModel.fromJson(jsonDecode(jsonString));
    } else {
      return null;
    }
  }

  Future<void> deleteObject(String key) async {
    sharedPreferences?.remove(key);
  }

  Future<void> clearCache() async {
    sharedPreferences?.clear();
  }

  Future<List<ArticleModel>> getAllArticles() async {
    List<String> keys = sharedPreferences?.getKeys().toList() ?? [];
    List<ArticleModel> articles = [];
    for (var key in keys) {
      String? jsonString = sharedPreferences?.getString(key);
      if (jsonString != null) {
        articles.add(ArticleModel.fromJson(jsonDecode(jsonString)));
      }
    }
    return articles;
  }
}
