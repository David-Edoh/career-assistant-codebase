// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

/// This class defines the variables used in the [key_strength_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class KeyStrengthModel extends Equatable {
  KeyStrengthModel({this.radioList = const []});

  List<String> radioList;

  KeyStrengthModel copyWith({List<String>? radioList}) {
    return KeyStrengthModel(
      radioList: radioList ?? this.radioList,
    );
  }

  @override
  List<Object?> get props => [radioList];
}
