// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

/// This class defines the variables used in the [EducationLevel_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class EducationLevelModel extends Equatable {
  EducationLevelModel({this.radioList = const []});

  List<String> radioList;

  EducationLevelModel copyWith({List<String>? radioList}) {
    return EducationLevelModel(
      radioList: radioList ?? this.radioList,
    );
  }

  @override
  List<Object?> get props => [radioList];
}
