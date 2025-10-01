part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class AddToWatchlistLoading extends WatchlistState {}

class AddToWatchlistSuccess extends WatchlistState {
  final String messages;

  const AddToWatchlistSuccess(this.messages);

  @override
  List<Object> get props => [messages];
}

class AddToWatchlistFailure extends WatchlistState {
  final String messages;

  const AddToWatchlistFailure(this.messages);

  @override
  List<Object> get props => [messages];
}

class RemoveFromWatchlistLoading extends WatchlistState {}

class RemoveFromWatchlistSuccess extends WatchlistState {
  final String messages;

  const RemoveFromWatchlistSuccess(this.messages);

  @override
  List<Object> get props => [messages];
}

class RemoveFromWatchlistFailure extends WatchlistState {
  final String messages;

  const RemoveFromWatchlistFailure(this.messages);

  @override
  List<Object> get props => [messages];
}

class CheckWatchlistStatus extends WatchlistState {
  final bool isAddedToWatchlist;

  const CheckWatchlistStatus(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
