import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:movieverse/domain/entities/tv/tv_series.dart';
import 'package:movieverse/logic/convert_to_percentage.dart';
import 'package:movieverse/logic/format_date.dart';
import 'package:movieverse/logic/vote_average_convert.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/utils/constant.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TvCard extends StatelessWidget {
  final List<TvSeries> tvSeries;
  const TvCard(this.tvSeries, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tvSeries.length,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Card(
            margin: const EdgeInsets.only(left: 16),
            color: $styles.theme.cardColor,
            child: InkWell(
              splashColor: Colors.blueAccent.withAlpha(30),
              onTap: () {
                context.push('/tvDetailScreen/${tv.id}');
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
                          height: 257,
                          width: 190,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "$baseImgUrl${tv.posterPath}",
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
                            tv.name ?? '',
                            style: $styles.text.labelLarge,
                          ),
                        ),
                        Gap($styles.insets.xxs),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            formatDate(tv.firstAirDate ?? ''),
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
                          radius: 18,
                          lineWidth: 3,
                          percent: convertVoteAverage(tv.voteAverage ?? 0.0),
                          progressColor: $styles.theme.tertiaryColor,
                          backgroundColor: Colors.black,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text(
                            convertToPercentage(tv.voteAverage ?? 0.0),
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
