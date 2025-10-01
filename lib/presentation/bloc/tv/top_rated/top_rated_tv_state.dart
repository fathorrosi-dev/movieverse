part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {}

class TopRatedTvEmpty extends TopRatedTvState {
  @override
  List<Object> get props => [];
}

class TopRatedTvLoading extends TopRatedTvState {
  @override
  List<Object> get props => [];
}

class TopRatedTvError extends TopRatedTvState {
  final String message;

  TopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvHasData extends TopRatedTvState {
  final List<TvSeries> result;

  TopRatedTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
