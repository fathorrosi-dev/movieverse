import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/domain/entities/movie/movie_detail.dart';
import 'package:movieverse/logic/show_duration.dart';
import 'package:movieverse/logic/show_genres.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/presentation/bloc/get_watchlist/get_watchlist_bloc.dart';
import 'package:movieverse/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:movieverse/presentation/screens/movieDetail/movie_detail_screen.dart';

class MovieDetailContent extends StatefulWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;

  const MovieDetailContent(this.movie, this.recommendations, {super.key});

  @override
  State<MovieDetailContent> createState() => _MovieDetailContentState();
}

class _MovieDetailContentState extends State<MovieDetailContent> {
  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    if (!mounted) return;

    BlocProvider.of<WatchlistBloc>(
      context,
    ).add(CheckWatchlist(widget.movie.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchlistBloc, WatchlistState>(
      listenWhen: (_, state) =>
          state is AddToWatchlistSuccess ||
          state is RemoveFromWatchlistSuccess ||
          state is CheckWatchlistStatus ||
          state is AddToWatchlistFailure ||
          state is RemoveFromWatchlistFailure,
      listener: (context, state) {
        if (state is AddToWatchlistSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.messages)));
        } else if (state is AddToWatchlistFailure) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: Text(state.messages));
            },
          );
        } else if (state is RemoveFromWatchlistSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.messages)));
        } else if (state is RemoveFromWatchlistFailure) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: Text(state.messages));
            },
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 400,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl:
                  'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
              width: double.maxFinite,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 233,
                      child: Text(
                        widget.movie.title,
                        style: $styles.text.headlineSmall,
                      ),
                    ),
                    BlocBuilder<WatchlistBloc, WatchlistState>(
                      builder: (_, state) {
                        if (state is CheckWatchlistStatus) {
                          return ElevatedButton(
                            onPressed: () async {
                              if (!state.isAddedToWatchlist) {
                                context.read<WatchlistBloc>().add(
                                  AddWatchlistItem(
                                    widget.movie.id.toString(),
                                    widget.movie.title,
                                    widget.movie.posterPath,
                                    widget.movie.releaseDate,
                                    true,
                                  ),
                                );
                                context.read<WatchlistBloc>().add(
                                  CheckWatchlist(widget.movie.id),
                                );
                                context.read<GetWatchlistBloc>().add(
                                  FetchWatchlist(),
                                );
                              } else {
                                context.read<WatchlistBloc>().add(
                                  RemoveWatchlistItem(
                                    widget.movie.id.toString(),
                                  ),
                                );
                                context.read<WatchlistBloc>().add(
                                  CheckWatchlist(widget.movie.id),
                                );
                                context.read<GetWatchlistBloc>().add(
                                  FetchWatchlist(),
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                $styles.theme.tertiaryColor,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                state.isAddedToWatchlist
                                    ? const Icon(Icons.check)
                                    : const Icon(Icons.add),
                                const Text('Watchlist'),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox(
                            height: 50,
                            width: 120,
                            child: Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                color: Colors.blueAccent,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                Text(
                  showGenres(widget.movie.genres),
                  style: $styles.text.bodyLarge,
                ),
                Text(
                  showDuration(widget.movie.runtime),
                  style: $styles.text.bodyLarge,
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: widget.movie.voteAverage / 2,
                      itemCount: 5,
                      itemBuilder: (context, index) =>
                          Icon(Icons.star, color: $styles.theme.tertiaryColor),
                      itemSize: 24,
                    ),
                    Text('${widget.movie.voteAverage}'),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Overview', style: $styles.text.headlineMedium),
                Text(
                  widget.movie.overview,
                  style: $styles.text.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                Text('Recommendations', style: $styles.text.headlineMedium),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: (widget.recommendations.isNotEmpty)
                ? SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final movie = widget.recommendations[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailScreen(id: movie.id),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: widget.recommendations.length,
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
