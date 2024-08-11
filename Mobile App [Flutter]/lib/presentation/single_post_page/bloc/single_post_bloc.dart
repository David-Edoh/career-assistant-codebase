import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/loginAuth/post_login_auth_resp.dart';
import '../../../data/models/resume/user_resume_details.dart';
import '../models/get_feeds_resp.dart';
import '/core/app_export.dart';
// import 'package:fotisia/presentation/user_profile_page/models/single_post_model.dart';
part 'single_post_event.dart';
part 'single_post_state.dart';

/// A bloc that manages the state of a Profile according to the event that is dispatched to it.
class SinglePostBloc extends Bloc<SinglePostEvent, SinglePostState> {
  SinglePostBloc(SinglePostState initialState) : super(initialState) {
    on<SinglePostInitialEvent>(_onInitialize);
    on<UpdatePostEvent>(_updatePost);
    on<DeletePostEvent>(_deletePost);
    on<DeleteCommentEvent>(_deleteComment);
    on<PostCommentEvent>(_postComment);

  }
  final _apiClient = ApiClient();

  _updatePost(
      UpdatePostEvent event,
      Emitter<SinglePostState> emit,
      ) async {
    // emit(state.copyWith(posts: event.posts));
  }

  _onInitialize(
    SinglePostInitialEvent event,
    Emitter<SinglePostState> emit,
  ) async {

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    String path = "api/post/${event.postId}";
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
        Post post = Post.fromJson(value);

        userData['id'] = int.parse(userData['id'].toString());

        User user = User.fromJson(userData);

        emit(
            state.copyWith(
              post: post,
              thisUser: user,
              activePost: event.postId,
              comments: post.comments,
              commentController: TextEditingController(),
            )
        );

      }catch (error, stackTrace){
        print(stackTrace);
        print(error);
      }
    }).onError((error, stackTrace) {
      print(stackTrace);
      print(error);
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }

  _deletePost(
      DeletePostEvent event,
      Emitter<SinglePostState> emit,
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


        // List<Post> updatedPosts = List.from(state.posts!)
        //   ..removeWhere((post) => post.id == event.postId);
        //
        // emit(state.copyWith(
        //     posts: updatedPosts
        // ));

        Fluttertoast.showToast(msg: "post Deleted", toastLength: Toast.LENGTH_LONG);
        NavigatorService.goBack();

      }).onError((error, stackTrace) {
        print(stackTrace);
        print(error);
        Fluttertoast.showToast(msg: "post was not Deleted", toastLength: Toast.LENGTH_LONG);
        emit(state.copyWith(
          // sendingComment: false,
        ));
      });

    } catch (error, stackTrace) {
      print(stackTrace);
      print('Error deleting post: $error');
      Fluttertoast.showToast(msg: "Post was not deleted", toastLength: Toast.LENGTH_LONG);
      emit(state.copyWith(
        // sendingComment: false,
      ));
    }
  }

  _deleteComment(
      DeleteCommentEvent event,
      Emitter<SinglePostState> emit,
      ) async {

    // emit(state.copyWith(
    //   sendingComment: true,
    // ));

    try {
      const storage = FlutterSecureStorage();
      String? jsonString = await storage.read(key: "userData");
      Map<String, dynamic> userData = json.decode(jsonString.toString());
      String path = "api/comment/delete/${event.commentId}";


      // Make the POST request
      await _apiClient.deleteData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        showProgress: false,
        path: path,
      ).then((value) async {
        //Update comments state...

        List<Comment> updatedComments = List.from(state.comments!)
          ..removeWhere((comment) => comment.id == event.commentId);

        emit(state.copyWith(
          // sendingComment: false,
            commentController: TextEditingController(),
            comments: updatedComments
        ));

        Fluttertoast.showToast(msg: "Comment Deleted", toastLength: Toast.LENGTH_LONG);

      }).onError((error, stackTrace) {
        print(stackTrace);
        print(error);
        Fluttertoast.showToast(msg: "Comment was not Deleted", toastLength: Toast.LENGTH_LONG);
        emit(state.copyWith(
          // sendingComment: false,
        ));
      });

    } catch (error, stackTrace) {
      print(stackTrace);
      print('Error deleting comment: $error');
      Fluttertoast.showToast(msg: "Comment was not Deleted", toastLength: Toast.LENGTH_LONG);
      emit(state.copyWith(
        // sendingComment: false,
      ));
    }
  }

  _postComment(
      PostCommentEvent event,
      Emitter<SinglePostState> emit,
      ) async {

    await _addComment(event, emit);
    // emit(state.copyWith(
    //   openSlideUpPanel: false,
    // ));
  }


  _addComment(
      PostCommentEvent event,
      Emitter<SinglePostState> emit,
      ) async {

    emit(state.copyWith(
      sendingComment: true,
    ));

    try {
      const storage = FlutterSecureStorage();
      String? jsonString = await storage.read(key: "userData");
      Map<String, dynamic> userData = json.decode(jsonString.toString());
      print(state.activePost);
      String path = "api/comment/add/${state.activePost}";


      // Make the POST request
      await _apiClient.postData(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer ${userData['accessToken']}"
          },
          path: path,
          requestData: {
            "text": state.commentController!.text,
          }).then((value) async {
        //Update comments state...

        print(value);
        Comment comment = Comment.fromJson(value);

        print(comment);
        List<Comment> updatedComments = List.from(state.comments!)
          ..add(comment);

        print(state.comments?.length);

        emit(state.copyWith(
            sendingComment: false,
            commentController: TextEditingController(),
            comments: updatedComments
        ));

        Fluttertoast.showToast(msg: "Comment added", toastLength: Toast.LENGTH_LONG);

      }).onError((error, stackTrace) {
        print(stackTrace);
        print(error);
        Fluttertoast.showToast(msg: "Comment was not added", toastLength: Toast.LENGTH_LONG);
        emit(state.copyWith(
          sendingComment: false,
        ));
      });

    } catch (error, stackTrace) {
      print(stackTrace);
      print('Error adding comment: $error');
      Fluttertoast.showToast(msg: "Comment was not added", toastLength: Toast.LENGTH_LONG);
      emit(state.copyWith(
        sendingComment: false,
      ));
    }
  }
}
