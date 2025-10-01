part of 'remove_from_watchlist_bloc.dart';

abstract class RemoveFromWatchlistState extends Equatable {
  const RemoveFromWatchlistState();

  @override
  List<Object> get props => [];
}

class RemoveFromWatchlistInitial extends RemoveFromWatchlistState {}

class RemoveFromWatchlistLoading extends RemoveFromWatchlistState {}

class RemoveFromWatchlistSuccess extends RemoveFromWatchlistState {}

class RemoveFromWatchlistFailure extends RemoveFromWatchlistState {
  final DatabaseException exception;

  const RemoveFromWatchlistFailure(this.exception);

  @override
  List<Object> get props => [exception];
}
