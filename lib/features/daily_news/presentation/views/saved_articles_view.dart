import 'package:clean_arch/config/database/cache/cache_helper.dart';
import 'package:clean_arch/core/injection/dependency_injection.dart';
import 'package:clean_arch/features/daily_news/data/model/article_model.dart';
import 'package:flutter/material.dart';

class SavedArticlesView extends StatefulWidget {
  const SavedArticlesView({super.key});

  @override
  State<SavedArticlesView> createState() => _SavedArticlesViewState();
}

class _SavedArticlesViewState extends State<SavedArticlesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Saved Articles'),
        ),
        body: FutureBuilder(
          future: getIt<CacheFactory>().getAllArticles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              final articles = snapshot.data as List<ArticleModel>;
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return ListTile(
                    title: Text(article.title ?? ""),
                    subtitle: Text(article.description ?? ""),
                    trailing: IconButton(
                      onPressed: () {
                        getIt<CacheFactory>().deleteObject(article.url ?? "");
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Article deleted successfully'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
