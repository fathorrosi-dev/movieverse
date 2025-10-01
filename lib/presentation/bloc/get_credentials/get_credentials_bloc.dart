import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/usecases/get_credentials.dart';
part 'get_credentials_event.dart';
part 'get_credentials_state.dart';

class GetCredentialsBloc
    extends Bloc<GetCredentialsEvent, GetCredentialsState> {
  final GetCredentials getCredentials;

  GetCredentialsBloc(this.getCredentials) : super(GetCredentialsInitial());

  Stream<GetCredentialsState> mapEventToState(
      GetCredentialsEvent event) async* {
    if (event is FetchCredentials) {
      yield GetCredentialsLoading();
      try {
        final email = await getCredentials.getEmail();
        final password = await getCredentials.getPassword();
        yield GetCredentialsSuccess(email ?? '', password ?? '');
      } catch (e) {
        yield GetCredentialsFailure(e.toString());
      }
    }
  }
}
