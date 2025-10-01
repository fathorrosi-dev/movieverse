import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/tv/tv_series.dart';
import 'package:movieverse/domain/usecases/tv/get_popular_tv_series.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'popular_tv_state.dart';
part 'popular_tv_event.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvSeries getPopularTv;

  PopularTvBloc(this.getPopularTv) : super(PopularTvEmpty()) {
    on<FetchPopularTv>(_fetchPopularTv);
  }

  void _fetchPopularTv(
      FetchPopularTv event, Emitter<PopularTvState> emit) async {
    emit(PopularTvLoading());
    final result = await getPopularTv.execute();
    result.fold(
      (failure) =>
          emit(PopularTvError(NetworkExceptions.getErrorMessage(failure))),
      (data) => emit(PopularTvHasData(data)),
    );
  }
}
