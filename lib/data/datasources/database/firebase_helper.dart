import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:movieverse/data/models/user_model.dart';
import 'package:movieverse/data/models/watchlist_item_model.dart';
import 'package:movieverse/utils/database_exceptions.dart';

abstract class FirebaseHelper {
  Future<void> registerUser(String name, String email, String password);
  Future<void> loginUser(String email, String password);
  Future<UserModel> getUserData();
  Future<String> addToWatchlist(
      String id, String name, String posterPath, String release, bool isMovie);
  Future<String> removeFromWatchlist(String id);
  Future<List<WatchlistItemModel>> getWatchlist();
  Future<bool> getWatchlistById(String id);
  Future<bool> getCurrentUser();
  Future<bool> logoutUser();
}

class FirebaseHelperImpl implements FirebaseHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  @override
  Future<bool> logoutUser() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e, stackTrace) {
      _logger.e('Error to logout', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  @override
  Future<bool> getCurrentUser() async {
    if (_auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> registerUser(String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
      });
    } catch (e, stackTrace) {
      _logger.e('Error during registration', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e, stackTrace) {
      _logger.e('Error during login', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<UserModel> getUserData() async {
    try {
      DocumentSnapshot snapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .get();

      return UserModel.fromDocumentSnapshot(snapshot);
    } catch (e, stackTrace) {
      _logger.e('Error getting user data', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<String> addToWatchlist(String id, String name, String posterPath,
      String release, bool isMovie) async {
    try {
      await _firestore
          .collection('watchlist')
          .doc(_auth.currentUser?.uid)
          .collection('data')
          .doc(id)
          .set({
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'release': release,
        'isMovie': isMovie,
      });

      return 'Added To Watchlist';
    } catch (e, stackTrace) {
      _logger.e('Error adding to watchlist', error: e, stackTrace: stackTrace);
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFromWatchlist(String id) async {
    try {
      await _firestore
          .collection('watchlist')
          .doc(_auth.currentUser?.uid)
          .collection('data')
          .doc(id)
          .delete();

      return 'Removed From Watchlist';
    } catch (e, stackTrace) {
      _logger.e('Error removing item from watchlist',
          error: e, stackTrace: stackTrace);
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<WatchlistItemModel>> getWatchlist() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('watchlist')
          .doc(_auth.currentUser?.uid)
          .collection('data')
          .get();

      List<WatchlistItemModel> watchlist = [];
      for (var doc in snapshot.docs) {
        watchlist.add(WatchlistItemModel.fromDocumentSnapshot(doc));
      }

      return watchlist;
    } catch (e, stackTrace) {
      _logger.e('Error getting watchlist', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<bool> getWatchlistById(String id) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('watchlist')
          .doc(_auth.currentUser?.uid)
          .collection('data')
          .where('id', isEqualTo: id)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      _logger.e('Error getting watchlist item', error: e);
      rethrow;
    }
  }
}
