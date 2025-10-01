part of 'trending_tv_bloc.dart';

abstract class TrendingTvState extends Equatable {}

class TrendingTvEmpty extends TrendingTvState {
  @override
  List<Object> get props => [];
}

class TrendingTvLoading extends TrendingTvState {
  @override
  List<Object> get props => [];
}

class TrendingTvError extends TrendingTvState {
  final String message;

  TrendingTvError(this.message);

  @override
  List<Object> get props => [message];
}

class TrendingTvHasData extends TrendingTvState {
  final List<TvSeries> result;

  TrendingTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
