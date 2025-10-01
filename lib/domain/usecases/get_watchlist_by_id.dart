import 'package:movieverse/domain/repositories/firebase_repository.dart';

class GetWatchlistById {
  final FirebaseRepository firrebaseRepository;

  GetWatchlistById(this.firrebaseRepository);

  Future<bool> execute(String id) {
    return firrebaseRepository.getWatchlistById(id);
  }
}
