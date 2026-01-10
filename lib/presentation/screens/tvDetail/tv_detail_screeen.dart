import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/presentation/bloc/tv/detail/tv_details_bloc.dart';
import 'package:movieverse/presentation/widgets/tv_detail_content.dart';

class TvDetailScreen extends StatefulWidget {
  final int id;

  const TvDetailScreen({super.key, required this.id});

  @override
  State<TvDetailScreen> createState() => _TvDetailScreenState();
}

class _TvDetailScreenState extends State<TvDetailScreen> {
  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    if (!mounted) return;

    BlocProvider.of<TvDetailsBloc>(context).add(FetchTvDetails(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: $styles.theme.primaryColor,
        title: Text('Tv Detail', style: $styles.text.headlineSmall),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<TvDetailsBloc, TvDetailsState>(
            builder: (_, tv) {
              if (tv is TvDetailsHasData) {
                return TvDetailContent(
                  tv.tvSeriesDetail,
                  tv.tvSeriesRecomendation,
                );
              } else if (tv is TvDetailsError) {
                return Text(tv.message);
              } else {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: Colors.blueAccent),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
