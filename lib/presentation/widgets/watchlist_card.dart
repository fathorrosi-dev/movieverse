import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:movieverse/domain/entities/watchlist_item.dart';
import 'package:movieverse/logic/calculate_cross_axis_count.dart';
import 'package:movieverse/logic/format_date.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/utils/constant.dart';

class WatchlistCard extends StatelessWidget {
  final List<WatchlistItem> item;

  const WatchlistCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width /
        MediaQuery.of(context).devicePixelRatio;

    return GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: calculateCrossAxisCount(width),
        crossAxisSpacing: 7.0,
        mainAxisSpacing: 7.0,
        mainAxisExtent: 341,
      ),
      itemCount: item.length,
      itemBuilder: (context, index) {
        final items = item[index];
        return LayoutBuilder(
            builder: ((BuildContext context, BoxConstraints constraints) {
          double cellWidth = constraints.maxWidth;
          return Card(
            color: $styles.theme.cardColor,
            child: InkWell(
              splashColor: Colors.blueAccent.withAlpha(30),
              onTap: () {
                items.isMovie!
                    ? context.push('/movieDetailScreen/${items.id!}')
                    : context.push('/tvDetailScreen/${items.id!}');
              },
              child: SizedBox(
                height: 330,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: cellWidth,
                          height: 257,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: "$baseImgUrl${items.posterPath}",
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Gap($styles.insets.xs),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            items.name ?? "",
                            style: $styles.text.labelLarge,
                          ),
                        ),
                        Gap($styles.insets.xxs),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            formatDate(items.release ?? ''),
                            style: $styles.text.bodySmall,
                          ),
                        )
                      ],
                    ),
                    Positioned(
                        right: 7,
                        top: 7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: 35,
                            height: 35,
                            color: $styles.theme.cardColor,
                            child: items.isMovie!
                                ? Icon(
                                    Icons.movie,
                                    color: $styles.theme.tertiaryColor,
                                  )
                                : Icon(
                                    Icons.tv,
                                    color: $styles.theme.tertiaryColor,
                                  ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        }));
      },
    );
  }
}
