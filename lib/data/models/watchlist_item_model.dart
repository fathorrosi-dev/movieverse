import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:movieverse/domain/entities/watchlist_item.dart';

class WatchlistItemModel extends Equatable {
  final String id;
  final String name;
  final String posterPath;
  final String release;
  final bool isMovie;

  const WatchlistItemModel({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.release,
    required this.isMovie,
  });

  factory WatchlistItemModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return WatchlistItemModel(
        id: snapshot.id,
        name: data['name'],
        posterPath: data['posterPath'],
        release: data['release'],
        isMovie: data['isMovie']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'posterPath': posterPath,
      'release': release,
      'isMovie': isMovie,
    };
  }

  WatchlistItem toEntity() {
    return WatchlistItem(
        id: id,
        name: name,
        posterPath: posterPath,
        release: release,
        isMovie: isMovie);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        release,
        isMovie,
      ];
}
