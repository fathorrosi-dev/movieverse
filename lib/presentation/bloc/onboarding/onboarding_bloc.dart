import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieverse/domain/usecases/check_onboarding_status.dart';
import 'package:movieverse/domain/usecases/set_on_boarding_status.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final CheckOnboardingStatus getOnboardingStatus;
  final SetOnBoardingStatus completeOnboarding;

  OnboardingBloc(
      {required this.getOnboardingStatus, required this.completeOnboarding})
      : super(OnboardingInitial()) {
    on<OnboardingStarted>(_onOnboardingStarted);
    on<OnboardingCompleted>(_onOnboardingCompleted);
  }

  void _onOnboardingStarted(
    OnboardingStarted event,
    Emitter<OnboardingState> emit,
  ) async {
    final isCompleted = await getOnboardingStatus.execute();
    if (isCompleted) {
      emit(OnboardingComplete());
    } else {
      emit(OnboardingInProgress());
    }
  }

  void _onOnboardingCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) async {
    await completeOnboarding.execute();
    emit(OnboardingComplete());
  }
}
