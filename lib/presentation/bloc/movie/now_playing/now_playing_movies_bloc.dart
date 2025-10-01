import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:movieverse/utils/network_exceptions.dart';
part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc(this.getNowPlayingMovies)
      : super(NowPlayingMoviesEmpty()) {
    on<FetchNowPlayingMovies>(_fetchNowPlayingMovies);
  }

  void _fetchNowPlayingMovies(
      FetchNowPlayingMovies event, Emitter<NowPlayingMoviesState> emit) async {
    emit(NowPlayingMoviesLoading());
    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) => emit(
          NowPlayingMoviesError(NetworkExceptions.getErrorMessage(failure))),
      (data) => emit(NowPlayingMoviesHasData(data)),
    );
  }
}
