part of 'upcoming_movies_bloc.dart';

abstract class UpcomingMoviesState extends Equatable {}

class UpcomingMoviesEmpty extends UpcomingMoviesState {
  @override
  List<Object> get props => [];
}

class UpcomingMoviesLoading extends UpcomingMoviesState {
  @override
  List<Object> get props => [];
}

class UpcomingMoviesError extends UpcomingMoviesState {
  final String message;

  UpcomingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class UpcomingMoviesHasData extends UpcomingMoviesState {
  final List<Movie> result;

  UpcomingMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}
