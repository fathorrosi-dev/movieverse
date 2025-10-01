part of 'tv_search_bloc.dart';

abstract class TvSearchState extends Equatable {}

class TvSearchEmpty extends TvSearchState {
  @override
  List<Object> get props => [];
}

class TvSearchLoading extends TvSearchState {
  @override
  List<Object> get props => [];
}

class TvSearchError extends TvSearchState {
  final String message;

  TvSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSearchHasData extends TvSearchState {
  final List<TvSeries> result;

  TvSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
