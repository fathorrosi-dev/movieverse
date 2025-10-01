part of 'upcoming_movies_bloc.dart';

abstract class UpcomingMoviesEvent extends Equatable {}

class FetchUpcomingMovies extends UpcomingMoviesEvent {
  @override
  List<Object> get props => [];
}
