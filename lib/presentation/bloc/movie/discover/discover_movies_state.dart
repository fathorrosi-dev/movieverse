part of 'discover_movies_bloc.dart';

abstract class DiscoverMoviesState extends Equatable {}

class DiscoverMoviesEmpty extends DiscoverMoviesState {
  @override
  List<Object> get props => [];
}

class DiscoverMoviesLoading extends DiscoverMoviesState {
  @override
  List<Object> get props => [];
}

class DiscoverMoviesError extends DiscoverMoviesState {
  final String message;

  DiscoverMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class DiscoverMoviesHasData extends DiscoverMoviesState {
  final List<Movie> result;

  DiscoverMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}
