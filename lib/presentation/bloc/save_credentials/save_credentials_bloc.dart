import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/usecases/save_credentials.dart';
import 'package:equatable/equatable.dart';

part 'save_credentials_event.dart';
part 'save_credentials_state.dart';

class SaveCredentialsBloc
    extends Bloc<SaveCredentialsEvent, SaveCredentialsState> {
  final SaveCredentials saveCredentialsUseCase;

  SaveCredentialsBloc(this.saveCredentialsUseCase)
      : super(SaveCredentialsInitial()) {
    on<SaveCredentialsEvent>(_onSaveCredentialsEvent);
  }

  void _onSaveCredentialsEvent(
    SaveCredentialsEvent event,
    Emitter<SaveCredentialsState> emit,
  ) async {
    // Implement your logic here based on the event
    // For example, save credentials to the database
    emit(SaveCredentialsLoading());

    try {
      await saveCredentialsUseCase.execute(
        event.email,
        event.password,
      );
      emit(SaveCredentialsSuccess());
    } catch (error) {
      emit(SaveCredentialsFailure(error.toString()));
    }
  }
}
