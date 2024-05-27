import 'package:clean_arch/config/routes/default_route.dart';
import 'package:clean_arch/config/routes/routes.dart';
import 'package:clean_arch/core/injection/dependency_injection.dart';
import 'package:clean_arch/features/daily_news/presentation/logic/cubit/articles_cubit.dart';
import 'package:clean_arch/features/daily_news/presentation/views/home_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.homeView:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => getIt<ArticlesCubit>(),
                child: const HomeView(),
              ));

    default:
      MaterialPageRoute(builder: (_) => const DefaultRoute());
  }
  return null;
}
