import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/presentation/bloc/movie/now_playing/now_playing_movies_bloc.dart';
import 'package:movieverse/presentation/bloc/movie/popular/popular_movies_bloc.dart';
import 'package:movieverse/presentation/bloc/movie/top_rated/top_rated_movies_bloc.dart';
import 'package:movieverse/presentation/bloc/movie/upcoming/upcoming_movies_bloc.dart';
import 'package:movieverse/presentation/widgets/movie_card.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    if (!mounted) return;

    BlocProvider.of<NowPlayingMoviesBloc>(context).add(FetchNowPlayingMovies());
    BlocProvider.of<PopularMoviesBloc>(context).add(FetchPopularMovies());
    BlocProvider.of<TopRatedMoviesBloc>(context).add(FetchTopRatedMovies());
    BlocProvider.of<UpcomingMoviesBloc>(context).add(FetchUpcomingMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: $styles.theme.primaryColor,
        title: const Text('Movie'),
        titleTextStyle: $styles.text.headlineSmall,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text('Now Playing', style: $styles.text.headlineMedium),
              ),
              Gap($styles.insets.xs),
              SizedBox(
                height: 370,
                child: BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                  builder: (_, state) {
                    if (state is NowPlayingMoviesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ),
                      );
                    } else if (state is NowPlayingMoviesHasData) {
                      return MovieCard(state.result);
                    } else {
                      return const Text('Something went wrong');
                    }
                  },
                ),
              ),
              Gap($styles.insets.sm),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text('Popular', style: $styles.text.headlineMedium),
              ),
              Gap($styles.insets.xs),
              SizedBox(
                height: 370,
                child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                  builder: (_, state) {
                    if (state is PopularMoviesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ),
                      );
                    } else if (state is PopularMoviesHasData) {
                      return MovieCard(state.result);
                    } else {
                      return const Text('Something went wrong');
                    }
                  },
                ),
              ),
              Gap($styles.insets.sm),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text('Top Rated', style: $styles.text.headlineMedium),
              ),
              Gap($styles.insets.xs),
              SizedBox(
                height: 370,
                child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                  builder: (_, state) {
                    if (state is TopRatedMoviesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ),
                      );
                    } else if (state is TopRatedMoviesHasData) {
                      return MovieCard(state.result);
                    } else {
                      return const Text('Something went wrong');
                    }
                  },
                ),
              ),
              Gap($styles.insets.sm),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text('Upcoming', style: $styles.text.headlineMedium),
              ),
              Gap($styles.insets.xs),
              SizedBox(
                height: 370,
                child: BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
                  builder: (_, state) {
                    if (state is UpcomingMoviesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ),
                      );
                    } else if (state is UpcomingMoviesHasData) {
                      return MovieCard(state.result);
                    } else {
                      return const Text('Something went wrong');
                    }
                  },
                ),
              ),
              Gap($styles.insets.sm),
            ],
          ),
        ),
      ),
    );
  }
}
