import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/repositories/firebase_repository.dart';
import 'package:movieverse/utils/database_exceptions.dart';

part 'login_user_event.dart';
part 'login_user_state.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  final FirebaseRepository repository;

  LoginUserBloc(this.repository) : super(LoginUserInitial()) {
    on<LoginUserButtonPressed>(_onLoginUserButtonPressed);
  }

  void _onLoginUserButtonPressed(
    LoginUserButtonPressed event,
    Emitter<LoginUserState> emit,
  ) async {
    emit(LoginUserLoading());
    final result = await repository.loginUser(
      event.email,
      event.password,
    );
    result.fold(
      (exception) => emit(LoginUserFailure(exception)),
      (_) => emit(LoginUserSuccess()),
    );
  }
}
