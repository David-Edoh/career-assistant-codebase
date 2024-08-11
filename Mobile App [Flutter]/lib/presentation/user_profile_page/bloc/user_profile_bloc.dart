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
import '/core/app_export.dart';
import '../models/chipviewskills_item_model.dart';
import '../models/user_profile_item_model.dart';
import 'package:fotisia/presentation/user_profile_page/models/user_profile_model.dart';
part 'user_profile_event.dart';
part 'user_profile_state.dart';

/// A bloc that manages the state of a Profile according to the event that is dispatched to it.
class UserProfileBloc extends Bloc<ProfileEvent, UserProfileState> {
  UserProfileBloc(UserProfileState initialState) : super(initialState) {
    on<UserProfileInitialEvent>(_onInitialize);
    on<AddFriend>(_addFriend);
    on<CancelFriendRequest>(_cancelFriendRequest);
    on<AcceptFriendRequest>(_acceptFriendRequest);
    on<RejectFriendRequest>(_rejectFriendRequest);
    on<UnFriend>(_unfriend);
  }
  final _apiClient = ApiClient();



  _onInitialize(
    UserProfileInitialEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    String path = "api/user/profile/${event.userId}";
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
        UserResumeDetails user = UserResumeDetails.fromJson(value['user']);

        emit(
            state.copyWith(
              firstName: user.firstName ?? "Add phone number",
              lastName: user.lastName ?? "",
              email: user.email ?? "Not set",
              phone: user.phoneNumber ?? "Not set",
              aboutMe: user.about ?? "Add about me",
              location: user.address ?? "Not set",
              website: user.website ?? "Add website",
              skills: user.skills,
              experiences: user.experiences,
              educations: user.educations,
              projects: user.projects,
              references: user.references,
              socials: user.socials,
              picturePath: user.picturePath,
              fetchingCareerDetailsDone: true,
              friendshipState: user.state,
              relationship: user.relationship,
              currentUserId: int.parse(userData['id'].toString())
            )
        );

      }catch (e){
        print(e);
      }
    }).onError((error, stackTrace) {
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }

  _addFriend(
      AddFriend event,
      Emitter<UserProfileState> emit,
      ) async {

    emit(state.copyWith(
          changingFriendshipStateDone: false,
        )
    );

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    String path = "api/relationship/sendFriendRequest/${event.userId}";
    await _apiClient.postData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: path,
      requestData: {},
    ).then((value) async {

      try{
        Relationship relationship = Relationship.fromJson(value['relationship']);
        emit(
            state.copyWith(
              changingFriendshipStateDone: true,
              friendshipState: 'pending',
              relationship: relationship,
              currentUserId: int.parse(userData['id'].toString())
            )
        );
        Fluttertoast.showToast(msg: "Friend request sent", toastLength: Toast.LENGTH_LONG);
      } catch (e) {
        print(e);
        Fluttertoast.showToast(msg: "Failed sending friend request", toastLength: Toast.LENGTH_LONG);
      }

    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: "Failed sending friend request", toastLength: Toast.LENGTH_LONG);
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }


  _cancelFriendRequest(
      CancelFriendRequest event,
      Emitter<UserProfileState> emit,
      ) async {

    emit(state.copyWith(
      changingFriendshipStateDone: false,
    )
    );

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    String path = "api/relationship/request/${event.relationshipId}";
    await _apiClient.deleteData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: path,
    ).then((value) async {

      try{
        print(value);
        emit(
            state.copyWith(
              changingFriendshipStateDone: true,
              friendshipState: 'Not Friends',
            )
        );
        Fluttertoast.showToast(msg: "Friend request canceled", toastLength: Toast.LENGTH_LONG);
      }catch (e){
        print(e);
        Fluttertoast.showToast(msg: "Failed canceling friend request", toastLength: Toast.LENGTH_LONG);
      }

    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: "Failed canceling friend request", toastLength: Toast.LENGTH_LONG);
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }


  _acceptFriendRequest(
      AcceptFriendRequest event,
      Emitter<UserProfileState> emit,
      ) async {

    emit(state.copyWith(
      changingFriendshipStateDone: false,
    )
    );

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    String path = "api/relationship/response/accept/${event.relationshipId}";
    await _apiClient.patchData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: path,
      requestData: {},
    ).then((value) async {

      try{
        Relationship relationship = Relationship.fromJson(value['relationship']);
        emit(
            state.copyWith(
              changingFriendshipStateDone: true,
              friendshipState: 'friends',
              relationship: relationship,
            )
        );

        Fluttertoast.showToast(msg: "Friend request accepted", toastLength: Toast.LENGTH_LONG);
      } catch (e) {
        print(e);
        Fluttertoast.showToast(msg: "Failed accepting friend request", toastLength: Toast.LENGTH_LONG);
      }

    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: "Failed accepting friend request", toastLength: Toast.LENGTH_LONG);
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }


  _rejectFriendRequest(
      RejectFriendRequest event,
      Emitter<UserProfileState> emit,
      ) async {

      emit(state.copyWith(
          changingFriendshipStateDone: false,
        )
      );

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    String path = "api/relationship/response/reject/${event.relationshipId}";
    await _apiClient.deleteData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: path,
    ).then((value) async {

      try{
        emit(
            state.copyWith(
              changingFriendshipStateDone: true,
              friendshipState: 'Not Friends',
            )
        );

        Fluttertoast.showToast(msg: "Friend request rejected", toastLength: Toast.LENGTH_LONG);
      } catch (e) {
        print(e);
        Fluttertoast.showToast(msg: "Failed rejecting friend request", toastLength: Toast.LENGTH_LONG);
      }

    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: "Failed rejecting friend request", toastLength: Toast.LENGTH_LONG);
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }


  _unfriend(
      UnFriend event,
      Emitter<UserProfileState> emit,
      ) async {

    emit(state.copyWith(
      changingFriendshipStateDone: false,
    )
    );

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    String path = "api/relationship/removeFriend/${event.userId}";
    await _apiClient.deleteData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: path,
    ).then((value) async {

      try{
        emit(
            state.copyWith(
              changingFriendshipStateDone: true,
              friendshipState: 'Not Friends',
            )
        );

        Fluttertoast.showToast(msg: "Friend removed", toastLength: Toast.LENGTH_LONG);
      } catch (e) {
        print(e);
        Fluttertoast.showToast(msg: "Failed removing friend", toastLength: Toast.LENGTH_LONG);
      }

    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: "Failed removing friend", toastLength: Toast.LENGTH_LONG);
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }

}
