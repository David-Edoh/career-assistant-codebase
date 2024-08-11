import 'package:fotisia/data/models/HomePage/career_suggestion_resp.dart';
import 'package:fotisia/presentation/notifications_general_page/models/notification_resp.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_icon_button.dart';

import '../../../data/models/Streak/streak.dart';
import '../complete_streak_dialog_popup/complete_streak_popup_dialog.dart';
import 'circular_progress_bar.dart';

// ignore: must_be_immutable
class ListProgressOneItemWidget extends StatelessWidget {
  ListProgressOneItemWidget(
    {
    this.progress,
    required this.streak,
    required this. activeCareer,
    required this.getStreak,
    super.key,
  });

  Progress? progress;
  Streak streak;
  CareerToChooseFrom activeCareer;
  Function getStreak;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        color: Colors.white.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 32,),
              SizedBox(
                width: mediaQueryData.size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      progress!.progressDescription,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Text(
                      progress?.updatedAt != null ? getTimeAgo(progress!.updatedAt.toString()) : "A while ago",
                      style: CustomTextStyles.labelLargeBluegray300,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  CircularProgressBar(progress: progress!.score!/100),
                  Text("Score", style: TextStyle(color: Colors.white.withOpacity(0.4)),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isCreatedAtToday(String createdAt) {
    // Parse the createdAt string into a DateTime object
    DateTime createdAtDate = DateTime.parse(createdAt);

    // Get the current date
    DateTime now = DateTime.now();

    // Compare the year, month, and day to check if they match
    return createdAtDate.year == now.year &&
        createdAtDate.month == now.month &&
        createdAtDate.day == now.day;
  }

  void main() {
    String createdAt = "2024-05-25 14:35:01";

    if (isCreatedAtToday(createdAt)) {
      print("The createdAt date is today.");
    } else {
      print("The createdAt date is not today.");
    }
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
