import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'top_rated_movies_state.dart';
part 'top_rated_movies_event.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc(this.getTopRatedMovies) : super(TopRatedMoviesEmpty()) {
    on<FetchTopRatedMovies>(_fetchTopRatedMovies);
  }

  void _fetchTopRatedMovies(
      FetchTopRatedMovies event, Emitter<TopRatedMoviesState> emit) async {
    emit(TopRatedMoviesLoading());
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) =>
          emit(TopRatedMoviesError(NetworkExceptions.getErrorMessage(failure))),
      (data) => emit(TopRatedMoviesHasData(data)),
    );
  }
}
