import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/core/utils/size_utils.dart';
import 'package:fotisia/presentation/chat_screen/models/ChatSession.dart';
import 'package:fotisia/presentation/chat_screen/call_stt_util.dart';
import 'package:fotisia/presentation/chat_screen/widget/SessionWidget.dart';
import 'package:fotisia/presentation/chat_screen/widget/audio_note.dart';
import 'package:fotisia/presentation/chat_screen/widget/chat_provider.dart';
import 'package:fotisia/presentation/chat_screen/widget/multi_chat_widget.dart';
import 'package:fotisia/presentation/chat_screen/widget/timer.dart';
import 'package:fotisia/widgets/app_bar/appbar_title.dart';
import 'package:fotisia/widgets/app_bar/custom_app_bar.dart';
import 'package:fotisia/widgets/custom_elevated_button.dart';
import 'package:fotisia/widgets/custom_text_form_field.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/global_keys.dart';
import '../../core/utils/local_notificattion_service.dart';
import '../../widgets/app_bar/appbar_circleimage.dart';
import '../../widgets/app_bar/appbar_image_1.dart';
import 'bloc/chat_bloc.dart';
import 'models/chat_model.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, });

  static Widget builder(BuildContext context) {
    return BlocProvider<ChatBloc>(
        create: (context) =>
            ChatBloc(ChatState(chatModelObj: StreakInfoModel()))
              ..add(ChatInitialEvent()),
        child: const ChatScreen()
    );
  }

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // late Timer _soundLevelTimer;
  String _selectedOption = 'career-coaching';
  bool mIsInCallSession = false;
  String mEntireResponse = '';
  String mLiveResponse = '';
  bool mDoneTalkingConfirmationPeriod = false;
  bool mUserRequestToContinueTalking = false;
  var uuid = const Uuid();
  List<AudioNote> _audioNotes = [];
  int startingSlide = 0;
  late CarouselController _carouselController;
  Timer? timer;
  int _listeningDuration = 0;
  int maxSessionLength = 300; //seconds
  final TextEditingController _interviewCareer = TextEditingController();


  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
    if(!context.read<ChatProvider>().isSessionActive){
      mIsInCallSession = false;
    } else {
      mIsInCallSession = true;
      if(!context.read<ChatProvider>().isResponding){

      }
    }
    _loadAudioNotes();
  }

  Future<void> _loadAudioNotes() async {
    // final prefs = await SharedPreferences.getInstance();
    // final audioNotesData = prefs.getStringList('audioNotes') ?? [];

    const store = FlutterSecureStorage();
    final data = await store.read(key: 'audioNotes') ?? "[]";
    List<dynamic> audioNotesData = json.decode(data);

    final loadedAudioNotes = audioNotesData
        .map((audioData)
            {
              Map<String, dynamic> data = json.decode(audioData as String);
              return AudioNote(
                  filePath: data["filePath"],
                  userHasListened:  data["userHasListened"],
                  audioPlayer: AudioPlayer()
              );
            }).toList();

    print("Audio length");
    print(loadedAudioNotes.length);
    setState(() {
      _audioNotes = loadedAudioNotes;
    });


    if(loadedAudioNotes.isNotEmpty && !loadedAudioNotes.last.userHasListened){
      print("goto next page");
      _carouselController.animateToPage(1, duration: const Duration(milliseconds: 500));
    }
  }

  Future<void> _saveAudioNotes() async {
    // final prefs = await SharedPreferences.getInstance();
    const store = FlutterSecureStorage();

    final audioNotesData =
    _audioNotes.map((audioNote)
        {
          return json.encode({ "filePath": audioNote.filePath, "userHasListened": audioNote.userHasListened, });
        }).toList();
    // await prefs.setStringList('audioNotes', audioNotesData);
    store.write(key: 'audioNotes', value: json.encode(audioNotesData));
  }

  @override
  void dispose() {
    // _soundLevelTimer?.cancel();
    super.dispose();
  }

  void startedListeningForSound() async {
    _startCallTimer();
    context.read<ChatProvider>().openConnection();
    context.read<ChatProvider>().createSession(uuid.v1(), _selectedOption);
    setState(() {
      mIsInCallSession = true;
    });
  }


  Future<void> stoppedListening() async {
    print("Stopping listening");
    _stopCallTimer();
    setState(() {
      mIsInCallSession = false;
    });
    context.read<ChatProvider>().closeConnection();
    print(mIsInCallSession);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
        child:           Consumer<ChatProvider>(
            builder: (context, chatProvider, child) {
              return Scaffold(
                floatingActionButton: SizedBox(
                    height: getHorizontalSize(!mDoneTalkingConfirmationPeriod ? 90 : 150),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpeechToTextCall(
                              careerController: _interviewCareer,
                              ultraCallback: (String liveText, String finalText, bool isInCallSession, bool userRequestToContinueTalking) {
                                setState(() {
                                  mLiveResponse = liveText;
                                  mEntireResponse = finalText;
                                  mIsInCallSession = isInCallSession;
                                  mUserRequestToContinueTalking = userRequestToContinueTalking;
                                });
                              },
                              doneTalkingConfirmationCallBack: (doneTalkingPeriod){
                                setState(() {
                                  mDoneTalkingConfirmationPeriod = doneTalkingPeriod;
                                });
                              },
                              maxSessionLength: maxSessionLength,
                              startedListening: startedListeningForSound,
                              stoppedListening: stoppedListening,
                              toPauseIcon: const Icon(Icons.call_end, color: Colors.red, semanticLabel: "End Sia Session"),
                              toStartIcon: const Icon(Icons.call, semanticLabel: "Call Sia", color: Colors.green),
                              // pauseIconColor: Colors.black,
                              // startIconColor: Colors.black,
                            ),
                            Text(mIsInCallSession ? "End Call" : "Voice Call", style: TextStyle(color: Colors.black))
                          ],
                        ),
                      ],
                    ),
                  ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: appTheme.whiteA70001,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          height: getVerticalSize(70),
          leadingWidth: getHorizontalSize(50),
          // centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: AppbarTitle(text: "Sia (AI)"),
          ),
          actions: [
            Semantics(
              label: "Image Button: Edit your profile",
              child: AppbarImage1(
                  svgPath: ImageConstant.imgGroup162903,
                  margin:
                  getMargin(left: 0, top: 22, right: 3, bottom: 22),
                  onTap: () {
                    NavigatorService.pushNamed(
                      AppRoutes.experienceSettingScreen,
                    );
                  }),
            )
          ]
      ),
      body: CarouselSlider(
        carouselController: _carouselController,
        options: CarouselOptions(
              height: mediaQueryData.size.height * 0.63,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              // initialPage: startingSlide,
            ),
        items: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: mediaQueryData.size.height * 0.15,
                  width: mediaQueryData.size.height * 0.15,
                  child: Semantics(
                    label: "Image: Picture of Sia, Your career assistant.",
                    child: AppbarCircleimage(
                      imagePath: ImageConstant.imgAvatar32x32,
                      margin: getMargin(
                        top: 5,
                        bottom: 5,
                      ),
                    ),
                  ),
                ),
                !mIsInCallSession ? SizedBox(
                  height: getHorizontalSize(150),
                  child:   const Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // GestureDetector(
                        //   onTap: (){
                        //     NotificationService.showInstantNotification("Message from SIA", "Hi, You have a voice message from your career assistant.", "voice_note");
                        //   },
                        //   child: Container(
                        //     height: 50,
                        //     width: 150,
                        //     color: theme.colorScheme.secondary,
                        //   ),
                        // ),
                        const Text("Have a session with Sia.", style: TextStyle(fontWeight: FontWeight.bold)),
                        const Text("Your personal career coach and assistant."),
                        const SizedBox(height: 20,),
                        // if(_audioNotes.isNotEmpty) SizedBox(
                        //   height: mediaQueryData.size.height * 0.1,
                        //   child: AudioNoteWidget(audioNote: _audioNotes.last, saveAudio: _saveAudioNotes,)
                        // ),
                      ],
                    ),
                  ),
                ) : Container(),
                mIsInCallSession && !context.read<ChatProvider>().isResponding && !mUserRequestToContinueTalking && !mDoneTalkingConfirmationPeriod ? SizedBox(
                        height: mediaQueryData.size.height * 0.1, //was 0.5
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadingAnimationWidget.waveDots(
                                color: theme.colorScheme.primary,
                                size: 40,
                              ),
                              const Text(
                                "Listening...",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ) : Container(),
                mDoneTalkingConfirmationPeriod && !mUserRequestToContinueTalking ? AnalogTimer() : Container(),
                mUserRequestToContinueTalking ? Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomImageView(
                          height: 60,
                          width: 60,
                          svgPath: ImageConstant.cloudWait,
                          color: Colors.black,
                        ),
                        LoadingAnimationWidget.prograssiveDots(
                          color: Colors.white.withOpacity(0.5),
                          size: 30,
                        ),
                      ],
                    ),
                    const Padding(
                      padding:  EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Alright, I'm listening....", style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("Release the button when you are done"),
                          Text("and I will respond.")
                        ],
                      ),
                    ),
                  ],
                ) : Container(),



                context.read<ChatProvider>().isResponding && mIsInCallSession && !mDoneTalkingConfirmationPeriod ? SizedBox(
                        height: mediaQueryData.size.height * 0.2,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadingAnimationWidget.staggeredDotsWave(
                                color: theme.colorScheme.primary,
                                size: 60,
                              ),
                              const Text(
                                "Responding...",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ) : Container(),
                // !context.read<ChatProvider>().isResponding && mIsInCallSession ? SizedBox(
                //   height: mediaQueryData.size.height * 0.5,
                //   child: Center(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         LoadingAnimationWidget.discreteCircle(
                //           color: theme.colorScheme.primary,
                //           size: 60,
                //         ),
                //         const Text(
                //           "loading...",
                //           style: TextStyle(color: Colors.black),
                //         )
                //       ],
                //     ),
                //   ),
                // ) : Container(),

                // if(_selectedOption == "interview-simulation") Semantics(
                //   label: "Input field: Enter career you want to interview for",
                //   child: CustomTextFormField(
                //     width: mediaQueryData.size.width * 0.9,
                //     controller: _interviewCareer,
                //     contentPadding: const EdgeInsets.fromLTRB(13, 13, 13, 13),
                //     hintText: "Enter the career you want to interview for",
                //   ),
                // ),

                !mDoneTalkingConfirmationPeriod ? SizedBox(
                  height: getHorizontalSize(100),
                  width: mediaQueryData.size.width * 0.9,

                  child: !mIsInCallSession ? CarouselSlider(
                    items: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomRadioSelector(
                          value: 'career-coaching',
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          },
                          label: 'Career Coaching',
                          body: 'Start an all-round career coaching session with Sia.'
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomRadioSelector(
                            value: 'interview-simulation',
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value;
                              });
                            },
                            label: 'Interview Simulation',
                            body: 'Simulate an interview session for practice.'
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomRadioSelector(
                            value: 'choose-a-career',
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value;
                              });
                            },
                            label: 'Choose a Career',
                            body: 'Need help choosing a career? Ask Sia!'
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomRadioSelector(
                            value: 'pitch-session',
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value;
                              });
                            },
                            label: 'Pitch Session',
                            body: 'Simulate an idea pitching session for practicing.'
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomRadioSelector(
                            value: 'progress-tracking',
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value;
                              });
                            },
                            label: 'Progress Tracking',
                            body: 'Start a session to get insight and feedback on your career progress.'
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomRadioSelector(
                            value: 'skill-gap-analysis',
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value;
                              });
                            },
                            label: 'Skill Gap Analysis',
                            body: 'Start a session to find gaps and weaknesses in your skill/knowledge.'
                        ),
                      ),
                    ],
                    options: CarouselOptions(
                        enableInfiniteScroll: false,
                       disableCenter : true,
                       padEnds : false,
                    ),
                  ) : Container(),
                ) : Container(),

                if(mIsInCallSession) Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                      formatDuration(_listeningDuration),
                      style: TextStyle(color: _listeningDuration < maxSessionLength ? Colors.black : Colors.red)
                  ),
                ),
              ],
            ),
          ),
              MultiChatWidget(audioNotes: _audioNotes, saveAudio: _saveAudioNotes),

        ],
      ),
    );
    })
    );
  }

  void _startCallTimer() {
    if(timer != null && timer!.isActive){
      return;
    }

    setState((){
      _listeningDuration = 0;
    });
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState((){
        _listeningDuration++;
        });
      });

  }

  void _stopCallTimer() {
    setState((){
      _listeningDuration = 0;
    });
    timer?.cancel();
    timer = null;
    debugPrint('Total call duration: $_listeningDuration seconds');
  }

  String formatDuration(int seconds) {
    final int hours = seconds ~/ 3600;
    final int minutes = (seconds % 3600) ~/ 60;
    final int secs = seconds % 60;

    final String hoursStr = hours.toString().padLeft(2, '0');
    final String minutesStr = minutes.toString().padLeft(2, '0');
    final String secondsStr = secs.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
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
}