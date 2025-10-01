part of 'trending_movies_bloc.dart';

abstract class TrendingMoviesState extends Equatable {}

class TrendingMoviesEmpty extends TrendingMoviesState {
  @override
  List<Object> get props => [];
}

class TrendingMoviesLoading extends TrendingMoviesState {
  @override
  List<Object> get props => [];
}

class TrendingMoviesError extends TrendingMoviesState {
  final String message;

  TrendingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class TrendingMoviesHasData extends TrendingMoviesState {
  final List<Movie> result;

  TrendingMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}
