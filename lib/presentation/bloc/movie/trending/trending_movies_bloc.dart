import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/domain/usecases/movie/get_trending_movies.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'trending_movies_event.dart';
part 'trending_movies_state.dart';

class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  final GetTrendingMovies getTrendingMovies;

  TrendingMoviesBloc(this.getTrendingMovies) : super(TrendingMoviesEmpty()) {
    on<FetchTrendingMovies>(_fetchTrendingMovies);
  }

  void _fetchTrendingMovies(
      FetchTrendingMovies event, Emitter<TrendingMoviesState> emit) async {
    emit(TrendingMoviesLoading());
    final result = await getTrendingMovies.execute();
    result.fold(
      (failure) =>
          emit(TrendingMoviesError(NetworkExceptions.getErrorMessage(failure))),
      (data) => emit(TrendingMoviesHasData(data)),
    );
  }
}
