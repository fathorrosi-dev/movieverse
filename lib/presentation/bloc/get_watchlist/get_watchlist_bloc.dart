import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/watchlist_item.dart';
import 'package:movieverse/domain/usecases/get_watchlist.dart';
import 'package:movieverse/utils/database_exceptions.dart';
import 'package:equatable/equatable.dart';

part 'get_watchlist_event.dart';
part 'get_watchlist_state.dart';

class GetWatchlistBloc extends Bloc<GetWatchlistEvent, GetWatchlistState> {
  final GetWatchlist getWatchlist;

  GetWatchlistBloc(this.getWatchlist) : super(GetWatchlistLoading()) {
    on<FetchWatchlist>(_fetchWatchlist);
  }

  void _fetchWatchlist(FetchWatchlist event, Emitter emit) async {
    emit(GetWatchlistLoading());

    final result = await getWatchlist.execute();

    result.fold((failure) => emit(GetWatchlistFailure(failure)),
        (data) => emit(GetWatchlistSuccess(data)));
  }
}
