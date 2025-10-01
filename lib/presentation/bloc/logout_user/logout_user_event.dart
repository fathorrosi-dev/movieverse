part of 'logout_user_bloc.dart';

abstract class LogoutUserEvent extends Equatable {
  const LogoutUserEvent();

  @override
  List<Object> get props => [];
}

class LogoutRequested extends LogoutUserEvent {}
