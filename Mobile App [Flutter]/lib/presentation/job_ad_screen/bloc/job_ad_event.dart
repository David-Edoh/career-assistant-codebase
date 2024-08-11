// ignore_for_file: must_be_immutable

part of 'job_ad_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///CareerSubjects widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class JobAdEvent extends Equatable {}

/// Event that is dispatched when the CareerSubjects widget is first created.
class JobAdInitialEvent extends JobAdEvent {
  @override
  List<Object?> get props => [];
}

class GetQualificationScore extends JobAdEvent {

  GetQualificationScore({required this.jobAd});

  String jobAd;

  @override
  List<Object?> get props => [
    jobAd,
  ];
}

///event for OTP auto fill
class ChangeOTPEvent extends JobAdEvent {
  ChangeOTPEvent({required this.code});

  String code;

  @override
  List<Object?> get props => [
        code,
      ];
}
