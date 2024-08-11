// ignore_for_file: must_be_immutable

part of 'resume_maker_bloc.dart';

/// Represents the state of ResumeMaker in the application.
class ResumeMakerState extends Equatable {
  ResumeMakerState({
    this.personalBrandModelObj,
    this.getResumeTemplatesResp,
    this.radioGroup = "",
    this.resumeTemplatesLoaded = false,
    this.webViewLoadingComplete = false,
    this.selectedTemplate,
    this.controller,
    this.initialCarouselPage = 0,
    this.isPreviewMode = true,
    this.message,
  });

  String? message;
  String radioGroup;
  bool? isPreviewMode;
  ResumeTemplatesResponse? getResumeTemplatesResp;
  ResumeMakerModel? personalBrandModelObj;
  bool resumeTemplatesLoaded;
  bool webViewLoadingComplete;
  ResumeTemplate? selectedTemplate;
  WebViewController? controller;
  int? initialCarouselPage;

  @override
  List<Object?> get props => [
    getResumeTemplatesResp,
    personalBrandModelObj,
    resumeTemplatesLoaded,
    webViewLoadingComplete,
    radioGroup,
    selectedTemplate,
    controller,
    initialCarouselPage,
    isPreviewMode,
    message
      ];
  ResumeMakerState copyWith({
    ResumeTemplatesResponse? getResumeTemplatesResp,
    ResumeMakerModel? personalBrandModelObj,
    bool? resumeTemplatesLoaded,
    bool? webViewLoadingComplete,
    String? radioGroup,
    ResumeTemplate? selectedTemplate,
    WebViewController? controller,
    int? initialCarouselPage,
    bool? isPreviewMode,
    String? message,
  }) {
    return ResumeMakerState(
      getResumeTemplatesResp: getResumeTemplatesResp ?? this.getResumeTemplatesResp,
      personalBrandModelObj: personalBrandModelObj ?? this.personalBrandModelObj,
      resumeTemplatesLoaded: resumeTemplatesLoaded ?? this.resumeTemplatesLoaded,
      webViewLoadingComplete: webViewLoadingComplete ?? this.webViewLoadingComplete,
      radioGroup: radioGroup ?? this.radioGroup,
      selectedTemplate: selectedTemplate ?? this.selectedTemplate,
      controller: controller ?? this.controller,
      initialCarouselPage: initialCarouselPage ?? this.initialCarouselPage,
      isPreviewMode: isPreviewMode ?? this.isPreviewMode,
      message: message ?? this.message,
    );
  }
}
