// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

/// This class defines the variables used in the [speciallization_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class SpeciallizationModel extends Equatable {
  SpeciallizationModel({this.radioList = const []});

  List<String> radioList;

  SpeciallizationModel copyWith({List<String>? radioList}) {
    return SpeciallizationModel(
      radioList: radioList ?? this.radioList,
    );
  }

  @override
  List<Object?> get props => [radioList];
}
