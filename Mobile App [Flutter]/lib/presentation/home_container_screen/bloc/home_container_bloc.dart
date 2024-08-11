import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/HomePage/career_suggestion_resp.dart';
import '../../feeds_page/models/get_feeds_resp.dart';
import '/core/app_export.dart';
import 'package:fotisia/presentation/home_container_screen/models/home_container_model.dart';
part 'home_container_event.dart';
part 'home_container_state.dart';

/// A bloc that manages the state of a HomeContainer according to the event that is dispatched to it.
class HomeContainerBloc extends Bloc<HomeContainerEvent, HomeContainerState> {
  HomeContainerBloc(HomeContainerState initialState) : super(initialState) {
    on<HomeContainerInitialEvent>(_onInitialize);
    on<TogglePanelController>(_togglePanelController);
    on<SetCloseSlideUpPanel>(_closePanelController);
    on<PostCommentEvent>(_postComment);
    on<TogglePostReactionEvent>(_togglePostReaction);
    on<DeletePostReactionEvent>(_deletePostReaction);
    on<DeleteCommentEvent>(_deleteComment);
  }
  final _apiClient = ApiClient();

  _onInitialize(
    HomeContainerInitialEvent event,
    Emitter<HomeContainerState> emit,
  ) async {
    try{
      const storage = FlutterSecureStorage();
      String? jsonString = await storage.read(key: "userData");
      Map<String, dynamic> userData = json.decode(jsonString.toString());

      userData['id'] = int.parse(userData['id'].toString());

      User user = User.fromJson(userData);

      emit(state.copyWith(
        commentController: TextEditingController(),
        thisUser: user,
      ));
    } catch (e, stack){
      print(stack);
      print(e);
    }
  }

  _deletePostReaction(
      DeletePostReactionEvent event,
      Emitter<HomeContainerState> emit,
      ) async {

    try {
      const storage = FlutterSecureStorage();
      String? jsonString = await storage.read(key: "userData");
      Map<String, dynamic> userData = json.decode(jsonString.toString());
      String path = "api/reaction/delete/${event.reactionId}";

      // Make the POST request
      await _apiClient.deleteData(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer ${userData['accessToken']}"
          },
          showProgress: false,
          path: path,
          ).then((value) async {

        // Fluttertoast.showToast(msg: "Reaction added", toastLength: Toast.LENGTH_LONG);

        // emit(state.copyWith(
        //   sendingComment: false,
        //   commentController: TextEditingController(),
        // ));

      }).onError((error, stackTrace) {
        print(stackTrace);
        print(error);
        Fluttertoast.showToast(msg: "your reaction was not deleted", toastLength: Toast.LENGTH_LONG);
        // emit(state.copyWith(
        //   sendingComment: false,
        // ));
      });

    } catch (error, stackTrace) {
      print(stackTrace);
      print('Error removing reaction: $error');
      Fluttertoast.showToast(msg: "your reaction was not deleted", toastLength: Toast.LENGTH_LONG);
      emit(state.copyWith(
        sendingComment: false,
      ));
    }
  }

  _togglePostReaction(
      TogglePostReactionEvent event,
      Emitter<HomeContainerState> emit,
      ) async {
    emit(state.copyWith(
      activePost: event.postId,

    ));

    try {
      const storage = FlutterSecureStorage();
      String? jsonString = await storage.read(key: "userData");
      Map<String, dynamic> userData = json.decode(jsonString.toString());
      String path = "api/reaction/add/${event.postId}";

      // Make the POST request
      await _apiClient.postData(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer ${userData['accessToken']}"
          },
          showProgress: false,
          path: path,
          requestData: {
            "state": "like",
          }).then((value) async {

          // Fluttertoast.showToast(msg: "Reaction added", toastLength: Toast.LENGTH_LONG);

          // emit(state.copyWith(
          //   sendingComment: false,
          //   commentController: TextEditingController(),
          // ));

      }).onError((error, stackTrace) {
        print(stackTrace);
        print(error);
        Fluttertoast.showToast(msg: "your reaction was not added", toastLength: Toast.LENGTH_LONG);
        // emit(state.copyWith(
        //   sendingComment: false,
        // ));
      });

    } catch (error, stackTrace) {
      print(stackTrace);
      print('Error adding reaction: $error');
      Fluttertoast.showToast(msg: "your reaction was not added", toastLength: Toast.LENGTH_LONG);
      emit(state.copyWith(
        sendingComment: false,
      ));
    }
  }

  _postComment(
      PostCommentEvent event,
      Emitter<HomeContainerState> emit,
      ) async {

    await _addComment(event, emit);
    // emit(state.copyWith(
    //   openSlideUpPanel: false,
    // ));
  }


  _addComment(
      PostCommentEvent event,
      Emitter<HomeContainerState> emit,
      ) async {

      emit(state.copyWith(
        sendingComment: true,
      ));

      try {
        const storage = FlutterSecureStorage();
        String? jsonString = await storage.read(key: "userData");
        Map<String, dynamic> userData = json.decode(jsonString.toString());
        String path = "api/comment/add/${state.postId}";


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

              Comment comment = Comment.fromJson(value);

              List<Comment> updatedComments = List.from(state.comments!)
                  ..add(comment);

              List<Object> commentsWithAds = List.from(updatedComments as Iterable);
              for(int i = 1 ; i<=(updatedComments!.length/4).round(); i ++){
                var min = 1;
                var rm = new Random();
                //generate a random number from 2 to 18 (+ 1)
                int rannumpos = min + rm.nextInt(updatedComments!.length - 1);
                //and add the banner ad to particular index of arraylist
                commentsWithAds.insert(rannumpos, "Place an ad here");
              }

              emit(state.copyWith(
                sendingComment: false,
                commentController: TextEditingController(),
                comments: updatedComments,
                commentsWithAds: commentsWithAds,
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


  _deleteComment(
      DeleteCommentEvent event,
      Emitter<HomeContainerState> emit,
      ) async {

    emit(state.copyWith(
      sendingComment: true,
    ));

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

  _togglePanelController(
      TogglePanelController event,
      Emitter<HomeContainerState> emit,
      ) async {
    emit(state.copyWith(
      loadingComments: true,
      panelController: PanelController(),
      openSlideUpPanel: true,
    ));

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/comment/all/post/${event.postId}";

    await _apiClient.getData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        useCache: false,
        showLoading: false
    ).then((value) async {
      try{
        List<Comment> comments = <Comment>[];

        value.forEach((comment) {
          comments!.add(Comment.fromJson(comment));
        });

        List<Object> commentsWithAds = List.from(comments as Iterable);
        for(int i = 1 ; i<=(comments!.length/4).round(); i ++){
          var min = 1;
          var rm = new Random();
          //generate a random number from 2 to 18 (+ 1)
          int rannumpos = min + rm.nextInt(comments!.length - 1);
          //and add the banner ad to particular index of arraylist
          commentsWithAds.insert(rannumpos, "Place an ad here");
        }

        emit(state.copyWith(
          panelController: PanelController(),
          openSlideUpPanel: true,
          postId: event.postId,
          comments: comments,
          commentsWithAds: commentsWithAds,
          loadingComments: false,
        ));
      } catch (error, stackTrace){
        print(stackTrace);
        print(error);
      }


      // event.onLoginEventSuccess?.call();
    }).onError((error, stackTrace) {
      // TODO: implement error call
      //   event.onLoginEventError?.call();
      print(stackTrace);
      print(error);
      emit(state.copyWith(
        loadingComments: true,
      ));
    });

  }

  _closePanelController(
      SetCloseSlideUpPanel event,
      Emitter<HomeContainerState> emit,
      ) async {
    emit(state.copyWith(
      openSlideUpPanel: false,
    ));
  }
}