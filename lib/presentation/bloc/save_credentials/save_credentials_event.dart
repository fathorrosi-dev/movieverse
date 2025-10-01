part of 'save_credentials_bloc.dart';

class SaveCredentialsEvent extends Equatable {
  final String email;
  final String password;

  const SaveCredentialsEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
