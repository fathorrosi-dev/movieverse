part of 'get_user_data_bloc.dart';

abstract class GetUserDataEvent extends Equatable {
  const GetUserDataEvent();

  @override
  List<Object> get props => [];
}

class GetUserDataRequested extends GetUserDataEvent {}
