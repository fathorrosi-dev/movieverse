part of 'get_credentials_bloc.dart';

abstract class GetCredentialsEvent extends Equatable {
  const GetCredentialsEvent();

  @override
  List<Object> get props => [];
}

class FetchCredentials extends GetCredentialsEvent {}
