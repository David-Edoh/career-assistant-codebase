// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'sliderapplicati_item_model.dart';

/// This class defines the variables used in the [onboarding_three_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class OnboardingThreeModel extends Equatable {
  OnboardingThreeModel({this.sliderapplicatiItemList = const []});

  List<SliderapplicatiItemModel> sliderapplicatiItemList;

  OnboardingThreeModel copyWith(
      {List<SliderapplicatiItemModel>? sliderapplicatiItemList}) {
    return OnboardingThreeModel(
      sliderapplicatiItemList:
          sliderapplicatiItemList ?? this.sliderapplicatiItemList,
    );
  }

  @override
  List<Object?> get props => [sliderapplicatiItemList];
}
