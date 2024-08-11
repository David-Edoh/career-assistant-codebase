// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

/// This class defines the variables used in the [career_goals_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class CareerGoalsModel extends Equatable {
  CareerGoalsModel({this.radioList = const []});

  List<String> radioList;

  CareerGoalsModel copyWith({List<String>? radioList}) {
    return CareerGoalsModel(
      radioList: radioList ?? this.radioList,
    );
  }

  @override
  List<Object?> get props => [radioList];
}
