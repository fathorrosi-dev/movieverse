part of 'tv_details_bloc.dart';

abstract class TvDetailsState extends Equatable {}

class TvDetailsEmpty extends TvDetailsState {
  @override
  List<Object> get props => [];
}

class TvDetailsLoading extends TvDetailsState {
  @override
  List<Object> get props => [];
}

class TvDetailsError extends TvDetailsState {
  final String message;

  TvDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailsHasData extends TvDetailsState {
  final TvSeriesDetail tvSeriesDetail;
  final List<TvSeries> tvSeriesRecomendation;

  TvDetailsHasData(this.tvSeriesDetail, this.tvSeriesRecomendation);

  @override
  List<Object> get props => [tvSeriesDetail, tvSeriesRecomendation];
}

class AddWatchlist extends TvDetailsState {
  final String message;

  AddWatchlist(this.message);

  @override
  List<Object> get props => [message];
}

class RemoveWatchlist extends TvDetailsState {
  final String message;

  RemoveWatchlist(this.message);

  @override
  List<Object> get props => [message];
}
