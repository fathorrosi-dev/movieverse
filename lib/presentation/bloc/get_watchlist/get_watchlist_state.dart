part of 'get_watchlist_bloc.dart';

abstract class GetWatchlistState extends Equatable {
  const GetWatchlistState();

  @override
  List<Object> get props => [];
}

class GetWatchlistInitial extends GetWatchlistState {}

class GetWatchlistLoading extends GetWatchlistState {}

class GetWatchlistSuccess extends GetWatchlistState {
  final List<WatchlistItem> watchlist;

  const GetWatchlistSuccess(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

class GetWatchlistFailure extends GetWatchlistState {
  final DatabaseException exception;

  const GetWatchlistFailure(this.exception);

  @override
  List<Object> get props => [exception];
}
