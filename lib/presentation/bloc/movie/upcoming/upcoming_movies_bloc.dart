import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/domain/usecases/movie/get_upcoming_movies.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'upcoming_movies_event.dart';
part 'upcoming_movies_state.dart';

class UpcomingMoviesBloc
    extends Bloc<UpcomingMoviesEvent, UpcomingMoviesState> {
  final GetUpcomingMovies getUpcomingMovies;

  UpcomingMoviesBloc(this.getUpcomingMovies) : super(UpcomingMoviesEmpty()) {
    on<FetchUpcomingMovies>(_fetchUpcomingMovies);
  }

  void _fetchUpcomingMovies(
      FetchUpcomingMovies event, Emitter<UpcomingMoviesState> emit) async {
    emit(UpcomingMoviesLoading());
    final result = await getUpcomingMovies.execute();
    result.fold(
      (failure) =>
          emit(UpcomingMoviesError(NetworkExceptions.getErrorMessage(failure))),
      (data) => emit(UpcomingMoviesHasData(data)),
    );
  }
}
