part of 'logout_user_bloc.dart';

abstract class LogoutUserState extends Equatable {
  const LogoutUserState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutUserState {}

class LogoutLoading extends LogoutUserState {}

class LogoutSuccess extends LogoutUserState {}

class LogoutError extends LogoutUserState {}
