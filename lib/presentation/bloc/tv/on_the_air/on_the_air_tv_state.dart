part of 'on_the_air_tv_bloc.dart';

abstract class OnTheAirTvState extends Equatable {}

class OnTheAirTvEmpty extends OnTheAirTvState {
  @override
  List<Object> get props => [];
}

class OnTheAirTvLoading extends OnTheAirTvState {
  @override
  List<Object> get props => [];
}

class OnTheAirTvError extends OnTheAirTvState {
  final String message;

  OnTheAirTvError(this.message);

  @override
  List<Object> get props => [message];
}

class OnTheAirTvHasData extends OnTheAirTvState {
  final List<TvSeries> result;

  OnTheAirTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
