import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../data/apiClient/api_client.dart';
import '../models/notification_resp.dart';
import '/core/app_export.dart';
import '../models/listlogo_one_item_model.dart';
import 'package:fotisia/presentation/notifications_general_page/models/notifications_general_model.dart';
part 'notifications_general_event.dart';
part 'notifications_general_state.dart';

/// A bloc that manages the state of a NotificationsGeneral according to the event that is dispatched to it.
class NotificationsGeneralBloc
    extends Bloc<NotificationsGeneralEvent, NotificationsGeneralState> {
  NotificationsGeneralBloc(NotificationsGeneralState initialState)
      : super(initialState) {
    on<NotificationsGeneralInitialEvent>(_onInitialize);
  }

  final _apiClient = ApiClient();


  _onInitialize(
    NotificationsGeneralInitialEvent event,
    Emitter<NotificationsGeneralState> emit,
  ) async {
    await getNotifications(event, emit);
  }


  FutureOr<void> getNotifications(
      NotificationsGeneralInitialEvent event,
      Emitter<NotificationsGeneralState> emit,
      {bool getUpdated = true}
      ) async {

    if(getUpdated){
      emit(state.copyWith(
        // loadingNotifications: true,
      ));
    }

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/notification/user/${userData['id']}";

    await _apiClient.getData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        showLoading: false
    ).then((value) async {
      debugPrint(value.toString());

      NotificationApiResponse notificationApiResponse = NotificationApiResponse.fromJson(value);
      emit(state.copyWith(
        notifications: notificationApiResponse.notifications,
      ));

      if(getUpdated) await _apiClient.getUpdate(getNotifications, path, emit, event);
      return;
      // event.onLoginEventSuccess?.call();

    }).onError((error, stackTrace) {
      print(error);
      emit(state.copyWith(
        // loadingNotifications: false,
      ));
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });
  }

  List<ListlogoOneItemModel> fillListlogoOneItemList() {
    return List.generate(4, (index) => ListlogoOneItemModel());
  }
}
