part of 'login_user_bloc.dart';

abstract class LoginUserState extends Equatable {
  const LoginUserState();

  @override
  List<Object> get props => [];
}

class LoginUserInitial extends LoginUserState {}

class LoginUserLoading extends LoginUserState {}

class LoginUserSuccess extends LoginUserState {}

class LoginUserFailure extends LoginUserState {
  final DatabaseException exception;

  const LoginUserFailure(this.exception);

  @override
  List<Object> get props => [exception];
}
