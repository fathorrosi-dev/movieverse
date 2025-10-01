import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/domain/entities/movie/movie_detail.dart';
import 'package:movieverse/domain/usecases/movie/get_movie_detail.dart';
import 'package:movieverse/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailsBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
  }) : super((MovieDetailsEmpty())) {
    on<FetchMovieDetails>(_fetchMovieDetail);
  }

  void _fetchMovieDetail(
    FetchMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsLoading());
    final detailResult = await getMovieDetail.execute(event.id);
    final recommendationResult =
        await getMovieRecommendations.execute(event.id);
    detailResult.fold(
      (failure) =>
          emit(MovieDetailsError(NetworkExceptions.getErrorMessage(failure))),
      (detailMovie) {
        emit(MovieDetailsLoading());
        recommendationResult.fold(
          (failure) => emit(
              MovieDetailsError(NetworkExceptions.getErrorMessage(failure))),
          (recommendationMovies) => emit(
            MovieDetailsHasData(detailMovie, recommendationMovies),
          ),
        );
      },
    );
  }
}
