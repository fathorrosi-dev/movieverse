import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:movieverse/domain/entities/tv/tv_series.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/presentation/bloc/movie/search/movie_search_bloc.dart';
import 'package:movieverse/presentation/bloc/tv/search/tv_search_bloc.dart';
import 'package:movieverse/presentation/widgets/movie_card_list.dart';
import 'package:movieverse/presentation/widgets/search_textfield.dart';
import 'package:movieverse/presentation/widgets/tv_card_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: $styles.theme.primaryColor,
          title: SizedBox(
              width: double.maxFinite,
              height: 40,
              child: SearchTextField(
                controller: searchController,
                icon: Icons.search,
                onChanged: (query) {
                  context
                      .read<MoviesSearchBloc>()
                      .add(MoviesOnQueryChanged(query));
                  context.read<TvSearchBloc>().add(TvOnQueryChanged(query));
                },
              )),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search Result',
                style: $styles.text.headlineMedium,
              ),
              BlocBuilder<MoviesSearchBloc, MoviesSearchState>(
                builder: (_, movieState) {
                  return BlocBuilder<TvSearchBloc, TvSearchState>(
                    builder: (_, tvState) {
                      if (movieState is MoviesSearchLoading ||
                          tvState is TvSearchLoading) {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (movieState is MoviesSearchHasData ||
                          tvState is TvSearchHasData) {
                        final List<dynamic> movieResults =
                            movieState is MoviesSearchHasData
                                ? movieState.result
                                : [];
                        final List<dynamic> tvResults =
                            tvState is TvSearchHasData ? tvState.result : [];
                        final List<dynamic> results = [
                          ...movieResults,
                          ...tvResults
                        ];
                        return Expanded(
                          child: results.isNotEmpty
                              ? ListView.builder(
                                  key: const Key('search-listview'),
                                  itemBuilder: (_, index) {
                                    final dynamic result = results[index];
                                    if (result is Movie) {
                                      return MovieCardList(result);
                                    } else if (result is TvSeries) {
                                      return TvCardList(result);
                                    } else {
                                      return Container();
                                    }
                                  },
                                  itemCount: results.length,
                                )
                              : const Center(
                                  child: Text(
                                      'Cannot Found Movies or TV Series :('),
                                ),
                        );
                      } else {
                        return const SizedBox(key: Key('search-error'));
                      }
                    },
                  );
                },
              ),
            ],
          ),
        )));
  }
}
