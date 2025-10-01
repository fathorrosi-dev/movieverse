import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/presentation/bloc/auto_login/auto_login_bloc.dart';
import 'package:movieverse/presentation/screens/login/login_screen.dart';
import 'package:movieverse/presentation/bloc/onboarding/onboarding_bloc.dart';
import 'package:movieverse/injection.dart' as di;
import 'package:movieverse/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:movieverse/presentation/widgets/navbar.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.locator<AutoLoginBloc>()..add(AutoLoginStarted()),
          ),
          BlocProvider(
            create: (_) =>
                di.locator<OnboardingBloc>()..add(OnboardingStarted()),
          )
        ],
        child: BlocBuilder<AutoLoginBloc, AutoLoginState>(
            builder: (context, state) {
          if (state is AutoLoginSucced) {
            return const NavigationBars();
          } else {
            return BlocBuilder<OnboardingBloc, OnboardingState>(
                builder: (context, state) {
              if (state is OnboardingComplete) {
                return const LoginScreen();
              } else {
                return const OnboardingScreen();
              }
            });
          }
        }));
  }
}
