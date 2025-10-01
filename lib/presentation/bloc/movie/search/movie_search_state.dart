part of 'movie_search_bloc.dart';

abstract class MoviesSearchState extends Equatable {}

class MoviesSearchEmpty extends MoviesSearchState {
  @override
  List<Object> get props => [];
}

class MoviesSearchLoading extends MoviesSearchState {
  @override
  List<Object> get props => [];
}

class MoviesSearchError extends MoviesSearchState {
  final String message;

  MoviesSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesSearchHasData extends MoviesSearchState {
  final List<Movie> result;

  MoviesSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
