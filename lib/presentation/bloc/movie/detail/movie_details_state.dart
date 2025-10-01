part of 'movie_details_bloc.dart';

abstract class MovieDetailsState extends Equatable {}

class MovieDetailsEmpty extends MovieDetailsState {
  @override
  List<Object> get props => [];
}

class MovieDetailsLoading extends MovieDetailsState {
  @override
  List<Object> get props => [];
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailsHasData extends MovieDetailsState {
  final MovieDetail movieDetails;
  final List<Movie> movieRecommendations;

  MovieDetailsHasData(this.movieDetails, this.movieRecommendations);

  @override
  List<Object> get props => [movieDetails, movieRecommendations];
}
