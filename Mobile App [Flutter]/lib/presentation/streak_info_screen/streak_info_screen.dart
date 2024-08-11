import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotisia/data/models/HomePage/career_suggestion_resp.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/apiClient/api_client.dart';
import '../../data/models/Streak/streak.dart';
import '../../widgets/app_bar/appbar_image_1.dart';
import '../../widgets/custom_outlined_button.dart';
import '../career_roadmap_screen/start_streak_dialog_popup/start_streak_popup_dialog.dart';
import 'bloc/streak_info_bloc.dart';
import 'complete_streak_dialog_popup/complete_streak_popup_dialog.dart';
import 'models/streak_info_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/app_bar/appbar_image.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_text_form_field.dart';
import 'widgets/list_progress_one_item_widget.dart';


class StreakInfoScreen extends StatefulWidget {
  const StreakInfoScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<StreakInfoBloc>(
        create: (context) => StreakInfoBloc(StreakInfoState())
          ..add(StreakInfoInitialEvent()),
        child: const StreakInfoScreen()
    );
  }

  @override
  State<StreakInfoScreen> createState() => _StreakInfoScreenState();
}


class _StreakInfoScreenState extends State<StreakInfoScreen> {
  final _apiClient = ApiClient();
  int currentStreak = 0;
  List<int> milestones = [7, 14, 30];
  bool loadingStreakData = true;
  bool loadingCareerData = true;
  Streak? streak;
  CareerToChooseFrom? activeCareer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStreak();
    getActiveCareer();
  }

  String generateLearningJourney(Streak streak) {
    StringBuffer journey = StringBuffer();

    journey.writeln("For the past $currentStreak days, i have been on an awesome learning streak, Here is a summary of what i've learned: \n\n");

    for (Progress progress in streak.progress) {
      journey.writeln("${progress.createdAt.toLocal().toIso8601String().split('T').first}: ${progress.progressDescription} \n\n");
    }

    return journey.toString();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);


    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
            height: getVerticalSize(70),
            leadingWidth: getHorizontalSize(50),
            leading: Semantics(
              label: "Button: Back to previous page button",
              child: AppbarImage(
                  svgPath: ImageConstant.imgGroup162799,
                  margin: getMargin(left: 24, top: 13, bottom: 14),
                  onTap: () {
                    onTapArrowbackone(context);
                  }
                ),
            ),
            centerTitle: true,
            title: AppbarTitle(text: "YOUR STREAK"),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.settings,
                    color: Colors.black),
                onSelected: (String value) {
                  setState(() {
                    // _selectedValue = value;
                  });
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    child: const Text('Share streak', style: TextStyle(color: Colors.black)),
                    onTap: () {
                      if(streak != null && streak!.progress.isNotEmpty){
                        String shareContent = generateLearningJourney(streak!);
                        Share.share(shareContent, subject: "My learning journey");
                      } else {
                        Fluttertoast.showToast(msg: "You don't have any streak progress to share");
                      }
                    },
                  ),
                  PopupMenuItem(
                    child: const Text('Edit Schedule', style: TextStyle(color: Colors.black)),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: StartStreakPopupDialog(career: activeCareer!, schedule: streak!.schedule[0]).builder(context),
                            backgroundColor: Colors.transparent,
                            contentPadding: EdgeInsets.zero,
                            insetPadding: const EdgeInsets.only(left: 0),
                          )).then((value){
                        getStreak();
                      });
                    },
                  ),
                ],
              )
            ]
        ),

        body: loadingStreakData ? Center(
          child: LoadingAnimationWidget.beat(
            color: theme.colorScheme.secondary,
            size: 20,
          ),
        ) : SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Semantics(
                                    label: "Info: Your current streak: $currentStreak days running streak",
                                    child: CustomImageView(
                                      svgPath: ImageConstant.fire,
                                      height: 120,
                                      width: 120,
                                    ),
                                  ),
          
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.deepOrangeAccent,
          
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          currentStreak.toString(),
                                          style: const TextStyle(
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold,
                                              height: 0.9,
                                              color: Colors.white
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                "Streak day.",
                                style: TextStyle()
                              ),
                              // Text("Today's streak is still pending.", style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.tertiary),),
                            ],
                          ),
                          streak?.recentlyWonMilestone != null ? Column(
                            children: [
                              Semantics(
                                label: "image: last streak milestone trophy",
                                child: CustomImageView(
                                  svgPath: ImageConstant.trophy,
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                              Container(
                                width: mediaQueryData.size.width * 0.35,
                                child: Text(
                                  "${streak!.recentlyWonMilestone.toString()} days milestone victory claimed!",
                                    textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                  )
                                ),
                              ),
                            ],
                          ) : Container(),
          
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: theme.colorScheme.tertiary,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // section 2 ----------------------------------------
                        const SizedBox(height: 25),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 15, 10, 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '(New Challenge)',
                                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 12, color: Colors.white),
                                        ),
                                        Text(
                                          '${streak?.currentMilestone} Day Challenge',
                                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Day $currentStreak of ${streak?.currentMilestone}',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Semantics(
                                  excludeSemantics: true,
                                  child: StreakProgress(
                                    currentStreak: currentStreak,
                                    milestones: milestones,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
          
                        const SizedBox(height: 50),
          
                        !streak!.hasFailed ? Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: isTodayScheduledAndProgressNotCreated(streak!) ? const Text("Pending streak!",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                              ) : const Text("No pending streak to complete!",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isTodayScheduledAndProgressNotCreated(streak!) ? const Text("Let's crush today's streak! Have you completed today's learning? Tell us what you learnt to complete today's streak: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),) : const Text("You are up-to date with your streaks.", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          
                                const SizedBox(height: 10),
                                !isTodayScheduledAndProgressNotCreated(streak!) ? Center(
                                  child: Semantics(
                                    label: "image: todays Streak completed image",
                                    child: CustomImageView(
                                      svgPath: ImageConstant.successful,
                                      height: 120,
                                      width: 120,
                                    ),
                                  ),
                                ) : Container(),
          
                                isTodayScheduledAndProgressNotCreated(streak!) && loadingCareerData ? LoadingAnimationWidget.beat(
                                  color: theme.colorScheme.secondary,
                                  size: 20,
                                ): Container(),
          
                                isTodayScheduledAndProgressNotCreated(streak!) && !loadingCareerData && activeCareer != null ? Semantics(
                                  label: "Button: Complete Today's Streak button",
                                  child: CustomElevatedButton(
                                      text: "Complete Today's Streak",
                                      // margin: getMargin(top: 10),
                                      buttonStyle: CustomButtonStyles.fillPrimary,
                                      height: 48,
                                      width: 250,
                                      onTap: () {
                                        onTapCompleteStreak(context);
                                      }
                                  ),
                                ) : Container(),
          
                                isTodayScheduledAndProgressNotCreated(streak!) && !loadingCareerData && activeCareer == null ? const Text(
                                  "An error occurred: We could not load your career details so you can not update this streak right now.",
                                  style: TextStyle(color: Colors.redAccent),) : Container(),
          
                                const SizedBox(height: 25),
                                isTodayScheduledAndProgressNotCreated(streak!) ? const Text("Otherwise, go do some learning. Come back when you are done to mark today's streak as completed") : Container(),
                                isTodayScheduledAndProgressNotCreated(streak!) ? Semantics(
                                  label: "Button: Back to learning page button",
                                  child: CustomOutlinedButton(
                                    text: "Continue Learning",
                                    height: 48,
                                    width: 250,
                                    margin: getMargin(top: 10),
                                    // buttonStyle: CustomButtonStyles.fillPrimary,
                                    onTap: () {
                                      onTapArrowbackone(context);
                                    },
                                    buttonStyle: CustomButtonStyles.outlinePrimary,
                                    buttonTextStyle: theme.textTheme.titleMedium!,
                                  ),
                                ) : Container(),
                              ],
                            )
                          ],
                        ) : Center(
                          child: Column(
                            children: [
                              const Text("Ouch!!! You have lost your streak!", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                              const Text("Start a new streak, and and try not to lose it again."),
                              const SizedBox(height: 10),
                              Semantics(
                                label: "Button: Start a new streak button",
                                child: CustomElevatedButton(
                                    text: "Begin a new streak",
                                    // margin: getMargin(top: 10),
                                    buttonStyle: CustomButtonStyles.fillPrimary,
                                    height: 48,
                                    width: 250,
                                    onTap: () {
                                      onTapStartStreak(context, activeCareer!);
                                    }
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        streak!.progress.isNotEmpty ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Learning History',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20, color: Colors.white),
                          ),
                        ) : Container(),
                        const SizedBox(height: 5),
          
                         loadingCareerData ? LoadingAnimationWidget.beat(
                          color: theme.colorScheme.secondary,
                          size: 20,
                        ): Container(),
          
                        activeCareer != null ? SizedBox(
                          height: mediaQueryData.size.height * 0.3,
                          child: ListView(
                            children: streak!.progress.map((Progress progress) {
                              return ListProgressOneItemWidget(progress: progress, activeCareer: activeCareer!, streak: streak!, getStreak: getStreak );
                            }).toList(),
                          ),
                        ) : Container()
                        // section 2 ----------------------------------------
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  /// Navigates to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is
  /// used to build the navigation stack. When the action is triggered, this
  /// function uses the [NavigatorService] to navigate to the previous screen
  /// in the navigation stack.
  onTapArrowbackone(BuildContext context) {
    NavigatorService.goBack();
  }

  void onTapCompleteStreak(BuildContext context) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: CompleteStreakPopupDialog(streak: streak!, career: activeCareer!,).builder(context),
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.only(left: 0),
          )
      ).then((value){
        getStreak();
      });
  }

  void getStreak() async {
    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    String path = "api/streak/${userData['id']}";

    await _apiClient.getData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: path,
      showLoading: false,
      useCache: false,
    ).then((value) async {

      Streak streakRes = Streak.fromJson(value);

      int? mileStoneOne;
      int mileStoneTwo;
      int mileStoneThree;

      if(streakRes.currentMilestone <= 7){
        mileStoneOne = streakRes.currentMilestone;
        mileStoneTwo = mileStoneOne == 7 ? mileStoneOne * 2 : mileStoneOne + 20;
        mileStoneThree = ((mileStoneTwo + 20)/10).floor() * 10;
      } else {
        mileStoneOne = streakRes.recentlyWonMilestone;
        mileStoneTwo = streakRes.currentMilestone;
        mileStoneThree = (((mileStoneTwo) + 20)/10).floor() * 10;
      }

      setState(() {
        loadingStreakData = false;
        streak = streakRes;
        currentStreak = streakRes.currentStreak;
        milestones = [mileStoneOne!.toInt(), mileStoneTwo, mileStoneThree];
      });

    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);

      setState(() {
        loadingStreakData = false;
      });

      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });

  }


  void getActiveCareer() async {
    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    String path = "api/careersuggestions/active-career/${userData['id']}";

    await _apiClient.getData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: path,
      showLoading: false,
      useCache: false,
    ).then((value) async {
      CareerToChooseFrom career = CareerToChooseFrom.fromJson(value);

      setState(() {
        activeCareer = career;
        loadingCareerData = false;
      });

    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);

      setState(() {
        loadingCareerData = false;
      });

      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });

  }

  onTapStartStreak(BuildContext context, CareerToChooseFrom career) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: StartStreakPopupDialog(career: career).builder(context),
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.only(left: 0),
        )).then((value){
          getStreak();
        });
  }

  bool isTodayScheduledAndProgressNotCreated(Streak streak) {
    DateTime now = DateTime.now();
    bool isScheduledToday = false;

    // Determine if today is a scheduled day
    for (Schedule schedule in streak.schedule) {
      switch (now.weekday) {
        case DateTime.monday:
          isScheduledToday = schedule.monday;
          break;
        case DateTime.tuesday:
          isScheduledToday = schedule.tuesday;
          break;
        case DateTime.wednesday:
          isScheduledToday = schedule.wednesday;
          break;
        case DateTime.thursday:
          isScheduledToday = schedule.thursday;
          break;
        case DateTime.friday:
          isScheduledToday = schedule.friday;
          break;
        case DateTime.saturday:
          isScheduledToday = schedule.saturday;
          break;
        case DateTime.sunday:
          isScheduledToday = schedule.sunday;
          break;
      }
      if (isScheduledToday) {
        break;
      }
    }

    // Check if a progress entry has been created today
    bool progressCreatedToday = streak.progress.any((progress) {
      return progress.createdAt.year == now.year &&
          progress.createdAt.month == now.month &&
          progress.createdAt.day == now.day;
    });

    return isScheduledToday && !progressCreatedToday;
  }
}

class StreakProgress extends StatelessWidget {
  final int currentStreak;
  final List<int> milestones;

  const StreakProgress({
    Key? key,
    required this.currentStreak,
    required this.milestones,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(milestones.length, (index) {
            return Row(
              children: [
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.165,
                  height: 7,
                  child: (index > 0 && currentStreak > milestones[index - 1]) ? LinearProgressIndicator(
                    value: ((currentStreak - milestones[index - 1]) / (milestones[index] - milestones[index - 1])).clamp(0.0, 1.0),
                    color: theme.colorScheme.secondary,
                    backgroundColor: Colors.black.withOpacity(0.3),
                  ) : index == 0 ? LinearProgressIndicator(
                    value: (currentStreak / milestones[index]).clamp(0.0, 1.0),
                    color: theme.colorScheme.secondary,
                    backgroundColor: Colors.black.withOpacity(0.3),
                  ) : LinearProgressIndicator(
                    value: 0,
                    color: theme.colorScheme.secondary,
                    backgroundColor: Colors.black.withOpacity(0.3),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(3.0),
                  width: mediaQueryData.size.width * 0.11,
                  decoration: BoxDecoration(
                    color: currentStreak >= milestones[index] ? theme.colorScheme.secondary : Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        CustomImageView(
                          svgPath: ImageConstant.date,
                          color: Colors.white.withOpacity(0.5),
                          height: mediaQueryData.size.width * 0.082,
                          width: mediaQueryData.size.width * 0.082,
                        ),
                        Text(
                          '${milestones[index]}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
