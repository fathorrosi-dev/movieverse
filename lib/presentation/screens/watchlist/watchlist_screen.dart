import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/presentation/bloc/get_watchlist/get_watchlist_bloc.dart';
import 'package:movieverse/presentation/widgets/watchlist_card.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    if (!mounted) return;

    BlocProvider.of<GetWatchlistBloc>(context).add(FetchWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: $styles.theme.primaryColor,
        title: const Text('Watchlist'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<GetWatchlistBloc, GetWatchlistState>(
                builder: (_, state) {
              if (state is GetWatchlistLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                );
              } else if (state is GetWatchlistSuccess) {
                return SingleChildScrollView(
                    child: WatchlistCard(state.watchlist));
              } else {
                return Align(
                  alignment: Alignment.center,
                  child: Text(
                    'There is no watchlist data yet',
                    style: $styles.text.bodyLarge,
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
