import 'package:fotisia/presentation/notifications_general_page/models/notification_resp.dart';
import 'package:intl/intl.dart';

import '../models/listlogo_one_item_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class ListlogoOneItemWidget extends StatelessWidget {
  ListlogoOneItemWidget(
    this.notification, {
    Key? key,
  }) : super(
          key: key,
        );

  NotificationItem? notification;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if((notification?.type == "FRIEND-REQUEST" || notification?.type == "ACCEPT-FRIEND-REQUEST") && notification?.userId != null){
          NavigatorService.pushNamed(
            AppRoutes.userProfilePage,
            arguments: {'userId': notification?.userId},
          );
        }

        if((notification?.type == "NEW-REACTION" || notification?.type == "COMMENT") && notification?.postId != null){
            NavigatorService.pushNamed(
              AppRoutes.singlePostScreen,
              arguments: {'postId': notification?.postId},
            );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconButton(
            height: getSize(32),
            width: getSize(32),
            margin: getMargin(
              bottom: 62,
            ),
            padding: getPadding(
              all: 4,
            ),
            decoration: IconButtonStyleHelper.fillGrayTL16,
            child: CustomImageView(
              url: notification?.user?.picturePath ?? "https://fotisia-user-pictures.s3.amazonaws.com/default-picture/user.png",
            ),
          ),
          Container(
            height: getVerticalSize(90),
            width: getHorizontalSize(283),
            margin: getMargin(
              left: 12,
              top: 4,
            ),
            child: Stack(
              // alignment: Alignment.centerLeft,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    notification?.updatedAt != null ? getTimeAgo(notification!.updatedAt.toString()) : "A while ago",
                    style: CustomTextStyles.labelLargeBluegray300,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        getTitle(notification!),
                        style: CustomTextStyles.titleSmallPrimaryBold,
                      ),
                      Padding(
                        padding: getPadding(
                          top: 7,
                        ),
                        child: Text(
                          getMassage(notification!),
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 10,
                        ),
                        child: notification != null ? Text(
                          (notification?.type == "COMMENT" || notification?.type == "NEW-REACTION") && notification!.post != null ? notification!.post!.text! : "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.labelLargePrimary_1.copyWith(
                            height: 1.67,
                          ),
                        ) : Text(
                          "A new Notification",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.labelLargePrimary_1.copyWith(
                            height: 1.67,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getTitle(NotificationItem notification){
    if(notification.type == "COMMENT"){
      return "New comment";
    }

    if(notification.type == "NEW-REACTION"){
      return "New reaction";
    }

    if(notification.type == "FRIEND-REQUEST"){
      return "New friend request";
    }

    if(notification.type == "ACCEPT-FRIEND-REQUEST"){
      return "New friend";
    }

    return "You have a notification";
  }

  String getMassage(NotificationItem notification){
    if(notification.type == "COMMENT"){
      return "${(notification?.user?.firstName ?? "A User")} ${(notification?.user?.lastName ?? "")} commented on one of your posts...";
    }

    if(notification.type == "NEW-REACTION"){
      return "${(notification?.user?.firstName ?? "A User")} ${(notification?.user?.lastName ?? "")} reacted to one of your posts...";
    }

    if(notification.type == "FRIEND-REQUEST"){
      return "${(notification?.user?.firstName ?? "A User")} ${(notification?.user?.lastName ?? "")} Wants to be your friend";
    }

    if(notification.type == "ACCEPT-FRIEND-REQUEST"){
      return "${(notification?.user?.firstName ?? "A User")} ${(notification?.user?.lastName ?? "")} accepted your friend request";
    }

    return "You have a notification";
  }

  String getTimeAgo(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateTime now = DateTime.now();

    Duration difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} ${difference.inSeconds == 1 ? 'second' : 'seconds'} ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else {
      return DateFormat.yMd().add_jms().format(dateTime);
    }
  }
}
