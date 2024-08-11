import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/HomePage/career_suggestion_resp.dart';
import '../models/get_feeds_resp.dart';
import '/core/app_export.dart';
import '../models/search_user_model.dart';
import 'package:fotisia/presentation/search_screen/models/search_model.dart';
part 'search_event.dart';
part 'search_state.dart';

/// A bloc that manages the state of a Search according to the event that is dispatched to it.
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(SearchState initialState) : super(initialState) {
    on<SearchInitialEvent>(_onInitialize);
    on<FindEvent>(_find);
  }

  List<SearchUserModel> fillSearchItemList() {
    return List.generate(4, (index) => SearchUserModel());
  }

  final _apiClient = ApiClient();

  _onInitialize(
    SearchInitialEvent event,
    Emitter<SearchState> emit,
  ) async {

    emit(state.copyWith(
        searchController: TextEditingController(),
    ));
  }

  _find(
      FindEvent event,
      Emitter<SearchState> emit,
      ) async {
    // emit(state.copyWith(
    //     searchController: TextEditingController(),
    // ));

    if(state.searchController!.text.isEmpty){
      emit(state.copyWith(
        posts: <Post>[],
        users: <User>[],
      ));
      return;
    }

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/home/search?text=${state.searchController?.text}";

    await _apiClient.getData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        showLoading: false,
        useCache: false,
    ).then((value) async {
    try{
      List<Post> posts = <Post>[];
      List<User> users = <User>[];

      if(value['posts'] != null){
        value['posts'].forEach((post) {
          if(post['media'] == '[]') post['media'] = [];
          posts!.add(Post.fromJson(post));
        });
      }


      // print('finding users');
      if(value['users'] != null){
        value['users'].forEach((user) {
          users!.add(User.fromJson(user));
        });
      }


      emit(state.copyWith(
        posts: posts,
        users: users,
      ));

    } catch (e) {
      print(e);
    }


    }).onError((error, stackTrace) {
      print(error);
      emit(state.copyWith(

      ));
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }
}
