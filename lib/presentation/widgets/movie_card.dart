import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/logic/convert_to_percentage.dart';
import 'package:movieverse/logic/format_date.dart';
import 'package:movieverse/logic/vote_average_convert.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/utils/constant.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MovieCard extends StatelessWidget {
  final List<Movie> movies;

  const MovieCard(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Card(
            margin: const EdgeInsets.only(left: 16),
            color: $styles.theme.cardColor,
            child: InkWell(
              splashColor: Colors.blueAccent.withAlpha(30),
              onTap: () {
                context.push('/movieDetailScreen/${movie.id}');
              },
              child: SizedBox(
                width: 190,
                height: 370,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 190,
                          height: 257,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "$baseImgUrl${movie.posterPath}",
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blueAccent,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Gap($styles.insets.sm),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            movie.title ?? "",
                            style: $styles.text.labelLarge,
                          ),
                        ),
                        Gap($styles.insets.xxs),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            formatDate(movie.releaseDate ?? ''),
                            style: $styles.text.bodySmall,
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      left: 10,
                      top: 235,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CircularPercentIndicator(
                          animation: true,
                          animationDuration: 1000,
                          fillColor: $styles.theme.cardColor,
                          // backgroundWidth: 17,
                          radius: 18,
                          lineWidth: 3,
                          percent: convertVoteAverage(movie.voteAverage ?? 0.0),
                          progressColor: $styles.theme.tertiaryColor,
                          backgroundColor: Colors.black,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text(
                            convertToPercentage(movie.voteAverage ?? 0.0),
                            style: $styles.text.labelSmall,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
