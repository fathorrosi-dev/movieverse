import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/tv/tv_series.dart';
import 'package:movieverse/domain/usecases/tv/get_top_rated_tv_series.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'top_rated_tv_state.dart';
part 'top_rated_tv_event.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTvSeries getTopRatedTv;

  TopRatedTvBloc(this.getTopRatedTv) : super(TopRatedTvEmpty()) {
    on<FetchTopRatedTv>(_fetchTopRatedTv);
  }

  void _fetchTopRatedTv(
      FetchTopRatedTv event, Emitter<TopRatedTvState> emit) async {
    emit(TopRatedTvLoading());
    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) =>
          emit(TopRatedTvError(NetworkExceptions.getErrorMessage(failure))),
      (data) => emit(TopRatedTvHasData(data)),
    );
  }
}
