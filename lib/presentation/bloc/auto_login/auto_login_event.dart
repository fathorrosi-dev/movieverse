part of 'auto_login_bloc.dart';

abstract class AutoLoginEvent extends Equatable {
  const AutoLoginEvent();

  @override
  List<Object> get props => [];
}

class AutoLoginSuccess extends AutoLoginEvent {}

class AutoLoginStarted extends AutoLoginEvent {}
