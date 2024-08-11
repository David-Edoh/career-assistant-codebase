// ignore_for_file: must_be_immutable

part of 'home_bloc.dart';

/// Represents the state of Home in the application.
class HomeState extends Equatable {
  HomeState({
    this.searchController,
    this.homeModelObj,
    this.posts,
    this.loadingPosts = false,
    this.getCareerSuggestionResp,
    this.getSubjectSuggstionResp,
    this.getSuggestedEventsResp,
    this.getSuggestedOpportunitiesResp,
    this.getCareerRoadmapResp,
    this.isSuggestionsLoaded = false,
    this.isRoadmapLoaded = false,
    this.isNewCareer = true,
    this.isOpportunitiesLoaded = false,
    this.userData,
    this.isEventsLoaded = false,
    this.jobPostings,
    this.isJobsLoaded = false,
    this.loadingMilestone = 0,
  });

  TextEditingController? searchController;
  Map<String, dynamic>? userData;
  HomeModel? homeModelObj;
  bool isJobsLoaded;
  List<Post>? posts;
  List<Job>? jobPostings;
  bool loadingPosts = false;
  int loadingMilestone = 0;
  CareerSuggestionResponseObject? getCareerSuggestionResp;
  SuggestedSubjectsResponse? getSubjectSuggstionResp;
  SuggestedEventsResponse? getSuggestedEventsResp;
  SuggestedOpportunitiesResponse? getSuggestedOpportunitiesResp;
  CareerRoadmapResponseObject? getCareerRoadmapResp;
  bool isSuggestionsLoaded;
  bool isRoadmapLoaded;
  bool isNewCareer;
  bool isOpportunitiesLoaded;
  bool isEventsLoaded;

  @override
  List<Object?> get props => [
    searchController,
    homeModelObj,
    getCareerSuggestionResp,
    getSubjectSuggstionResp,
    getSuggestedEventsResp,
    getSuggestedOpportunitiesResp,
    getCareerRoadmapResp,
    isSuggestionsLoaded,
    isRoadmapLoaded,
    isNewCareer,
    userData,
    isOpportunitiesLoaded,
    isEventsLoaded,
    jobPostings,
    posts,
    loadingPosts,
    isJobsLoaded,
    loadingMilestone
  ];


  HomeState copyWith({
    TextEditingController? searchController,
    HomeModel? homeModelObj,
    List<Post>? posts,
    bool? loadingPosts,
    CareerSuggestionResponseObject? getCareerSuggestionResp,
    SuggestedEventsResponse? getSuggestedEventsResp,
    SuggestedOpportunitiesResponse? getSuggestedOpportunitiesResp,
    SuggestedSubjectsResponse? getSubjectSuggstionResp,
    CareerRoadmapResponseObject? getCareerRoadmapResp,
    bool? isSuggestionsLoaded,
    bool? isRoadmapLoaded,
    bool? isNewCareer,
    bool? isOpportunitiesLoaded,
    bool? isEventsLoaded,
    List<Job>? jobPostings,
    Map<String, dynamic>? userData,
    bool? isJobsLoaded,
    int? loadingMilestone,
  }) {
    return HomeState(
      searchController: searchController ?? this.searchController,
      homeModelObj: homeModelObj ?? this.homeModelObj,
      posts: posts ?? this.posts,
      jobPostings: jobPostings ?? this.jobPostings,
      loadingPosts: loadingPosts ?? this.loadingPosts,
      getCareerSuggestionResp: getCareerSuggestionResp ?? this.getCareerSuggestionResp,
      getSuggestedEventsResp: getSuggestedEventsResp ?? this.getSuggestedEventsResp,
      getSuggestedOpportunitiesResp: getSuggestedOpportunitiesResp ?? this.getSuggestedOpportunitiesResp,
      getSubjectSuggstionResp: getSubjectSuggstionResp ?? this.getSubjectSuggstionResp,
      getCareerRoadmapResp: getCareerRoadmapResp ?? this.getCareerRoadmapResp,
      isSuggestionsLoaded: isSuggestionsLoaded ?? this.isSuggestionsLoaded,
      isRoadmapLoaded: isRoadmapLoaded ?? this.isRoadmapLoaded,
      isNewCareer: isNewCareer ?? this.isNewCareer,
      isEventsLoaded: isEventsLoaded ?? this.isEventsLoaded,
      isOpportunitiesLoaded: isOpportunitiesLoaded ?? this.isOpportunitiesLoaded,
      userData: userData ?? this.userData,
      isJobsLoaded: isJobsLoaded ?? this.isJobsLoaded,
      loadingMilestone: loadingMilestone ?? this.loadingMilestone,
    );
  }
}
