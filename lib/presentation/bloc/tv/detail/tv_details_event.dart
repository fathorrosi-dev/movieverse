part of 'tv_details_bloc.dart';

abstract class TvDetailsEvent extends Equatable {}

class FetchTvDetails extends TvDetailsEvent {
  final int id;

  FetchTvDetails(this.id);

  @override
  List<Object> get props => [id];
}
