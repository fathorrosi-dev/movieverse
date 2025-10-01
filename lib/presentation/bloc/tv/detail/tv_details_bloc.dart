import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/tv/tv_series.dart';
import 'package:movieverse/domain/entities/tv/tv_series_detail.dart';
import 'package:movieverse/domain/usecases/tv/get_tv_series_detail.dart';
import 'package:movieverse/domain/usecases/tv/get_tv_series_recommendations.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'tv_details_event.dart';
part 'tv_details_state.dart';

class TvDetailsBloc extends Bloc<TvDetailsEvent, TvDetailsState> {
  final GetTvSeriesDetail getTvDetail;
  final GetTvSeriesRecommendations getTvRecommendations;

  TvDetailsBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
  }) : super((TvDetailsEmpty())) {
    on<FetchTvDetails>(_fetchTvDetail);
  }

  void _fetchTvDetail(
    FetchTvDetails event,
    Emitter<TvDetailsState> emit,
  ) async {
    emit(TvDetailsLoading());
    final detailResult = await getTvDetail.execute(event.id);
    final recommendationResult = await getTvRecommendations.execute(event.id);
    detailResult.fold(
      (failure) =>
          emit(TvDetailsError(NetworkExceptions.getErrorMessage(failure))),
      (detailTv) {
        emit(TvDetailsLoading());
        recommendationResult.fold(
          (failure) =>
              emit(TvDetailsError(NetworkExceptions.getErrorMessage(failure))),
          (recommendationTvs) => emit(
            TvDetailsHasData(detailTv, recommendationTvs),
          ),
        );
      },
    );
  }
}
