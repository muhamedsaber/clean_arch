import 'package:clean_arch/config/database/cache/cache_helper.dart';
import 'package:clean_arch/config/routes/routes.dart';
import 'package:clean_arch/core/extensions/navigation.dart';
import 'package:clean_arch/core/injection/dependency_injection.dart';
import 'package:clean_arch/features/daily_news/data/model/article_model.dart';
import 'package:clean_arch/features/daily_news/presentation/logic/cubit/articles_cubit.dart';
import 'package:clean_arch/features/daily_news/presentation/widgets/article_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<ArticlesCubit>().getArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text(
          'Top Headlines',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.white70,
        shadowColor: Colors.black45,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white30],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          if (state is ArticlesStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ArticlesStateFailure) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is ArticlesStateSuccess) {
            return ListView.builder(
              itemCount: state.entities.length,
              itemBuilder: (context, index) {
                return ArticleCard(
                  model: state.entities[index] as ArticleModel,
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          onPressed: () async {
            List<ArticleModel> articles =
                await getIt<CacheFactory>().getAllArticles();
            print(articles.length);
            context.pushNamed(Routes.savedArticlesView);
          },
          icon: const Icon(Icons.library_books),
          color: Colors.white,
        ),
      ),
    );
  }
}
