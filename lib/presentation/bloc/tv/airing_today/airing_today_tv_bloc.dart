import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/tv/tv_series.dart';
import 'package:movieverse/domain/usecases/tv/get_airing_today_tv_series.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'airing_today_tv_event.dart';
part 'airing_today_tv_state.dart';

class AiringTodayTvBloc extends Bloc<AiringTodayTvEvent, AiringTodayTvState> {
  final GetAiringTodayTvSeries getAiringTodayTv;

  AiringTodayTvBloc(this.getAiringTodayTv) : super(AiringTodayTvEmpty()) {
    on<FetchAiringTodayTv>(_fetchAiringTodayTv);
  }

  void _fetchAiringTodayTv(
      FetchAiringTodayTv event, Emitter<AiringTodayTvState> emit) async {
    emit(AiringTodayTvLoading());
    final result = await getAiringTodayTv.execute();
    result.fold(
      (failure) =>
          emit(AiringTodayTvError(NetworkExceptions.getErrorMessage(failure))),
      (data) => emit(AiringTodayTvHasData(data)),
    );
  }
}
