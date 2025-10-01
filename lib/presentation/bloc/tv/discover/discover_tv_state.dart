part of 'discover_tv_bloc.dart';

abstract class DiscoverTvState extends Equatable {}

class DiscoverTvEmpty extends DiscoverTvState {
  @override
  List<Object> get props => [];
}

class DiscoverTvLoading extends DiscoverTvState {
  @override
  List<Object> get props => [];
}

class DiscoverTvError extends DiscoverTvState {
  final String message;

  DiscoverTvError(this.message);

  @override
  List<Object> get props => [message];
}

class DiscoverTvHasData extends DiscoverTvState {
  final List<TvSeries> result;

  DiscoverTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
