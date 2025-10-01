part of 'auto_login_bloc.dart';

abstract class AutoLoginState extends Equatable {
  const AutoLoginState();

  @override
  List<Object> get props => [];
}

class AutoLoginInitial extends AutoLoginState {}

class AutoLoginProgress extends AutoLoginState {}

class AutoLoginSucced extends AutoLoginState {}
