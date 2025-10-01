import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/utils/constant.dart';
import 'package:flutter/material.dart';

class MovieCardList extends StatelessWidget {
  final Movie movie;

  const MovieCardList(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          context.push('/movieDetailScreen/${movie.id}');
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              color: $styles.theme.cardColor,
              child: Container(
                color: $styles.theme.cardColor,
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: $styles.text.labelLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      movie.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: $styles.theme.neutralColor),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImgUrl${movie.posterPath}',
                  width: 80,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
