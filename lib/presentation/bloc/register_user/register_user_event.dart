part of 'register_user_bloc.dart';

abstract class RegisterUserEvent extends Equatable {
  const RegisterUserEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserButtonPressed extends RegisterUserEvent {
  final String name;
  final String email;
  final String password;

  const RegisterUserButtonPressed({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}
