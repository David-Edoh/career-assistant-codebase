import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotisia/widgets/custom_drop_down.dart';
import '../../../data/apiClient/api_client.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/HomePage/career_suggestion_resp.dart';
import '../../../data/models/HomePage/subject_suggestion_resp.dart';
import '../../../data/models/Streak/streak.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'bloc/complete_streak_popup_bloc.dart';
import 'models/complete_streak_popup_model.dart';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_outlined_button.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'StreakSessionManager.dart';

class CompleteStreakPopupDialog extends StatefulWidget {
   CompleteStreakPopupDialog({Key? key, required this.streak, required this.career, this.progress}) : super(key: key);
   Streak streak;
   CareerToChooseFrom career;
   Progress? progress;


  Widget builder(BuildContext context) {
    return BlocProvider<CompleteStreakPopupBloc>(
        create: (context) => CompleteStreakPopupBloc(
            CompleteStreakPopupState()
        )
          ..add(CompleteStreakPopupInitialEvent()),
        child: CompleteStreakPopupDialog(streak: streak, career: career, progress: progress)
    );
  }

  @override
  State<CompleteStreakPopupDialog> createState() => _CompleteStreakPopupDialogState();
}

class _CompleteStreakPopupDialogState extends State<CompleteStreakPopupDialog> {
  final _apiClient = ApiClient();
  int? _selectedSubject;
  TextEditingController? _textEditingController;
  List<Map<String, dynamic>> questions = [ {"question": "Tell us what you learned today", "textEditingController": TextEditingController(), "isActive": true} ];
  final StreakSessionProvider streakSessionProvider = StreakSessionProvider();
  var uuid = const Uuid();
  final ScrollController _scrollController = ScrollController();
  bool scoreReceived = false;
  late int streakScore;


  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    scoreReceived = false;
    initSession();

    if(widget.progress == null){
      _textEditingController = TextEditingController();
    } else {
      _textEditingController = TextEditingController.fromValue(TextEditingValue(text: widget.progress!.progressDescription));
      _selectedSubject = widget.progress?.subjectId;
    }
  }

  Future<void> initSession() async {
    await streakSessionProvider.loadChatHistory();
    setState(() {
      streakSessionProvider.createSession(uuid.v1(), "complete-streak-session");
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: getMargin(left: 34, right: 34, bottom: 241),
          padding: getPadding(all: 10),
          decoration: AppDecoration.fillOnPrimaryContainer
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: !scoreReceived ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      'Complete Today\'s Streak',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Fill the form below to complete today\'s streak:',
                ),
      
                const SizedBox(height: 16),
                DropdownButton<int>(
                  hint: const Text('Topic studied?', overflow: TextOverflow.ellipsis),
                  value: _selectedSubject,
                  onChanged: (int? newValue) {
                    setState(() {
                      _selectedSubject = newValue;
                    });
                  },
                  items: widget.career.roadmap.careerSubjects.map<DropdownMenuItem<int>>((SuggestedSubject subject) {
                    return DropdownMenuItem<int>(
                      value: subject.id,
                      child: SizedBox(
                        width: mediaQueryData.size.width * 0.6,
                        child: Text(
                          '${subject.subject}',
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    );
                  }).toList(),
                ),
      
                const SizedBox(height: 16),
                Text("On your ${widget.career.career.toLowerCase()} career journey:",
                    style: theme.textTheme.titleSmall),
                const SizedBox(height: 10),
                SizedBox(
                  height: mediaQueryData.size.height * 0.16,
                  child: ListView.builder(
                    itemCount: questions.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return  Semantics(
                        label: "Input field: TYpe you answer here. the question is: ${questions[index]["question"]}",
                        child: CustomTextFormField(
                            controller: questions[index]["textEditingController"] as TextEditingController,
                            margin: getMargin(top: 7),
                            hintText: "${index + 1}. ${questions[index]["question"] as String}",
                            hintStyle: CustomTextStyles
                                .titleMediumBluegray400,
                            textInputAction: TextInputAction.done,
                            maxLines: 4,
                            contentPadding: getPadding(
                                left: 16,
                                top: 20,
                                right: 16,
                                bottom: 20)
                        ),
                      );
                    },
                  ),
                ),
      
                const SizedBox(height: 20),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        onTapCancel(context);
                      },
                      child: const Text('Cancel'),
                    ),
      
                    CustomElevatedButton(
                      text: widget.progress == null ? "Submit" : "Update",
                      buttonStyle: CustomButtonStyles.fillPrimary,
                      height: 48,
                      width: 120,
                      onTap: () {
                        widget.progress == null ? onTapComplete(context) : onTapUpdate(context);
                      },
                    ),
                  ],
                )
              ],
            ) : Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check_circle_outline, color: Colors.green),
                  ),
                  Text("Streak completed, you scored $streakScore%"),
                ],
              ),
            ),
          )
      ),
    );
  }

bool validateForm(){
    if(_selectedSubject == null){
      Fluttertoast.showToast(msg: "Select a subject to continue", toastLength: Toast.LENGTH_LONG);
      return false;
    }

    if((questions.last["textEditingController"] as TextEditingController).text.isEmpty){
      Fluttertoast.showToast(msg: "Please provide an answer to the question", toastLength: Toast.LENGTH_LONG);
      return false;
    }

    return true;
}
  onTapComplete(BuildContext context) async {
    if(!validateForm()){
      return;
    }
    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    String answer = questions.length == 1 ? "I have completed my streak, Here is what I learned today: ${(questions.last["textEditingController"] as TextEditingController).text}" : (questions.last["textEditingController"] as TextEditingController).text;
    streakSessionProvider.addMessage(answer, isUser: true);

    Map<String, dynamic> data = {
      "answer": answer,
      "session_history": streakSessionProvider.currentSession?.chatHistory,
    };
    FocusManager.instance.primaryFocus?.unfocus();

    await _apiClient.postData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: "api/streak/get-score/${userData['id']}", //param is userId
      requestData: data,
    ).then((value) async {

      if(value["result"]["type"] != null && value["result"]["type"] == "question"){

        streakSessionProvider.addMessage(value["result"]["question"], isUser: false);

        setState(() {
          questions.last["isActive"] = false;
          questions.add({"question": value["result"]["question"], "textEditingController": TextEditingController(), "isActive": true});

          print("Animate here");
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 100,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          );
        });

      } else {
        setState(() {
          streakScore = int.parse(value["result"]["truth_score"].toString());
        });
        completeStreak(context, int.parse(value["result"]["truth_score"].toString()));
      }

    }).onError((error, stackTrace) {
      if(error is DioException){
        // print("On error");
        // print(error.response?.data);
        Fluttertoast.showToast(msg: error.response?.data, toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(msg: "Error updating streak", toastLength: Toast.LENGTH_LONG);
      }
    });

  }


  completeStreak(BuildContext context, int streakScore) async {
    setState(() {
      scoreReceived = true;
    });

    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    // Get the current date and time
    DateTime now = DateTime.now();

    // Format the current date and time as a string
    String formattedCurrentUsersTime = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    String formattedTodaysDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";


    Map<String, dynamic> data = {
      "progressDescription": (questions.first["textEditingController"] as TextEditingController).text,
      "streakId": widget.streak.id,
      "subjectId": _selectedSubject,
      "score": streakScore,
      "userId": userData['id'],
      "currentUsersTime": formattedCurrentUsersTime,
      "todaysDate": formattedTodaysDate,
    };

    await _apiClient.postData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: "api/streak/${userData['id']}/create/progress", //param is userId
      requestData: data,
    ).then((value) async {
      Fluttertoast.showToast(msg: "Today's streak completed!!!", toastLength: Toast.LENGTH_LONG);

      Navigator.pop(context);
    }).onError((error, stackTrace) {
      if(error is DioException){
        // print("On error");
        // print(error.response?.data);
        Fluttertoast.showToast(msg: error.response?.data, toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(msg: "Error updating streak", toastLength: Toast.LENGTH_LONG);
      }
    });

  }

  onTapUpdate(BuildContext context) async {
    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());

    // Get the current date and time
    DateTime now = DateTime.now();

    // Format the current date and time as a string
    String formattedTodaysDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";


    Map<String, dynamic> data = {
      "progressDescription": _textEditingController?.text,
      "subjectId": _selectedSubject,
      "currentDate": formattedTodaysDate
    };

    await _apiClient.putData(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${userData['accessToken']}"
      },
      path: "api/streak/${userData['id']}/update/progress/${widget.progress?.id}", //param is userId
      requestData: data,
    ).then((value) async {
      Fluttertoast.showToast(msg: "Streak updated!!!", toastLength: Toast.LENGTH_LONG);

      Navigator.pop(context);
    }).onError((error, stackTrace) {
      if(error is DioException){
        // print("On error");
        // print(error.response?.data);
        Fluttertoast.showToast(msg: error.response?.data, toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(msg: "Error updating streak", toastLength: Toast.LENGTH_LONG);
      }
    });

  }

  /// Navigates to the settingsScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the settingsScreen.
  onTapCancel(BuildContext context) {
    Navigator.pop(context);
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
      {required this.label, required this.selectedTime, required this.onTimeSelected}
      );

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
