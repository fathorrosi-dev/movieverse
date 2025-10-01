import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/domain/usecases/movie/search_movies.dart';
import 'package:movieverse/utils/network_exceptions.dart';
import 'package:rxdart/rxdart.dart';
part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MoviesSearchBloc extends Bloc<MoviesSearchEvent, MoviesSearchState> {
  final SearchMovies _searchMovies;

  MoviesSearchBloc(this._searchMovies) : super(MoviesSearchEmpty()) {
    on<MoviesOnQueryChanged>(_onChangedQuery,
        transformer: _debounce(const Duration(milliseconds: 500)));
  }

  void _onChangedQuery(
    MoviesOnQueryChanged event,
    Emitter<MoviesSearchState> emit,
  ) async {
    final query = event.query;
    emit(MoviesSearchLoading());

    final result = await _searchMovies.execute(query);

    result.fold(
      (failure) =>
          emit(MoviesSearchError(NetworkExceptions.getErrorMessage(failure))),
      (data) => emit(MoviesSearchHasData(data)),
    );
  }

  EventTransformer<MoviesOnQueryChanged> _debounce<MoviesOnQueryChanged>(
          Duration duration) =>
      (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}
