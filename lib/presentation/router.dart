import 'package:go_router/go_router.dart';
import 'package:movieverse/presentation/screens/initialScreen/initial_screen.dart';
import 'package:movieverse/presentation/screens/login/login_screen.dart';
import 'package:movieverse/presentation/screens/movieDetail/movie_detail_screen.dart';
import 'package:movieverse/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:movieverse/presentation/screens/search/search_screen.dart';
import 'package:movieverse/presentation/screens/signup/sign_up_screen.dart';
import 'package:movieverse/presentation/screens/tvDetail/tv_detail_screeen.dart';
import 'package:movieverse/presentation/widgets/navbar.dart';

GoRouter buildRouter() {
  return GoRouter(initialLocation: '/', routes: [
    GoRoute(
      name: 'initialScreen',
      path: '/',
      builder: (context, state) => const InitialScreen(),
    ),
    GoRoute(
      name: 'onboradingScreen',
      path: '/onboardingScreen',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      name: 'loginScreen',
      path: '/loginScreen',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: 'signUpScreen',
      path: '/signUpScreen',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: 'searchScreen',
      path: '/searchScreen',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      name: 'navigationBars',
      path: '/navigationBars',
      builder: (context, state) => const NavigationBars(),
    ),
    GoRoute(
      name: 'movieDetailScreen',
      path: '/movieDetailScreen/:id',
      builder: (context, state) =>
          MovieDetailScreen(id: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(
      name: 'tvDetailScreen',
      path: '/tvDetailScreen/:id',
      builder: (context, state) =>
          TvDetailScreen(id: int.parse(state.pathParameters['id']!)),
    ),
  ]);
}
