part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent extends Equatable {}

class FetchMovieDetails extends MovieDetailsEvent {
  final int id;

  FetchMovieDetails(this.id);

  @override
  List<Object> get props => [id];
}
