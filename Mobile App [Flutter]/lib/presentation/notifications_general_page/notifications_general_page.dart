import 'package:fotisia/presentation/notifications_general_page/models/notification_resp.dart';

import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../notifications_general_page/widgets/listlogo_one_item_widget.dart';
import 'bloc/notifications_general_bloc.dart';
import 'models/listlogo_one_item_model.dart';
import 'models/notifications_general_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';

class NotificationsGeneralPage extends StatefulWidget {
  const NotificationsGeneralPage({Key? key}) : super(key: key);

  @override
  NotificationsGeneralPageState createState() =>
      NotificationsGeneralPageState();
  static Widget builder(BuildContext context) {
    return BlocProvider<NotificationsGeneralBloc>(
        create: (context) => NotificationsGeneralBloc(NotificationsGeneralState(
            notificationsGeneralModelObj: NotificationsGeneralModel()))
          ..add(NotificationsGeneralInitialEvent()),
        child: NotificationsGeneralPage());
  }
}

class NotificationsGeneralPageState extends State<NotificationsGeneralPage>
    with AutomaticKeepAliveClientMixin<NotificationsGeneralPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: appTheme.whiteA70001,
        appBar: CustomAppBar(
            leadingWidth: getHorizontalSize(50),
            height: getHorizontalSize(55),
            leading: Semantics(
              label: "Go back to feeds page",
              child: AppbarImage(
                  svgPath: ImageConstant.imgGroup162799,
                  margin: getMargin(left: 24, top: 13, bottom: 13),
                  onTap: () {
                    NavigatorService.goBack();
                  }),
            ),
            centerTitle: true,
            title: Semantics(
              label: "Page Title: Notifications Page",
                child: AppbarTitle(text: "Notifications")
            )
        ),
        body: SafeArea(
          child: Container(
              width: double.maxFinite,
              decoration: AppDecoration.fillWhiteA70001,
              child: Padding(
                  padding: getPadding(left: 24, right: 24),
                  child: BlocSelector<
                          NotificationsGeneralBloc,
                          NotificationsGeneralState,
                          List<NotificationItem>?>(
                      selector: (state) => state.notifications,
                      builder: (context, notifications) {
                        return (notifications != null && notifications!.isNotEmpty) ? ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return Padding(
                                  padding: getPadding(top: 7.5, bottom: 7.5),
                                  child: SizedBox(
                                      width: getHorizontalSize(323),
                                      child: Divider(
                                          height: getVerticalSize(1),
                                          thickness: getVerticalSize(1),
                                          color: appTheme.indigo50)));
                            },
                            itemCount: notifications?.length ?? 0,
                            itemBuilder: (context, index) {
                              NotificationItem? model = notifications?[index];
                              return ListlogoOneItemWidget(model);
                            }) : const Center(
                          child: Text(
                            "No notification at the moment"
                          )
                        );
                      })
              )
          ),
        ));
  }
}
