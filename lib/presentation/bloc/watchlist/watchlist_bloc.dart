import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieverse/domain/usecases/add_to_watchlist.dart';
import 'package:movieverse/domain/usecases/get_watchlist_by_id.dart';
import 'package:movieverse/domain/usecases/remove_from_watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistById getWatchlistById;
  final AddToWatchlist addToWatchlist;
  final RemoveFromWatchlist removeFromWatchlist;

  WatchlistBloc({
    required this.getWatchlistById,
    required this.addToWatchlist,
    required this.removeFromWatchlist,
  }) : super(WatchlistInitial()) {
    on<AddWatchlistItem>(_onAddWatchlistItem);
    on<RemoveWatchlistItem>(_onRemoveWatchlistItem);
    on<CheckWatchlist>(_onCheckWatchlistStatus);
  }

  void _onCheckWatchlistStatus(
    CheckWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    final result = await getWatchlistById.execute(event.id.toString());
    emit(CheckWatchlistStatus(result));
  }

  void _onAddWatchlistItem(
    AddWatchlistItem event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(AddToWatchlistLoading());
    final result = await addToWatchlist.execute(
        event.id, event.name, event.posterPath, event.release, event.isMovie);
    final status = await getWatchlistById.execute(event.id.toString());
    result.fold((failure) => emit(AddToWatchlistFailure(failure.message)),
        (success) {
      emit(AddToWatchlistSuccess(success));
      emit(CheckWatchlistStatus(status));
    });
  }

  void _onRemoveWatchlistItem(
    RemoveWatchlistItem event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(RemoveFromWatchlistLoading());
    final result = await removeFromWatchlist.execute(event.id);
    final status = await getWatchlistById.execute(event.id.toString());
    result.fold(
      (failure) => emit(RemoveFromWatchlistFailure(failure.message)),
      (success) {
        emit(RemoveFromWatchlistSuccess(success));
        emit(CheckWatchlistStatus(status));
      },
    );
  }
}
