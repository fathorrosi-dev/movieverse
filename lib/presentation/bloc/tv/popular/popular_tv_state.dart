part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {}

class PopularTvEmpty extends PopularTvState {
  @override
  List<Object> get props => [];
}

class PopularTvLoading extends PopularTvState {
  @override
  List<Object> get props => [];
}

class PopularTvError extends PopularTvState {
  final String message;

  PopularTvError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvHasData extends PopularTvState {
  final List<TvSeries> result;

  PopularTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
