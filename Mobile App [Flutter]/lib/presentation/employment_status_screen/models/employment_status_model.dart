// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

/// This class defines the variables used in the [employment_status_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class EmploymentStatusModel extends Equatable {
  EmploymentStatusModel({this.radioList = const []});

  List<String> radioList;

  EmploymentStatusModel copyWith({List<String>? radioList}) {
    return EmploymentStatusModel(
      radioList: radioList ?? this.radioList,
    );
  }

  @override
  List<Object?> get props => [radioList];
}
