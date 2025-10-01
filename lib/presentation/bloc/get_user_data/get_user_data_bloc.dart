import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/user_entity.dart';
import 'package:movieverse/domain/usecases/get_user_data.dart';
import 'package:movieverse/utils/database_exceptions.dart';

part 'get_user_data_event.dart';
part 'get_user_data_state.dart';

class GetUserDataBloc extends Bloc<GetUserDataEvent, GetUserDataState> {
  final GetUserData getUserData;

  GetUserDataBloc(this.getUserData) : super(GetUserDataInitial()) {
    on<GetUserDataRequested>(_getUserData);
  }

  void _getUserData(
      GetUserDataRequested event, Emitter<GetUserDataState> emit) async {
    emit(GetUserDataLoading());
    final result = await getUserData.execute();
    result.fold(
      (exception) => emit(GetUserDataFailure(exception)),
      (user) => emit(GetUserDataSuccess(user)),
    );
  }
}
