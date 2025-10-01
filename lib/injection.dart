import 'package:get_it/get_it.dart';
import 'package:movieverse/data/datasources/database/firebase_helper.dart';
import 'package:movieverse/data/datasources/localDataSource/shared_preference_helper.dart';
import 'package:movieverse/data/datasources/remoteDataSource/remote_data_source.dart';
import 'package:movieverse/data/repositories/firebase_repository_impl.dart';
import 'package:movieverse/data/repositories/repository_impl.dart';
import 'package:movieverse/data/repositories/shared_preference_repository_impl.dart';
import 'package:movieverse/domain/repositories/firebase_repository.dart';
import 'package:movieverse/domain/repositories/repository.dart';
import 'package:movieverse/domain/repositories/shared_preference_repository.dart';
import 'package:movieverse/domain/usecases/add_to_watchlist.dart';
import 'package:movieverse/domain/usecases/auto_login.dart';
import 'package:movieverse/domain/usecases/check_onboarding_status.dart';
import 'package:movieverse/domain/usecases/get_credentials.dart';
import 'package:movieverse/domain/usecases/get_user_data.dart';
import 'package:movieverse/domain/usecases/get_watchlist.dart';
import 'package:movieverse/domain/usecases/get_watchlist_by_id.dart';
import 'package:movieverse/domain/usecases/login_user.dart';
import 'package:movieverse/domain/usecases/logout_user.dart';
import 'package:movieverse/domain/usecases/movie/get_discover_movies.dart';
import 'package:movieverse/domain/usecases/movie/get_movie_detail.dart';
import 'package:movieverse/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:movieverse/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:movieverse/domain/usecases/movie/get_popular_movies.dart';
import 'package:movieverse/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:movieverse/domain/usecases/movie/get_trending_movies.dart';
import 'package:movieverse/domain/usecases/movie/get_upcoming_movies.dart';
import 'package:movieverse/domain/usecases/movie/search_movies.dart';
import 'package:movieverse/domain/usecases/register_user.dart';
import 'package:movieverse/domain/usecases/remove_from_watchlist.dart';
import 'package:movieverse/domain/usecases/save_credentials.dart';
import 'package:movieverse/domain/usecases/set_on_boarding_status.dart';
import 'package:movieverse/domain/usecases/tv/get_airing_today_tv_series.dart';
import 'package:movieverse/domain/usecases/tv/get_discover_tv_series.dart';
import 'package:movieverse/domain/usecases/tv/get_on_the_air_tv_series.dart';
import 'package:movieverse/domain/usecases/tv/get_popular_tv_series.dart';
import 'package:movieverse/domain/usecases/tv/get_top_rated_tv_series.dart';
import 'package:movieverse/domain/usecases/tv/get_trending_tv_series.dart';
import 'package:movieverse/domain/usecases/tv/get_tv_series_detail.dart';
import 'package:movieverse/domain/usecases/tv/get_tv_series_recommendations.dart';
import 'package:movieverse/domain/usecases/tv/search_tv_series.dart';
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
import 'package:http/http.dart' as http;
import 'package:movieverse/presentation/bloc/watchlist/watchlist_bloc.dart';

final locator = GetIt.instance;

void init() {
  // movie bloc
  locator.registerFactory(() => MovieDetailsBloc(
        getMovieDetail: locator(),
        getMovieRecommendations: locator(),
      ));

  locator.registerFactory(
    () => DiscoverMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MoviesSearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TrendingMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => UpcomingMoviesBloc(
      locator(),
    ),
  );

  // tv bloc
  locator.registerFactory(
    () => AiringTodayTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvDetailsBloc(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
    ),
  );

  locator.registerFactory(
    () => DiscoverTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => OnTheAirTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvSearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TrendingTvBloc(
      locator(),
    ),
  );

  // get user data bloc
  locator.registerFactory(
    () => GetUserDataBloc(
      locator(),
    ),
  );

  // register user bloc
  locator.registerFactory(
    () => RegisterUserBloc(
      locator(),
    ),
  );

  // login user bloc
  locator.registerFactory(
    () => LoginUserBloc(
      locator(),
    ),
  );

  // add to watchlist bloc
  locator.registerFactory(
    () => WatchlistBloc(
        addToWatchlist: locator(),
        removeFromWatchlist: locator(),
        getWatchlistById: locator()),
  );

  // remove from watchlist bloc
  locator.registerFactory(
    () => RemoveFromWatchlistBloc(
      locator(),
    ),
  );

  // get watchlist bloc
  locator.registerFactory(
    () => GetWatchlistBloc(
      locator(),
    ),
  );

  // get credentials bloc
  locator.registerFactory(() => GetCredentialsBloc(locator()));

  // save credentials bloc
  locator.registerFactory(() => SaveCredentialsBloc(locator()));

  // on boarding bloc
  locator.registerFactory(() => OnboardingBloc(
      completeOnboarding: locator(), getOnboardingStatus: locator()));

  // auto login bloc
  locator.registerFactory(() => AutoLoginBloc(locator()));

  // logout bloc
  locator.registerFactory(() => LogoutUserBloc(locator()));

  // movie use cases
  locator.registerLazySingleton(() => GetDiscoverMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetTrendingMovies(locator()));
  locator.registerLazySingleton(() => GetUpcomingMovies(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));

  // tv use case
  locator.registerLazySingleton(() => GetAiringTodayTvSeries(locator()));
  locator.registerLazySingleton(() => GetDiscoverTvSeries(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTrendingTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));

  // watchlist use case
  locator.registerLazySingleton(() => GetWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveFromWatchlist(locator()));
  locator.registerLazySingleton(() => AddToWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistById(locator()));

  // user auth use case
  locator.registerLazySingleton(() => RegisterUser(locator()));
  locator.registerLazySingleton(() => LoginUser(locator()));
  locator.registerLazySingleton(() => GetUserData(locator()));

  // get credential usecase
  locator.registerLazySingleton(() => GetCredentials(locator()));

  // save credential usecase
  locator.registerLazySingleton(() => SaveCredentials(locator()));

  // check onboarding status usecase
  locator.registerLazySingleton(() => CheckOnboardingStatus(locator()));

  // set onboarding status usecase
  locator.registerLazySingleton(() => SetOnBoardingStatus(locator()));

  // auto login usecase
  locator.registerLazySingleton(() => AutoLogin(locator()));

  // logout usecase
  locator.registerLazySingleton(() => LogoutUser(locator()));

  // Repository
  locator.registerLazySingleton<Repository>(
      () => RepositoryImpl(remoteDataSource: locator()));

  // Firebase Repository
  locator.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseHelper: locator()));

  // SharedPreference Repsitory
  locator.registerLazySingleton<SharedPreferenceRepository>(
      () => SharedPreferenceRepositoryImpl(sharedPreferenceHelper: locator()));

  // Datasource
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<FirebaseHelper>(() => FirebaseHelperImpl());

  locator.registerLazySingleton<SharedPreferenceHelper>(
      () => SharedPreferenceHelperImpl());

  // external
  locator.registerLazySingleton(() => http.Client());
}
