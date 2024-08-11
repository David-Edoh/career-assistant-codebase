import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../data/apiClient/api_client.dart';
import '../models/get_feeds_resp.dart';
import '/core/app_export.dart';
import '../models/listlogo_one_item_model.dart';
import 'package:fotisia/presentation/feeds_page/models/feeds_page_model.dart';
part 'feeds_page_event.dart';
part 'feeds_page_state.dart';

/// A bloc that manages the state of a Feeds according to the event that is dispatched to it.
class FeedsBloc
    extends Bloc<FeedsEvent, FeedsState> {
  FeedsBloc(FeedsState initialState)
      : super(initialState) {
    on<FeedsInitialEvent>(_onInitialize);
    on<NextFeedsEvents>(nextSetOfPostFeeds);
    on<ShowAddPost>(showAddPost);
    on<AddPost>(addPost);
    on<SetImages>(setImages);
    on<SetVideos>(setVideos);
    on<ClearImagesEvent>(clearImagesEvents);
    on<CloseCreatePostWidgetEvent>(closeCreatePostWidgetEvent);
    on<UpdatePostEvent>(_updatePost);
    on<DeletePostEvent>(_deletePost);

  }

  final _apiClient = ApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  _updatePost(
      UpdatePostEvent event,
      Emitter<FeedsState> emit,
      ) async {
    emit(state.copyWith(posts: event.posts));
  }

  _onInitialize(
    FeedsInitialEvent event,
    Emitter<FeedsState> emit,
  ) async {
    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset){
        add(NextFeedsEvents());
      }
    });

    emit(state.copyWith(
        page: 1,
        newPostTextController: TextEditingController(),
        scrollController: scrollController,
    ));
    await getArticleFeeds(event, emit);
    await getPostFeeds(event, emit);
  }

  setImages(
      SetImages event,
      Emitter<FeedsState> emit,
      ) async {
    emit(state.copyWith(images: event.images));
  }

  clearImagesEvents(
      ClearImagesEvent event,
      Emitter<FeedsState> emit,
      ) async {
    emit(state.copyWith(videos: [], images: []));
  }

  setVideos(
      SetVideos event,
      Emitter<FeedsState> emit,
      ) async {
    emit(state.copyWith(videos: event.videos));
  }

  showAddPost(
      ShowAddPost event,
      Emitter<FeedsState> emit,
      ) async {
    emit(state.copyWith(addPost: true));
  }

  closeCreatePostWidgetEvent(
      CloseCreatePostWidgetEvent event,
      Emitter<FeedsState> emit,
      )
       async {
         emit(state.copyWith(addPost: false));
  }


  addPost(
      AddPost event,
      Emitter<FeedsState> emit,
      ) async {
      emit(state.copyWith(
        sendingPost: true,
      ));

      try {
        const storage = FlutterSecureStorage();
        String? jsonString = await storage.read(key: "userData");
        Map<String, dynamic> userData = json.decode(jsonString.toString());
        String path = "api/post/create";

        // Create FormData object to append files and description
        FormData formData = FormData();
        // print(state.images.length);

        // Append images to FormData
        if(state.images != null && state.images!.isNotEmpty) {
          for (int i = 0; i < state.images!.length; i++) {
            String fileName = state.images![i].split('/').last;
            formData.files.add(MapEntry(
              'photos',
              await MultipartFile.fromFile(
                state.images![i],
                filename: fileName,
              ),
            ));
          }
        }

        // print(formData.files.length);

        // Append videos to FormData
        if(state.videos != null && state.videos!.isNotEmpty){
          for (int i = 0; i < state.videos!.length; i++) {
            String fileName = state.videos![i].split('/').last;
            formData.files.add(MapEntry(
              'photos',
              await MultipartFile.fromFile(
                state.videos![i],
                filename: fileName,
              ),
            ));
          }
        }


        // Append description as JSON string
        formData.fields.add(MapEntry('text', state.newPostTextController!.text));

        // Make the POST request
        await _apiClient.postData(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': "Bearer ${userData['accessToken']}"
            },
            path: path,
            formData: formData
        ).then((value) async {
          try{
            if(value['media'] == "[]") value['media'] = [];

            Post post = Post.fromJson(value);

            List<Post> updatedPosts = List.from(state.posts!)
              ..insert(0, post);

            emit(state.copyWith(
              posts: updatedPosts,
              addPost: false,
              sendingPost: false,
              newPostTextController: TextEditingController(),
            ));

            Fluttertoast.showToast(msg: "Post added", toastLength: Toast.LENGTH_LONG);
          } catch(e){
            print(e);
            Fluttertoast.showToast(msg: "Post was not added", toastLength: Toast.LENGTH_LONG);
            emit(state.copyWith(
              sendingPost: false,
            ));
          }


        }).onError((error, stackTrace) {
          print(error);
          Fluttertoast.showToast(msg: "Post was not added", toastLength: Toast.LENGTH_LONG);
          emit(state.copyWith(
            sendingPost: false,
          ));
        });

      } catch (error) {
        print('Error during file upload: $error');
        Fluttertoast.showToast(msg: "Post was not added", toastLength: Toast.LENGTH_LONG);
        emit(state.copyWith(
          sendingPost: false,
        ));
      }
  }

  _deletePost(
      DeletePostEvent event,
      Emitter<FeedsState> emit,
      ) async {

    try {
      const storage = FlutterSecureStorage();
      String? jsonString = await storage.read(key: "userData");
      Map<String, dynamic> userData = json.decode(jsonString.toString());
      String path = "api/post/delete/${event.postId}";


      // Make the POST request
      await _apiClient.deleteData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        showProgress: false,
        path: path,
      ).then((value) async {
        //Update posts state...

        List<Post> updatedPosts = List.from(state.posts!)
          ..removeWhere((post) => post.id == event.postId);

        emit(state.copyWith(
            posts: updatedPosts
        ));

        Fluttertoast.showToast(msg: "post Deleted", toastLength: Toast.LENGTH_LONG);

      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: "post was not Deleted", toastLength: Toast.LENGTH_LONG);
        emit(state.copyWith(
          // sendingComment: false,
        ));
      });

    } catch (error) {
      print('Error deleting post: $error');
      Fluttertoast.showToast(msg: "Comment was not Deleted", toastLength: Toast.LENGTH_LONG);
      emit(state.copyWith(
        // sendingComment: false,
      ));
    }
  }

  Future<String> getUserResumeData() async {

    String? userResumeData = await _storage.read(key: "userResumeData");
    if(userResumeData != null){
      return userResumeData;
    }

    String resumeJson = "";
    String? jsonString = await _storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/resume/user/${userData['id']}";

    await _apiClient.getData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        showLoading: true
    ).then((value) async {
      resumeJson = value['userResumeDetails'];
    }).onError((error, stackTrace) {
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });

    return resumeJson;
  }

  FutureOr<void> getArticleFeeds(
      FeedsInitialEvent event,
      Emitter<FeedsState> emit,
      {bool getUpdated = true}
      ) async {
    // Check cache for if recent articles are available
    // final prefs = await SharedPreferences.getInstance();
    //
    // // Get the current date and the end of the day
    // final DateTime now = DateTime.now();
    // final DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    //
    // final String? cachedPosts = prefs.getString("cachedPosts");
    // final int? cacheExpiry = prefs.getInt("cacheExpiry");
    //
    // if (cachedPosts != null && cacheExpiry != null && cacheExpiry > now.millisecondsSinceEpoch) {
    //   PostsResponse postsResponse = PostsResponse.fromJson(json.decode(cachedPosts));
    //   List<Object> postsWithAds = List.from(postsResponse.posts as Iterable);
    //
    //   emit(state.copyWith(
    //     posts: postsResponse.posts,
    //     postsWithAds: postsWithAds,
    //     loadingPosts: false,
    //   ));
    //   return;
    // }
    //
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
    String userResume = await getUserResumeData();

    await _apiClient.postData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: path,
      requestData: {"userResumeDetail": userResume},
      showProgress: false,
    ).then((value) async {
      // print(value);
      PostsResponse postsResponse = PostsResponse.fromJson(value);
      // Save to cache
      // await prefs.setString("cachedPosts", json.encode(postsResponse));
      // await prefs.setInt("cacheExpiry", endOfDay.millisecondsSinceEpoch);

      List<Object> postsWithAds = List.from(postsResponse.posts as Iterable);

      // for(int i = 1 ; i<=(postsResponse.posts!.length/4).round(); i ++){
      //   var min = 1;
      //   var rm = new Random();
      //   //generate a random number from 2 to 18 (+ 1)
      //   int rannumpos = min + rm.nextInt(postsResponse.posts!.length - 1);
      //   //and add the banner ad to particular index of arraylist
      //   postsWithAds.insert(rannumpos, "Place an ad here");
      // }

      print(postsWithAds.length);

      emit(state.copyWith(
        posts: postsResponse.posts,
        postsWithAds: postsWithAds,
        loadingPosts: false,
      ));

      // event.onLoginEventSuccess?.call();

    }).onError((error, stackTrace) {
      print(error);
      emit(state.copyWith(
        loadingPosts: false,
      ));
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }

  FutureOr<void> getPostFeeds(
      FeedsInitialEvent event,
      Emitter<FeedsState> emit,
      {bool getUpdated = true}
      ) async {

      const storage = FlutterSecureStorage();
      String? jsonString = await storage.read(key: "userData");
      Map<String, dynamic> userData = json.decode(jsonString.toString());
      String path = "api/home/news?page=${state.page}&pageSize=15";

      await _apiClient.getData(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer ${userData['accessToken']}"
          },
          path: path,
          showLoading: false,
          useCache: false,
      ).then((value) async {

        PostsResponse postsResponse = PostsResponse.fromJson(value);

        List<Object> postsWithAds = List.from(postsResponse.posts as Iterable);
        // for(int i = 1 ; i<=(postsResponse.posts!.length/4).round(); i ++){
        //   var min = 1;
        //   var rm = new Random();
        //   //generate a random number from 2 to 18 (+ 1)
        //   int rannumpos = min + rm.nextInt(postsResponse.posts!.length - 1);
        //   //and add the banner ad to particular index of arraylist
        //   postsWithAds.insert(rannumpos, "Place an ad here");
        // }

        if(postsResponse.posts != null && postsResponse.posts!.isNotEmpty){
          emit(state.copyWith(
              posts: state.posts! + (postsResponse.posts as List<Post>),
              postsWithAds: state.postsWithAds! + postsWithAds,
          ));
        } else {
          emit(state.copyWith(
            hasMoreFeeds: false,
          ));
        }

        if(getUpdated) {
          emit(state.copyWith(page: (state.page ?? 1) + 1));
          await _apiClient.getUpdate(getPostFeeds, path, emit, event);
        }
        return;
        // event.onLoginEventSuccess?.call();

      }).onError((error, stackTrace) {
        print(error);
        emit(state.copyWith(
          loadingPosts: false,
        ));
        // TODO: implement error call
        //   event.onLoginEventError?.call();
      });
  }

  nextSetOfPostFeeds(
      NextFeedsEvents event,
      Emitter<FeedsState> emit,
      ) async {
    await getNextFeedsPage(event, emit);
  }

  FutureOr<void> getNextFeedsPage(
      NextFeedsEvents event,
      Emitter<FeedsState> emit,
      {bool getUpdated = true}
      ) async {

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/home/news?page=${state.page}&pageSize=15";

    await _apiClient.getData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        showLoading: false,
        useCache: false,
    ).then((value) async {
      PostsResponse postsResponse = PostsResponse.fromJson(value);

      List<Object> postsWithAds = List.from(postsResponse.posts as Iterable);
      // for(int i = 1 ; i<=(postsResponse.posts!.length/4).round(); i ++){
      //   var min = 1;
      //   var rm = new Random();
      //   //generate a random number from 2 to 18 (+ 1)
      //   int rannumpos = min + rm.nextInt(postsResponse.posts!.length - 1);
      //   //and add the banner ad to particular index of arraylist
      //   postsWithAds.insert(rannumpos, "Place an ad here");
      // }

      if(postsResponse.posts != null && postsResponse.posts!.isNotEmpty){
        emit(state.copyWith(
          posts: state.posts! + (postsResponse.posts as List<Post>),
          postsWithAds: state.postsWithAds! + postsWithAds,
          page: (state.page ?? 1) + 1
        ));
      } else {
        emit(state.copyWith(
          hasMoreFeeds: false,
        ));
      }

      // event.onLoginEventSuccess?.call();

    }).onError((error, stackTrace) {
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }


}
