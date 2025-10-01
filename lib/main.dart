import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:movieverse/logic/app_logic.dart';
import 'package:movieverse/presentation/app_scaffold.dart';
import 'package:movieverse/presentation/bloc/auto_login/auto_login_bloc.dart';
import 'package:movieverse/presentation/bloc/get_credentials/get_credentials_bloc.dart';
import 'package:movieverse/presentation/bloc/get_user_data/get_user_data_bloc.dart';
import 'package:movieverse/presentation/bloc/get_watchlist/get_watchlist_bloc.dart';
import 'package:movieverse/presentation/bloc/login_user/login_user_bloc.dart';
import 'package:movieverse/presentation/bloc/logout_user/logout_user_bloc.dart';
import 'package:movieverse/presentation/bloc/movie/detail/movie_details_bloc.dart';
import 'package:movieverse/presentation/bloc/movie/discover/discover_movies_bloc.dart';
import 'package:movieverse/presentation/bloc/movie/now_playing/now_playing_movies_bloc.dart';
import 'package:movieverse/presentation/bloc/movie/popular/popular_movies_bloc.dart';
import 'package:movieverse/presentation/bloc/movie/search/movie_search_bloc.dart';
import 'package:movieverse/presentation/bloc/movie/top_rated/top_rated_movies_bloc.dart';
import 'package:movieverse/presentation/bloc/movie/trending/trending_movies_bloc.dart';
import 'package:movieverse/presentation/bloc/movie/upcoming/upcoming_movies_bloc.dart';
import 'package:movieverse/presentation/bloc/onboarding/onboarding_bloc.dart';
import 'package:movieverse/presentation/bloc/register_user/register_user_bloc.dart';
import 'package:movieverse/presentation/bloc/remove_from_watchlist/remove_from_watchlist_bloc.dart';
import 'package:movieverse/presentation/bloc/save_credentials/save_credentials_bloc.dart';
import 'package:movieverse/presentation/bloc/tv/airing_today/airing_today_tv_bloc.dart';
import 'package:movieverse/presentation/bloc/tv/detail/tv_details_bloc.dart';
import 'package:movieverse/presentation/bloc/tv/discover/discover_tv_bloc.dart';
import 'package:movieverse/presentation/bloc/tv/on_the_air/on_the_air_tv_bloc.dart';
import 'package:movieverse/presentation/bloc/tv/popular/popular_tv_bloc.dart';
import 'package:movieverse/presentation/bloc/tv/search/tv_search_bloc.dart';
import 'package:movieverse/presentation/bloc/tv/top_rated/top_rated_tv_bloc.dart';
import 'package:movieverse/presentation/bloc/tv/trending/trending_tv_bloc.dart';
import 'package:movieverse/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:movieverse/presentation/router.dart';
import 'package:movieverse/presentation/styles/app_theme.dart';
import 'package:movieverse/injection.dart' as di;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Keep native splash screen up until app is finished bootstrapping
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //firebase
  await Firebase.initializeApp();
  // Start App
  registerSingletons();
  di.init();
  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late final router = buildRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // movie bloc
        BlocProvider(
          create: (context) => di.locator<MovieDetailsBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<DiscoverMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MoviesSearchBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TrendingMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<UpcomingMoviesBloc>(),
        ),
        // Tv Bloc
        BlocProvider(
          create: (context) => di.locator<AiringTodayTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvDetailsBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<DiscoverTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<OnTheAirTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TrendingTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<GetWatchlistBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<RemoveFromWatchlistBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<GetUserDataBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<RegisterUserBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<LoginUserBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SaveCredentialsBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<GetCredentialsBloc>(),
        ),
        BlocProvider(create: (context) => di.locator<OnboardingBloc>()),
        BlocProvider(create: (context) => di.locator<AutoLoginBloc>()),
        BlocProvider(create: (context) => di.locator<LogoutUserBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Movieverse',
        theme: $styles.theme.toThemeData(),
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}

/// Create singletons (logic and services) that can be shared across the app.
void registerSingletons() {
  // Top level app controller
  GetIt.I.registerLazySingleton<AppLogic>(() => AppLogic());
}

/// Add syntax sugar for quickly accessing the main "logic" controllers in the app
/// We deliberately do not create shortcuts for services, to discourage their use directly in the view/widget layer.
AppLogic get appLogic => GetIt.I.get<AppLogic>();

/// Global helpers for readability
AppStyle get $styles => AppScaffold.style;
