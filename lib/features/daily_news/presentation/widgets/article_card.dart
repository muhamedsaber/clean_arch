import 'package:clean_arch/config/database/cache/cache_helper.dart';
import 'package:clean_arch/core/constants.dart';
import 'package:clean_arch/core/injection/dependency_injection.dart';
import 'package:clean_arch/features/daily_news/data/model/article_model.dart';
import 'package:clean_arch/features/daily_news/presentation/widgets/article_sheet_content.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.model});
  final ArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: FadeInImage.assetNetwork(
                    placeholder: Constants.kLoadingGiff,
                    image: model.urlToImage ?? Constants.kDefaultImage,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        Constants.kDefaultImage,
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {
                      addArticleToCache(model, context);
                    },
                    icon: Icon(Icons.book),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    model.description ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDate(model.publishedAt ?? ""),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          openArticle(context, model);
                        },
                        child: Text(
                          "Read More",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String date) {
    try {
      final DateTime dateTime = DateTime.parse(date);
      return DateFormat.yMMMMd().format(dateTime);
    } catch (e) {
      return "";
    }
  }

  void openArticle(BuildContext context, ArticleModel model) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return ArticleContentSheet(model: model);
      },
    );
  }

  addArticleToCache(ArticleModel model, BuildContext context) async {
    try {
      bool isKeyExist = await getIt<CacheFactory>().storeArticle(model);
      if (isKeyExist) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Article already saved"),
          ),
        );
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Article saved successfully"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("could not save article"),
        ),
      );
    }
  }
}
