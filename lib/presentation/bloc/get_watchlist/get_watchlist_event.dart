part of 'get_watchlist_bloc.dart';

abstract class GetWatchlistEvent extends Equatable {
  const GetWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlist extends GetWatchlistEvent {}
