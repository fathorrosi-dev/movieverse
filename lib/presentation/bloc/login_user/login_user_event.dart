part of 'login_user_bloc.dart';

abstract class LoginUserEvent extends Equatable {
  const LoginUserEvent();

  @override
  List<Object> get props => [];
}

class LoginUserButtonPressed extends LoginUserEvent {
  final String email;
  final String password;

  const LoginUserButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
