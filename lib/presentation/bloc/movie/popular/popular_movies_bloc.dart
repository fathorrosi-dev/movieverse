import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/domain/usecases/movie/get_popular_movies.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'popular_movies_state.dart';
part 'popular_movies_event.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc(this.getPopularMovies) : super(PopularMoviesEmpty()) {
    on<FetchPopularMovies>(_fetchPopularMovies);
  }

  void _fetchPopularMovies(
      FetchPopularMovies event, Emitter<PopularMoviesState> emit) async {
    emit(PopularMoviesLoading());
    final result = await getPopularMovies.execute();
    result.fold(
      (failure) =>
          emit(PopularMoviesError(NetworkExceptions.getErrorMessage(failure))),
      (data) => emit(PopularMoviesHasData(data)),
    );
  }
}
