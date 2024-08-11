// ignore_for_file: must_be_immutable

part of 'privacy_bloc.dart';

/// Represents the state of Privacy in the application.
class PrivacyState extends Equatable {
  PrivacyState({this.privacyModelObj});

  PrivacyModel? privacyModelObj;

  @override
  List<Object?> get props => [
        privacyModelObj,
      ];
  PrivacyState copyWith({PrivacyModel? privacyModelObj}) {
    return PrivacyState(
      privacyModelObj: privacyModelObj ?? this.privacyModelObj,
    );
  }
}
