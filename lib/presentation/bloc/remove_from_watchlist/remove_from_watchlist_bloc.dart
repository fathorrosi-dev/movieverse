import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/repositories/firebase_repository.dart';
import 'package:movieverse/utils/database_exceptions.dart';
import 'package:equatable/equatable.dart';

part 'remove_from_watchlist_event.dart';
part 'remove_from_watchlist_state.dart';

class RemoveFromWatchlistBloc
    extends Bloc<RemoveFromWatchlistEvent, RemoveFromWatchlistState> {
  final FirebaseRepository repository;

  RemoveFromWatchlistBloc(this.repository)
      : super(RemoveFromWatchlistInitial()) {
    on<RemoveWatchlistItem>(_onRemoveWatchlistItem);
  }

  void _onRemoveWatchlistItem(
    RemoveWatchlistItem event,
    Emitter<RemoveFromWatchlistState> emit,
  ) async {
    emit(RemoveFromWatchlistLoading());
    final result = await repository.removeFromWatchlist(event.id);
    result.fold(
      (exception) => emit(RemoveFromWatchlistFailure(exception)),
      (_) => emit(RemoveFromWatchlistSuccess()),
    );
  }
}
