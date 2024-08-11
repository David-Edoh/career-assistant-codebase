import '../notifications_my_proposals_page/widgets/listlocation_item_widget.dart';
import 'bloc/notifications_my_proposals_bloc.dart';
import 'models/listlocation_item_model.dart';
import 'models/notifications_my_proposals_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';

class NotificationsMyProposalsPage extends StatefulWidget {
  const NotificationsMyProposalsPage({Key? key}) : super(key: key);

  @override
  NotificationsMyProposalsPageState createState() =>
      NotificationsMyProposalsPageState();
  static Widget builder(BuildContext context) {
    return BlocProvider<NotificationsMyProposalsBloc>(
        create: (context) => NotificationsMyProposalsBloc(
            NotificationsMyProposalsState(
                notificationsMyProposalsModelObj:
                    NotificationsMyProposalsModel()))
          ..add(NotificationsMyProposalsInitialEvent()),
        child: NotificationsMyProposalsPage());
  }
}

class NotificationsMyProposalsPageState
    extends State<NotificationsMyProposalsPage>
    with AutomaticKeepAliveClientMixin<NotificationsMyProposalsPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA70001,
            body: SizedBox(
                width: mediaQueryData.size.width,
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      Expanded(
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Padding(
                                  padding:
                                      getPadding(left: 24, top: 24, right: 24),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding: getPadding(top: 4),
                                                  child: Text(
                                                      "msg_application_status"
                                                          .tr,
                                                      style: CustomTextStyles
                                                          .titleMediumBold_1)),
                                              CustomImageView(
                                                  svgPath:
                                                      ImageConstant.imgArrowup,
                                                  height: getSize(24),
                                                  width: getSize(24))
                                            ]),
                                        Expanded(
                                            child: Padding(
                                                padding: getPadding(top: 23),
                                                child: BlocSelector<
                                                        NotificationsMyProposalsBloc,
                                                        NotificationsMyProposalsState,
                                                        NotificationsMyProposalsModel?>(
                                                    selector: (state) => state
                                                        .notificationsMyProposalsModelObj,
                                                    builder: (context,
                                                        notificationsMyProposalsModelObj) {
                                                      return ListView.separated(
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          shrinkWrap: true,
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                                padding:
                                                                    getPadding(
                                                                        top:
                                                                            8.5,
                                                                        bottom:
                                                                            8.5),
                                                                child: SizedBox(
                                                                    width:
                                                                        getHorizontalSize(
                                                                            327),
                                                                    child: Divider(
                                                                        height:
                                                                            getVerticalSize(
                                                                                1),
                                                                        thickness:
                                                                            getVerticalSize(
                                                                                1),
                                                                        color: appTheme
                                                                            .indigo50)));
                                                          },
                                                          itemCount:
                                                              notificationsMyProposalsModelObj
                                                                      ?.listlocationItemList
                                                                      .length ??
                                                                  0,
                                                          itemBuilder:
                                                              (context, index) {
                                                            ListlocationItemModel
                                                                model =
                                                                notificationsMyProposalsModelObj
                                                                            ?.listlocationItemList[
                                                                        index] ??
                                                                    ListlocationItemModel();
                                                            return ListlocationItemWidget(
                                                                model);
                                                          });
                                                    })))
                                      ]))))
                    ])))));
  }
}
