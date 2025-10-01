import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/presentation/bloc/tv/airing_today/airing_today_tv_bloc.dart';
import 'package:movieverse/presentation/bloc/tv/on_the_air/on_the_air_tv_bloc.dart';
import 'package:movieverse/presentation/bloc/tv/popular/popular_tv_bloc.dart';
import 'package:movieverse/presentation/bloc/tv/top_rated/top_rated_tv_bloc.dart';
import 'package:movieverse/presentation/widgets/tv_card.dart';

class TvScreen extends StatefulWidget {
  const TvScreen({super.key});

  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    if (!mounted) return;

    BlocProvider.of<AiringTodayTvBloc>(context).add(FetchAiringTodayTv());
    BlocProvider.of<OnTheAirTvBloc>(context).add(FetchOnTheAirTv());
    BlocProvider.of<PopularTvBloc>(context).add(FetchPopularTv());
    BlocProvider.of<TopRatedTvBloc>(context).add(FetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: $styles.theme.primaryColor,
        title: const Text('Tv Series'),
        titleTextStyle: $styles.text.headlineSmall,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Airing Today',
                style: $styles.text.headlineMedium,
              ),
            ),
            Gap($styles.insets.xs),
            SizedBox(
              height: 370,
              child: BlocBuilder<AiringTodayTvBloc, AiringTodayTvState>(
                  builder: (_, state) {
                if (state is AiringTodayTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  );
                } else if (state is AiringTodayTvHasData) {
                  return TvCard(state.result);
                } else {
                  return const Text('Something went wrong');
                }
              }),
            ),
            Gap($styles.insets.sm),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Popular',
                style: $styles.text.headlineMedium,
              ),
            ),
            Gap($styles.insets.xs),
            SizedBox(
              height: 370,
              child: BlocBuilder<PopularTvBloc, PopularTvState>(
                  builder: (_, state) {
                if (state is PopularTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  );
                } else if (state is PopularTvHasData) {
                  return TvCard(state.result);
                } else {
                  return const Text('Something went wrong');
                }
              }),
            ),
            Gap($styles.insets.sm),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Top Rated',
                style: $styles.text.headlineMedium,
              ),
            ),
            Gap($styles.insets.xs),
            SizedBox(
              height: 370,
              child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                  builder: (_, state) {
                if (state is TopRatedTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  );
                } else if (state is TopRatedTvHasData) {
                  return TvCard(state.result);
                } else {
                  return const Text('Something went wrong');
                }
              }),
            ),
            Gap($styles.insets.sm),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'On The Air',
                style: $styles.text.headlineMedium,
              ),
            ),
            Gap($styles.insets.xs),
            SizedBox(
              height: 370,
              child: BlocBuilder<OnTheAirTvBloc, OnTheAirTvState>(
                  builder: (_, state) {
                if (state is OnTheAirTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  );
                } else if (state is OnTheAirTvHasData) {
                  return TvCard(state.result);
                } else {
                  return const Text('Something went wrong');
                }
              }),
            ),
            Gap($styles.insets.sm),
          ],
        ),
      )),
    );
  }
}
