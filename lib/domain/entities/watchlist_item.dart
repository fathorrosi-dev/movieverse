import 'package:equatable/equatable.dart';

class WatchlistItem extends Equatable {
  final String? id;
  final String? name;
  final String? posterPath;
  final String? release;
  final bool? isMovie;

  const WatchlistItem({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.release,
    required this.isMovie,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        release,
        isMovie,
      ];
}
