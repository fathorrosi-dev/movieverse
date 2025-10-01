part of 'movie_search_bloc.dart';

abstract class MoviesSearchEvent extends Equatable {}

class MoviesOnQueryChanged extends MoviesSearchEvent {
  final String query;

  MoviesOnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
