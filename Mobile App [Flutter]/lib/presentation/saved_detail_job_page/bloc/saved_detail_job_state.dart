// ignore_for_file: must_be_immutable

part of 'saved_detail_job_bloc.dart';

/// Represents the state of SavedDetailJob in the application.
class SavedDetailJobState extends Equatable {
  SavedDetailJobState({this.savedDetailJobModelObj});

  SavedDetailJobModel? savedDetailJobModelObj;

  @override
  List<Object?> get props => [
        savedDetailJobModelObj,
      ];
  SavedDetailJobState copyWith({SavedDetailJobModel? savedDetailJobModelObj}) {
    return SavedDetailJobState(
      savedDetailJobModelObj:
          savedDetailJobModelObj ?? this.savedDetailJobModelObj,
    );
  }
}
