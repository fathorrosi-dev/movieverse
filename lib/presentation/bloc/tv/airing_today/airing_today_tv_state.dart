part of 'airing_today_tv_bloc.dart';

abstract class AiringTodayTvState extends Equatable {}

class AiringTodayTvEmpty extends AiringTodayTvState {
  @override
  List<Object> get props => [];
}

class AiringTodayTvLoading extends AiringTodayTvState {
  @override
  List<Object> get props => [];
}

class AiringTodayTvError extends AiringTodayTvState {
  final String message;

  AiringTodayTvError(this.message);

  @override
  List<Object> get props => [message];
}

class AiringTodayTvHasData extends AiringTodayTvState {
  final List<TvSeries> result;

  AiringTodayTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
