import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/tv/tv_series.dart';
import 'package:movieverse/domain/usecases/tv/get_trending_tv_series.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'trending_tv_state.dart';
part 'trending_tv_event.dart';

class TrendingTvBloc extends Bloc<TrendingTvEvent, TrendingTvState> {
  final GetTrendingTvSeries getTrendingTv;

  TrendingTvBloc(this.getTrendingTv) : super(TrendingTvEmpty()) {
    on<FetchTrendingTv>(_fetchTrendingTv);
  }

  void _fetchTrendingTv(
      FetchTrendingTv event, Emitter<TrendingTvState> emit) async {
    emit(TrendingTvLoading());
    final result = await getTrendingTv.execute();
    result.fold(
      (failure) =>
          emit(TrendingTvError(NetworkExceptions.getErrorMessage(failure))),
      (data) => emit(TrendingTvHasData(data)),
    );
  }
}
