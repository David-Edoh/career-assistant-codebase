import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/HomePage/career_suggestion_resp.dart';
import '../../../data/models/Streak/streak.dart';
import 'bloc/start_streak_popup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';



class StartStreakPopupDialog extends StatefulWidget {
   StartStreakPopupDialog({super.key, required this.career, this.schedule});
   CareerToChooseFrom career;
   Schedule? schedule;

   Widget builder(BuildContext context) {
    return BlocProvider<StartStreakPopupBloc>(
        create: (context) => StartStreakPopupBloc(
            StartStreakPopupState()
        )
          ..add(StartStreakPopupInitialEvent()),
        child: StartStreakPopupDialog(career: career, schedule: schedule)
    );
  }

  @override
  State<StartStreakPopupDialog> createState() => _StartStreakPopupDialogState();
}

class _StartStreakPopupDialogState extends State<StartStreakPopupDialog> {
  final _apiClient = ApiClient();
  TimeOfDay _startTime = const TimeOfDay(hour: 21, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 21, minute: 30);
  late List<bool> _selectedDays = List.generate(7, (index) => false);
  bool loadingSchedule = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.schedule != null){
      // print(widget.schedule?.startTime);
      _startTime = convertMySQLTimeToTimeOfDay(widget.schedule!.startTime);
      _endTime = convertMySQLTimeToTimeOfDay(widget.schedule!.endTime);
      _selectedDays = widget.schedule!.getDaysAsList();
    }
  }


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    // print(widget.scheduleId);

    return SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.80,
            margin: getMargin(left: 34, right: 34, bottom: 241),
            padding: getPadding(all: 32),
            decoration: AppDecoration.fillOnPrimaryContainer
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'Start crushing goals!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'You\'re more likely to reach your goal if you dedicate some time in your schedule for learning. Choose the days that work for you:',
                  ),
                  const SizedBox(height: 16),
                  DaysSelector(selectedDays: _selectedDays, onDaySelected: (index) {
                    setState(() {
                      _selectedDays[index] = !_selectedDays[index];
                    });
                  }),
                  const SizedBox(height: 16),
                  TimePicker(
                    label: 'Start time',
                    selectedTime: _startTime,
                    onTimeSelected: (time) {
                      setState(() {
                        _startTime = time;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TimePicker(
                    label: 'End time',
                    selectedTime: _endTime,
                    onTimeSelected: (time) {
                      setState(() {
                        _endTime = time;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if(widget.schedule == null){
                            onTapSetGoal(context, widget.career, _selectedDays, _startTime, _endTime);
                          } else {
                            onTapUpdateSchedule(context, widget.career, _selectedDays, _startTime, _endTime);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                          child: Text(widget.schedule == null ? 'Set Goal' : 'Update Schedule'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          onTapCancel(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  )
                ],
              ),
            )
        )
    );
  }

  /// Navigates to the signUpCreateAcountScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the signUpCreateAcountScreen.
  onTapSetGoal(BuildContext context, CareerToChooseFrom career, List<bool> selectedDays, TimeOfDay startTime, TimeOfDay endTime) async {
    const storage = FlutterSecureStorage();
   String? jsonString = await storage.read(key: "userData");
   Map<String, dynamic> userData = json.decode(jsonString.toString());

   Map<String, dynamic> data = {
     "schedule": {
       "startTime": convertTimeOfDayToMySQL(startTime),
       "endTime": convertTimeOfDayToMySQL(endTime),
       "monday": selectedDays[0],
       "tuesday": selectedDays[1],
       "wednesday": selectedDays[2],
       "thursday": selectedDays[3],
       "friday": selectedDays[4],
       "saturday": selectedDays[5],
       "sunday": selectedDays[6],
     },
     "careerId": career.id
   };

   await _apiClient.postData(
     headers: {
       'Content-Type': 'application/json',
       'Authorization': "Bearer ${userData['accessToken']}"
     },
     path: "api/streak/${userData['id']}", //param is userId
     requestData: data,
   ).then((value) async {
     Fluttertoast.showToast(msg: "Streak Launched!!!", toastLength: Toast.LENGTH_LONG);

     List<String> scheduledDays = getActiveDays(data["schedule"]);
     await scheduleWebRequest(scheduledDays, subtract15Minutes(startTime).hour, subtract15Minutes(startTime).minute);
     print(subtract15Minutes(startTime));

     Navigator.pop(context);
   }).onError((error, stackTrace) {
     print(error);
     Fluttertoast.showToast(msg: "Error starting streak", toastLength: Toast.LENGTH_LONG);
   });
  }

  TimeOfDay subtract15Minutes(TimeOfDay time) {
    // Calculate the total minutes since midnight for the given time
    int totalMinutes = time.hour * 60 + time.minute;

    // Subtract 15 minutes
    totalMinutes -= 15;

    // Handle negative total minutes by adding 24 hours (1440 minutes)
    if (totalMinutes < 0) {
      totalMinutes += 1440;
    }

    // Calculate the new hour and minute
    int newHour = totalMinutes ~/ 60;
    int newMinute = totalMinutes % 60;

    // Return the new TimeOfDay object
    return TimeOfDay(hour: newHour, minute: newMinute);
  }

  onTapUpdateSchedule(BuildContext context, CareerToChooseFrom career, List<bool> selectedDays, TimeOfDay startTime, TimeOfDay endTime) async {
    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    Map<String, dynamic> data = {
      "schedule": {
        "startTime": convertTimeOfDayToMySQL(startTime),
        "endTime": convertTimeOfDayToMySQL(endTime),
        "monday": selectedDays[0],
        "tuesday": selectedDays[1],
        "wednesday": selectedDays[2],
        "thursday": selectedDays[3],
        "friday": selectedDays[4],
        "saturday": selectedDays[5],
        "sunday": selectedDays[6],
      }
    };

    await _apiClient.putData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: "api/streak/${userData['id']}/update/schedule/${widget.schedule?.id}", //param is userId
      requestData: data,
    ).then((value) async {
      Fluttertoast.showToast(msg: "Streak Updated!!!", toastLength: Toast.LENGTH_LONG);

      List<String> scheduledDays = getActiveDays(data["schedule"]);
      await scheduleWebRequest(scheduledDays, subtract15Minutes(startTime).hour, subtract15Minutes(startTime).minute);
      print(subtract15Minutes(startTime));

      Navigator.pop(context);
    }).onError((error, stackTrace) {
      print(error);
      Fluttertoast.showToast(msg: "Error updating streak", toastLength: Toast.LENGTH_LONG);
    });
  }

  List<String> getActiveDays(Map<String, dynamic> schedule) {
    // Define a list of all days of the week
    List<String> daysOfWeek = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"];

    // Create an empty list to store the active days
    List<String> activeDays = [];

    // Iterate over each day in the daysOfWeek list
    for (String day in daysOfWeek) {
      // Check if the day is true in the schedule map
      if (schedule[day] == true) {
        // Add the day to the activeDays list
        activeDays.add(day);
      }
    }

    // Return the list of active days
    return activeDays;
  }

  String convertTimeOfDayToMySQL(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes:00';
  }

  TimeOfDay convertMySQLTimeToTimeOfDay(String time) {
    final parts = time.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    return TimeOfDay(hour: hours, minute: minutes);
  }


  /// Navigates to the settingsScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the settingsScreen.
  onTapCancel(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> scheduleWebRequest(List<String> days, int hour, int min) async {
    //get users data
    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    String getPerformancePath = "${dotenv.env['FOTISIA_BACKEND_BASE_URL']}/api/careersuggestions/get-performance-update/${userData["id"]}";
    String getJobsPath = "${dotenv.env['FOTISIA_BACKEND_BASE_URL']}/api/careersuggestions/jobs/${userData["id"]}";
    String getStreakInfoPath = "${dotenv.env['FOTISIA_BACKEND_BASE_URL']}/api/streak/check/${userData["id"]}";

    // Cancel any previous tasks
    await Workmanager().cancelAll();

    for (String day in days) {
      // Schedule voice-note 15min to the time reminding the user of their streak appointment.
      final nextSchedule = _nextInstanceOfDayAndTime(day, hour, min);
      await Workmanager().registerOneOffTask(
        'webRequest_$day',
        'getVoiceNoteTask',
        inputData: <String, dynamic>{'userId':userData['id'], 'accessToken': userData['accessToken'], 'userData': userData.toString(), "getPerformancePath": getPerformancePath, "getJobsPath": getJobsPath, 'userFirstName': userData['firstName']},
        initialDelay: nextSchedule.difference(DateTime.now()),
        constraints: Constraints(networkType: NetworkType.connected),
      );

      // Schedule voice not 30min after the time reminding the user of their streak appointment if not done yet.
      // final


      // Schedule worker end of day to check if streak is not completed then mark streak as failed.
      final scheduleCheckIfUserPassedStreak = _nextInstanceOfDayAndTime(day, 23, 59);
      await Workmanager().registerOneOffTask(
        'webRequest_$day',
        'checkIfUserPassedStreak',
        inputData: <String, dynamic>{'userId':userData['id'], 'accessToken': userData['accessToken'], 'userData': userData.toString(), "getStreakInfoPath": getStreakInfoPath, 'userFirstName': userData['firstName']},
        initialDelay: scheduleCheckIfUserPassedStreak.difference(DateTime.now()),
        constraints: Constraints(networkType: NetworkType.connected),
      );

    }
  }

  DateTime _nextInstanceOfDayAndTime(String day, int hour, int minute) {
    final now = DateTime.now();
    final dayOfWeek = _dayOfWeekFromString(day);
    var scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);

    while (scheduledDate.weekday != dayOfWeek || scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    return scheduledDate;
  }

  int _dayOfWeekFromString(String day) {
    switch (day) {
      case 'monday':
        return DateTime.monday;
      case 'tuesday':
        return DateTime.tuesday;
      case 'wednesday':
        return DateTime.wednesday;
      case 'thursday':
        return DateTime.thursday;
      case 'friday':
        return DateTime.friday;
      case 'saturday':
        return DateTime.saturday;
      case 'sunday':
        return DateTime.sunday;
      default:
        throw ArgumentError('Invalid day: $day');
    }
  }


}


class DaysSelector extends StatelessWidget {
  final List<bool> selectedDays;
  final Function(int) onDaySelected;

  DaysSelector({required this.selectedDays, required this.onDaySelected});

  @override
  Widget build(BuildContext context) {
    List<String> days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    return Wrap(
      spacing: 5,
      children: List.generate(days.length, (index) {
        return RawChip(
          selectedColor: theme.colorScheme.primary,
          showCheckmark: false,
          label: Text(days[index],
            // style: TextStyle(
            //     color: isSelected ? Colors.white : Colors.red,
            //     fontWeight: FontWeight.bold
            // )
          ),
          // Text(days[index]),
          selected: selectedDays[index],
          onSelected: (selected) {
            onDaySelected(index);
          },
        );
      }),
    );
  }
}

class TimePicker extends StatelessWidget {
  final String label;
  final TimeOfDay selectedTime;
  final Function(TimeOfDay) onTimeSelected;

  TimePicker(
      {required this.label, required this.selectedTime, required this.onTimeSelected});

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            timePickerTheme: TimePickerThemeData(
              // hourMinuteTextColor: theme.colorScheme.primary, // Text color for hours and minutes
              dayPeriodTextColor: theme.colorScheme.primary, // Text color for AM/PM
              dayPeriodBorderSide: BorderSide(color: theme.colorScheme.primary), // Border color for AM/PM
              // dialTextColor: theme.colorScheme.primary,
            ),
            colorScheme: ColorScheme.light(
              // change the border color
              primary: theme.colorScheme.primary,
              // change the text color
              onSurface: theme.colorScheme.primary,
              secondary: theme.colorScheme.primary.withOpacity(0.5),
            ),
            // button colors
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: theme.colorScheme.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        Spacer(),
        TextButton(
          onPressed: () => _selectTime(context),
          child: Text(selectedTime.format(context)),
        ),
      ],
    );
  }
}
