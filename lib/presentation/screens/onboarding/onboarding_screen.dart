import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movieverse/presentation/bloc/onboarding/onboarding_bloc.dart';
import 'package:rive/rive.dart';
import 'package:movieverse/main.dart';
import 'package:gap/gap.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        context.read<OnboardingBloc>().add(OnboardingStarted());
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              const RiveAnimation.asset(
                "assets/riveAssets/shapes.riv",
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: const SizedBox(),
                ),
              ),
              AnimatedPositioned(
                top: -50,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                duration: const Duration(milliseconds: 260),
                child: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: $styles.insets.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(150),
                        SizedBox(
                          width: 400,
                          child: Column(
                            children: [
                              Text(
                                "Discover \nthe Cinematic Universe",
                                style: $styles.text.displayMedium,
                              ),
                              Gap($styles.insets.sm),
                              Text(
                                "Explore thousands of films. Immerse yourself in a vast collection of movies from various genres, eras, and cultures. Discover hidden gems and all-time classics.",
                                textAlign: TextAlign.justify,
                                style: $styles.text.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Gap($styles.insets.offset),
                        SizedBox(
                          height: 50,
                          width: 190,
                          child: FilledButton(
                            onPressed: () {
                              context
                                  .read<OnboardingBloc>()
                                  .add(OnboardingCompleted());
                              context.pushReplacement('/loginScreen');
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                $styles.theme.tertiaryColor,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  CupertinoIcons.arrow_right,
                                  color: Colors.black,
                                ),
                                Gap($styles.insets.xs),
                                Text(
                                  "Start Exploring",
                                  style: $styles.text.labelLarge
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: $styles.insets.lg),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
