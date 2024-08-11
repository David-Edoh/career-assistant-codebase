// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

/// This class defines the variables used in the [select_a_country_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class SelectACountryModel extends Equatable {
  SelectACountryModel({this.radioList = const []});

  List<String> radioList;

  SelectACountryModel copyWith({List<String>? radioList}) {
    return SelectACountryModel(
      radioList: radioList ?? this.radioList,
    );
  }

  @override
  List<Object?> get props => [radioList];
}
