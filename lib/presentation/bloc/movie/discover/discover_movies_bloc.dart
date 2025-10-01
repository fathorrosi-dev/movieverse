import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/domain/usecases/movie/get_discover_movies.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'discover_movies_event.dart';
part 'discover_movies_state.dart';

class DiscoverMoviesBloc
    extends Bloc<DiscoverMoviesEvent, DiscoverMoviesState> {
  final GetDiscoverMovies getDiscoverMovies;

  DiscoverMoviesBloc(this.getDiscoverMovies) : super(DiscoverMoviesEmpty()) {
    on<FetchDiscoverMovies>(_fetchDiscoverMovies);
  }

  void _fetchDiscoverMovies(
      FetchDiscoverMovies event, Emitter<DiscoverMoviesState> emit) async {
    emit(DiscoverMoviesLoading());
    final result = await getDiscoverMovies.execute();
    result.fold(
      (failure) =>
          emit(DiscoverMoviesError(NetworkExceptions.getErrorMessage(failure))),
      (data) => emit(DiscoverMoviesHasData(data)),
    );
  }
}
