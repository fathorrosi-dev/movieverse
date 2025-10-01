import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/usecases/auto_login.dart';

part 'auto_login_event.dart';
part 'auto_login_state.dart';

class AutoLoginBloc extends Bloc<AutoLoginEvent, AutoLoginState> {
  final AutoLogin autoLogin;

  AutoLoginBloc(this.autoLogin) : super(AutoLoginInitial()) {
    on<AutoLoginStarted>(_onAutoLoginStarted);
  }

  void _onAutoLoginStarted(
    AutoLoginStarted event,
    Emitter<AutoLoginState> emit,
  ) async {
    final isCompleted = await autoLogin.execute();
    if (isCompleted) {
      emit(AutoLoginSucced());
    } else {
      emit(AutoLoginProgress());
    }
  }
}
