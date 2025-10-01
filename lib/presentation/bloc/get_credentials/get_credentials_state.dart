part of 'get_credentials_bloc.dart';

abstract class GetCredentialsState extends Equatable {
  const GetCredentialsState();

  @override
  List<Object> get props => [];
}

class GetCredentialsInitial extends GetCredentialsState {}

class GetCredentialsLoading extends GetCredentialsState {}

class GetCredentialsSuccess extends GetCredentialsState {
  final String email;
  final String password;

  const GetCredentialsSuccess(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class GetCredentialsFailure extends GetCredentialsState {
  final String errorMessage;

  const GetCredentialsFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
