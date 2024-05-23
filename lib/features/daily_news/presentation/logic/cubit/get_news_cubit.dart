import 'package:bloc/bloc.dart';
import 'package:clean_arch/core/data/data_helper/data_state.dart';
import 'package:clean_arch/features/daily_news/domain/entity/article_entity.dart';
import 'package:clean_arch/features/daily_news/domain/usecase/article_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'get_news_state.dart';

class GetNewsCubit extends Cubit<GetNewsState> {
  GetNewsCubit(this.useCase) : super(const GetLoadingState());
  ArticleUseCase useCase;
  getArticles() async {
    emit(const GetLoadingState());
    await useCase.call().then((value) {
      if (value is DataSuccess) {
        emit(GetSuccessState(value.data ?? []));
      } else if (value is DataFailed) {
        emit(GetFailedState(value.error!));
      }
    });
  }
}
