// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'sliderthebestap_item_model.dart';

/// This class defines the variables used in the [onboarding_one_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class OnboardingOneModel extends Equatable {
  OnboardingOneModel({this.sliderthebestapItemList = const []});

  List<SliderthebestapItemModel> sliderthebestapItemList;

  OnboardingOneModel copyWith(
      {List<SliderthebestapItemModel>? sliderthebestapItemList}) {
    return OnboardingOneModel(
      sliderthebestapItemList:
          sliderthebestapItemList ?? this.sliderthebestapItemList,
    );
  }

  @override
  List<Object?> get props => [sliderthebestapItemList];
}
