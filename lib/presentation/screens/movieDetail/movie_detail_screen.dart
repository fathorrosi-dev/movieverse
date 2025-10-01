import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/presentation/widgets/movie_detail_content.dart';

import '../../bloc/movie/detail/movie_details_bloc.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    if (!mounted) return;

    BlocProvider.of<MovieDetailsBloc>(context)
        .add(FetchMovieDetails(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: $styles.theme.primaryColor,
        title: Text(
          'Movie Detail',
          style: $styles.text.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(child:
            BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                builder: (_, movie) {
          if (movie is MovieDetailsHasData) {
            return MovieDetailContent(
                movie.movieDetails, movie.movieRecommendations);
          } else if (movie is MovieDetailsError) {
            return Text(movie.message);
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              ),
            );
          }
        })),
      ),
    );
  }
}
