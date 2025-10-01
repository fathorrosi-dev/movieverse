import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieverse/domain/usecases/logout_user.dart';

part 'logout_user_event.dart';
part 'logout_user_state.dart';

class LogoutUserBloc extends Bloc<LogoutUserEvent, LogoutUserState> {
  final LogoutUser logoutUser;

  LogoutUserBloc(this.logoutUser) : super(LogoutInitial()) {
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onLogoutRequested(
      LogoutRequested event, Emitter<LogoutUserState> emit) async {
    emit(LogoutLoading());

    try {
      final result = await logoutUser.execute();
      if (result) {
        emit(LogoutSuccess());
      } else {
        emit(LogoutError());
      }
    } catch (e) {
      emit(LogoutError());
    }
  }
}
