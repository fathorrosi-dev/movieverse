import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/tv/tv_series.dart';
import 'package:movieverse/domain/usecases/tv/get_on_the_air_tv_series.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'on_the_air_tv_state.dart';
part 'on_the_air_tv_event.dart';

class OnTheAirTvBloc extends Bloc<OnTheAirTvEvent, OnTheAirTvState> {
  final GetOnTheAirTvSeries getOnTheAirTv;

  OnTheAirTvBloc(this.getOnTheAirTv) : super(OnTheAirTvEmpty()) {
    on<FetchOnTheAirTv>(_fetchOnTheAirTv);
  }

  void _fetchOnTheAirTv(
      FetchOnTheAirTv event, Emitter<OnTheAirTvState> emit) async {
    emit(OnTheAirTvLoading());
    final result = await getOnTheAirTv.execute();
    result.fold(
      (failure) =>
          emit(OnTheAirTvError(NetworkExceptions.getErrorMessage(failure))),
      (data) => emit(OnTheAirTvHasData(data)),
    );
  }
}
