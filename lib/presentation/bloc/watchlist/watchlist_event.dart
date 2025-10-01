part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistItem extends WatchlistEvent {
  final String id;
  final String name;
  final String posterPath;
  final String release;
  final bool isMovie;

  const AddWatchlistItem(
      this.id, this.name, this.posterPath, this.release, this.isMovie);

  @override
  List<Object> get props => [id, name, posterPath, release, isMovie];
}

class RemoveWatchlistItem extends WatchlistEvent {
  final String id;

  const RemoveWatchlistItem(this.id);

  @override
  List<Object> get props => [id];
}

class CheckWatchlist extends WatchlistEvent {
  final int id;

  const CheckWatchlist(this.id);

  @override
  List<Object> get props => [id];
}
