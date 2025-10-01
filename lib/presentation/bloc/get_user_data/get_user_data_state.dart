part of 'get_user_data_bloc.dart';

abstract class GetUserDataState extends Equatable {
  const GetUserDataState();

  @override
  List<Object> get props => [];
}

class GetUserDataInitial extends GetUserDataState {}

class GetUserDataLoading extends GetUserDataState {}

class GetUserDataSuccess extends GetUserDataState {
  final UserEntity user;

  const GetUserDataSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class GetUserDataFailure extends GetUserDataState {
  final DatabaseException exception;

  const GetUserDataFailure(this.exception);

  @override
  List<Object> get props => [exception];
}
