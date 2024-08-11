// ignore_for_file: must_be_immutable

part of 'career_roadmap_bloc.dart';

/// Represents the state of CareerRoadmap in the application.
class CareerRoadmapState extends Equatable {
  CareerRoadmapState({
    this.otpController,
    this.enterOtpModelObj,
    this.isStreakLoading = true,
    this.streak,
  });

  TextEditingController? otpController;
  CareerRoadmapModel? enterOtpModelObj;
  bool? isStreakLoading = true;
  Streak? streak;

  @override
  List<Object?> get props => [
        otpController,
        enterOtpModelObj,
        isStreakLoading,
        streak
      ];
  CareerRoadmapState copyWith({
    TextEditingController? otpController,
    CareerRoadmapModel? careerRoadmapModelObj,
    bool? isStreakLoading,
    Streak? streak,
  }) {
    return CareerRoadmapState(
      otpController: otpController ?? this.otpController,
      enterOtpModelObj: careerRoadmapModelObj ?? this.enterOtpModelObj,
      streak: streak ?? this.streak,
      isStreakLoading: isStreakLoading ?? this.isStreakLoading,
    );
  }
}
