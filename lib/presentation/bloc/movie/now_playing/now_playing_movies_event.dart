part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {}

class FetchNowPlayingMovies extends NowPlayingMoviesEvent {
  @override
  List<Object> get props => [];
}
