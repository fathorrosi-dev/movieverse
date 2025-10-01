part of 'remove_from_watchlist_bloc.dart';

abstract class RemoveFromWatchlistEvent extends Equatable {
  const RemoveFromWatchlistEvent();

  @override
  List<Object> get props => [];
}

class RemoveWatchlistItem extends RemoveFromWatchlistEvent {
  final String id;

  const RemoveWatchlistItem(this.id);

  @override
  List<Object> get props => [id];
}
