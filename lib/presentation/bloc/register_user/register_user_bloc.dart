import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/usecases/register_user.dart';
import 'package:movieverse/utils/database_exceptions.dart';
import 'package:equatable/equatable.dart';

part 'register_user_event.dart';
part 'register_user_state.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  final RegisterUser registerUser;

  RegisterUserBloc(this.registerUser) : super(RegisterUserInitial()) {
    on<RegisterUserButtonPressed>(_onRegisterUserButtonPressed);
  }

  void _onRegisterUserButtonPressed(
    RegisterUserButtonPressed event,
    Emitter<RegisterUserState> emit,
  ) async {
    emit(RegisterUserLoading());

    try {
      await registerUser.execute(
        event.name,
        event.email,
        event.password,
      );
      emit(RegisterUserSuccess());
    } catch (e) {
      emit(RegisterUserFailure(DatabaseException(e.toString())));
    }
  }
}
