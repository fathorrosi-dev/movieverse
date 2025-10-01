import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/tv/tv_series.dart';
import 'package:movieverse/domain/usecases/tv/get_discover_tv_series.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'discover_tv_state.dart';
part 'discover_tv_event.dart';

class DiscoverTvBloc extends Bloc<DiscoverTvEvent, DiscoverTvState> {
  final GetDiscoverTvSeries getDiscoverTv;

  DiscoverTvBloc(this.getDiscoverTv) : super(DiscoverTvEmpty()) {
    on<FetchDiscoverTv>(_fetchDiscoverTv);
  }

  void _fetchDiscoverTv(
      FetchDiscoverTv event, Emitter<DiscoverTvState> emit) async {
    emit(DiscoverTvLoading());
    final result = await getDiscoverTv.execute();
    result.fold(
      (failure) =>
          emit(DiscoverTvError(NetworkExceptions.getErrorMessage(failure))),
      (data) => emit(DiscoverTvHasData(data)),
    );
  }
}
