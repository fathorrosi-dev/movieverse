part of 'save_credentials_bloc.dart';

abstract class SaveCredentialsState extends Equatable {
  const SaveCredentialsState();

  @override
  List<Object> get props => [];
}

class SaveCredentialsInitial extends SaveCredentialsState {}

class SaveCredentialsLoading extends SaveCredentialsState {}

class SaveCredentialsSuccess extends SaveCredentialsState {}

class SaveCredentialsFailure extends SaveCredentialsState {
  final String errorMessage;

  const SaveCredentialsFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
