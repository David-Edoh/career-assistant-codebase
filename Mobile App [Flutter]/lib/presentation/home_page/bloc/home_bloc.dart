import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fotisia/data/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/long_wait_animation_provider.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/apiClient/network_interceptor.dart';
import '../../../data/models/HomePage/career_suggestion_resp.dart';
import '../../../data/models/HomePage/event_suggestion_resp.dart';
import '../../../data/models/HomePage/jobs_response.dart';
import '../../../data/models/HomePage/opportunity_suggestion_resp.dart';
import '../../../data/models/HomePage/subject_suggestion_resp.dart';
import '../../../data/models/HomePage/user_roadmap_resp.dart';
import '../../feeds_page/models/get_feeds_resp.dart';
import '/core/app_export.dart';
import '../models/home_item_model.dart';
import 'package:fotisia/presentation/home_page/models/home_model.dart';
part 'home_event.dart';
part 'home_state.dart';

/// A bloc that manages the state of a Home according to the event that is dispatched to it.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(initialState) {
    on<GetSuggestionsEvent>(getCareerSuggestionEvent);
    on<GetUserEvent>(getUser);
    on<GetRoadmapEvent>(getRoadmap);
    on<GetOpportunitiesEvent>(getOpportunitiesEvent);
    on<GetEvents>(getEventsData);
    // on<GetArticles>(getArticleFeeds);
    // on<GetJobsAds>(getJobAds);
  }
  final _apiClient = ApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  var getCareerSuggestionResp = CareerSuggestionResponseObject();
  var getSubjectSuggestionResp = SuggestedSubjectsResponse();
  var getCareerRoadmapResp = CareerRoadmapResponseObject();

  bool isNewCareer = true;

  List<HomeItemModel> fillHomeItemList() {
    return List.generate(2, (index) => HomeItemModel());
  }

  getOpportunitiesEvent(
      GetOpportunitiesEvent event,
      Emitter<HomeState> emit,
      ) async {
        await getOpportunities(event, emit);
      }

  getRoadmap(
      GetRoadmapEvent event,
      Emitter<HomeState> emit,
      ) async {
        await getUsersRoadmap(event, emit);
      }

  getUser(
      GetUserEvent event,
      Emitter<HomeState> emit,
      ) async {
        await _apiClient.getResume();
        await getUserData(event, emit);
        await getArticleFeeds(event, emit);
        await getJobAds(event, emit);
      }

  getEventsData(
      GetEvents event,
      Emitter<HomeState> emit,
      ) async {
        await getEvents(event, emit);
      }

  getCareerSuggestionEvent(
      GetSuggestionsEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(
      isSuggestionsLoaded: false,
    ));

    await getCareerSuggestions(event, emit);
  }

  Future<void> getUserData(
      HomeEvent event,
      Emitter<HomeState> emit,
      )
  async {
    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    emit(state.copyWith(
      userData: userData,
    ));
  }

  FutureOr<void> getJobAds(
      GetUserEvent event,
      Emitter<HomeState> emit,
      {bool getUpdated = true}
      ) async {

    const storage = FlutterSecureStorage();

    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/careersuggestions/jobs/${userData['id']}";

    await _apiClient.getData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: path,
      showLoading: false,
    ).then((value) async {
      JobResponse jobsResponse = JobResponse.fromJson(value);

      print("User's jobs loaded");
      emit(state.copyWith(
        jobPostings: jobsResponse.jobs,
        isJobsLoaded: true,
        loadingMilestone: state.loadingMilestone + 1,
      ));

      if(getUpdated) await _apiClient.getUpdate(getJobAds, path, emit, event);
      return;
    }).onError((error, stackTrace) {
      // TODO: implement error call
      print(error);
      emit(state.copyWith(
        isJobsLoaded: true,
        loadingMilestone: state.loadingMilestone + 1,
      ));
      //   event.onLoginEventError?.call();
    });
  }

  FutureOr<void> getCareerSuggestions(
      HomeEvent event,
      Emitter<HomeState> emit,
      {bool getUpdated = true}
      ) async {

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/careersuggestions/${userData['id']}";

    await _apiClient.getData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        showLoading: false,
    ).then((value) async {

      emit(state.copyWith(
        isNewCareer: true,
      ));
      getCareerSuggestionResp = CareerSuggestionResponseObject.fromJson(value);

      print("user's career suggestions loaded");
      _onCareerSuggestionLoaded(getCareerSuggestionResp, emit);
      if(getUpdated) await _apiClient.getUpdate(getCareerSuggestions, path, emit, event);
      return;
    }).onError((error, stackTrace) {
      emit(state.copyWith(
        isNewCareer: true,
        isSuggestionsLoaded: true,
        loadingMilestone: state.loadingMilestone + 1,
      ));
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }

  FutureOr<void> getUsersRoadmap(
      HomeEvent event,
      Emitter<HomeState> emit,
      {bool getUpdated = true}
      ) async {

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/careersuggestions/roadmap/${userData['id']}";

    await _apiClient.getData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        showLoading: false,
    ).then((value) async {
      print(value['careerRoadmap']);
      getCareerRoadmapResp = CareerRoadmapResponseObject.fromJson(value);

      if(getCareerRoadmapResp.careerRoadmap != null) {
        print("User's roadmap loaded");
        emit(
          state.copyWith(
            getCareerRoadmapResp: getCareerRoadmapResp,
            isRoadmapLoaded: true,
            loadingMilestone: state.loadingMilestone + 1,
          ),
        );

      } else {
        emit(state.copyWith(
              isRoadmapLoaded: true,
              loadingMilestone: state.loadingMilestone + 1,
          ));
      }

      if(getUpdated) await _apiClient.getUpdate(getUsersRoadmap, path, emit, event);
      return;
    }).onError((error, stackTrace) {
      print(error);
      emit(state.copyWith(
        isRoadmapLoaded: true,
        loadingMilestone: state.loadingMilestone + 1,
      ));
      print(stackTrace);
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }


  FutureOr<void> getArticleFeeds(
      GetUserEvent event,
      Emitter<HomeState> emit,
      {bool getUpdated = true}
      ) async {
    // Check cache for if recent articles are available
    final prefs = await SharedPreferences.getInstance();

    // Get the current date and the end of the day
    final DateTime now = DateTime.now();
    final DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final String? cachedPosts = prefs.getString("cachedPosts");
    final int? cacheExpiry = prefs.getInt("cacheExpiry");

    if (cachedPosts != null && cacheExpiry != null && cacheExpiry > now.millisecondsSinceEpoch && json.decode(cachedPosts)["posts"].isNotEmpty) {
      PostsResponse postsResponse = PostsResponse.fromJson(json.decode(cachedPosts));
      List<Object> postsWithAds = List.from(postsResponse.posts as Iterable);

      print("User's articles loaded from cache");
      emit(state.copyWith(
        posts: postsResponse.posts,
        loadingPosts: false,
      ));
      return;
    }

    // No valid cache, fetch from API
    if(getUpdated){
      emit(state.copyWith(
        loadingPosts: true,
      ));
    }
    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/home/personalized-news";

    try{
      dynamic value = await _apiClient.getResume();
      String userResume = json.encode(value['userResumeDetails']);

      await _apiClient.postData(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer ${userData['accessToken']}"
          },
          path: path,
          requestData: {"userResumeDetail": userResume},
          showProgress: false
      ).then((value) async {
        PostsResponse postsResponse = PostsResponse.fromJson(value);
        // Save to cache
        if(postsResponse.posts != null && postsResponse.posts!.isNotEmpty){
          await prefs.setString("cachedPosts", json.encode(postsResponse));
          await prefs.setInt("cacheExpiry", endOfDay.millisecondsSinceEpoch);
        }

        print("User's articles loaded");
        emit(state.copyWith(
          posts: postsResponse.posts,
          loadingPosts: false,
        ));

        // event.onLoginEventSuccess?.call();
      });
    } catch (error){
      print(error);
      emit(state.copyWith(
        loadingPosts: false,
      ));
    }
  }

  FutureOr<void> getOpportunities(
      HomeEvent event,
      Emitter<HomeState> emit,
      {bool getUpdated = true}
      ) async {

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/careersuggestions/opportunities/${userData['id']}";

    await _apiClient.getData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        showLoading: false,
    ).then((value) async {

      try{
        SuggestedOpportunitiesResponse opportunitiesResponseResp = SuggestedOpportunitiesResponse.fromJson(value);

        print("User's opportunities loaded");
        emit(
          state.copyWith(
            getSuggestedOpportunitiesResp: opportunitiesResponseResp,
            isOpportunitiesLoaded: true,
            loadingMilestone: state.loadingMilestone + 1,
          ),
        );


      } catch (e){
        print(e);
        emit(
          state.copyWith(
            isOpportunitiesLoaded: true,
            loadingMilestone: state.loadingMilestone + 1,
          ),
        );
      }

      if(getUpdated) await _apiClient.getUpdate(getOpportunities, path, emit, event);
      return;
    }).onError((error, stackTrace) {
      // TODO: implement error call
      //   event.onLoginEventError?.call();
      emit(
        state.copyWith(
          isOpportunitiesLoaded: true,
          loadingMilestone: state.loadingMilestone + 1,
        ),
      );
    });
  }


  FutureOr<void> getEvents(
      HomeEvent event,
      Emitter<HomeState> emit,
      {bool getUpdated = true}
      ) async {

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/careersuggestions/events/${userData['id']}";

    await _apiClient.getData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        showLoading: false
    ).then((value) async {
      try{
        SuggestedEventsResponse eventsResponseResp = SuggestedEventsResponse.fromJson(value);

        print("User's events loaded");
        emit(
          state.copyWith(
            getSuggestedEventsResp: eventsResponseResp,
            isEventsLoaded: true,
            loadingMilestone: state.loadingMilestone + 1,
          ),
        );

        if(getUpdated) await _apiClient.getUpdate(getEvents, path, emit, event);
        return;
      } catch (e){
        print(e);
        emit(
          state.copyWith(
            isEventsLoaded: true,
            loadingMilestone: state.loadingMilestone + 1,
          ),
        );
      }

    }).onError((error, stackTrace) {

      // TODO: implement error call
      //   event.onLoginEventError?.call();
      emit(
        state.copyWith(
          isEventsLoaded: true,
          loadingMilestone: state.loadingMilestone + 1,
        ),
      );
    });
  }

  void _onCareerRoadmapLoaded(
      CareerRoadmapResponseObject resp,
      Emitter<HomeState> emit,
      ) {

  }

  void _onCareerSuggestionLoaded(
      CareerSuggestionResponseObject resp,
      Emitter<HomeState> emit,
      ) {
    emit(
      state.copyWith(
        getCareerSuggestionResp: resp,
      ),
    );

    emit(state.copyWith(
      isSuggestionsLoaded: true,
      loadingMilestone: state.loadingMilestone + 1,
    ));
  }

  void _onSubjectSuggestionLoaded(
      SuggestedSubjectsResponse resp,
      Emitter<HomeState> emit,
      ) {
    emit(
      state.copyWith(
        getSubjectSuggstionResp: resp,
      ),
    );

    emit(state.copyWith(
      isSuggestionsLoaded: true,
      loadingMilestone: state.loadingMilestone + 1,
    ));
  }


}
