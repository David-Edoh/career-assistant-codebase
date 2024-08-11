// ignore_for_file: must_be_immutable

part of 'onboarding_one_bloc.dart';

/// Represents the state of OnboardingOne in the application.
class OnboardingOneState extends Equatable {
  OnboardingOneState({
    this.sliderIndex = 0,
    this.onboardingOneModelObj,
  });

  OnboardingOneModel? onboardingOneModelObj;

  int sliderIndex;

  @override
  List<Object?> get props => [
        sliderIndex,
        onboardingOneModelObj,
      ];
  OnboardingOneState copyWith({
    int? sliderIndex,
    OnboardingOneModel? onboardingOneModelObj,
  }) {
    return OnboardingOneState(
      sliderIndex: sliderIndex ?? this.sliderIndex,
      onboardingOneModelObj:
          onboardingOneModelObj ?? this.onboardingOneModelObj,
    );
  }
}
