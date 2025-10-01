part of 'register_user_bloc.dart';

abstract class RegisterUserState extends Equatable {
  const RegisterUserState();

  @override
  List<Object> get props => [];
}

class RegisterUserInitial extends RegisterUserState {}

class RegisterUserLoading extends RegisterUserState {}

class RegisterUserSuccess extends RegisterUserState {}

class RegisterUserFailure extends RegisterUserState {
  final DatabaseException exception;

  const RegisterUserFailure(this.exception);

  @override
  List<Object> get props => [exception];
}
