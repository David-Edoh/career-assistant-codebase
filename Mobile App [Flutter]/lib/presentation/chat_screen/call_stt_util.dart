import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:fotisia/presentation/chat_screen/widget/chat_provider.dart';
import 'package:fotisia/presentation/chat_screen/widget/timer.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpeechToTextCall extends StatefulWidget {
  final Icon? toPauseIcon;
  final Icon? toStartIcon;
  final Color? pauseIconColor;
  final Color? startIconColor;
  final double? startIconSize;
  final double? pauseIconSize;
  final Function(String liveText, String finalText, bool isInCallSession, bool userRequestToContinueTalking) ultraCallback;
  final Function(bool doneTalkingPeriod) doneTalkingConfirmationCallBack;
  final Function? startedListening;
  final Function? stoppedListening;
  final int maxSessionLength;
  final TextEditingController? careerController;

  const SpeechToTextCall({
        super.key,
        required this.ultraCallback,
        required this.maxSessionLength,
        this.toPauseIcon = const Icon(Icons.pause),
        this.toStartIcon = const Icon(Icons.mic),
        this.pauseIconColor = Colors.black,
        this.startIconColor = Colors.black,
        this.startIconSize = 24,
        this.pauseIconSize = 24,
        this.startedListening,
        this.stoppedListening,
        this.careerController,
        required this.doneTalkingConfirmationCallBack,
      });

  void func (){}

  @override
  State<SpeechToTextCall> createState() => SpeechToTextCallState();
}

class SpeechToTextCallState extends State<SpeechToTextCall> {
  late SpeechToText _speech;
  bool isInCallSession = false;
  String liveResponse = '';
  String entireResponse = '';
  String chunkResponse = '';
  bool userRequestToContinueTalking = false;
  bool doneTalkingConfirmationPeriod = false;
  Timer? _timer;
  final Stopwatch _stopwatch = Stopwatch();
  final Duration _duration = const Duration(seconds: 2);
  Duration _remaining = const Duration(seconds: 2);
  Timer? timer;
  int _listeningDuration = 0;
  int get duration => _listeningDuration; // Duration in seconds


  @override
  void initState() {
    super.initState();
    _speech = SpeechToText();
    if(context.read<ChatProvider>().isSessionActive){
      setState(() {
        isInCallSession = true;
      });
    }
  }

  Future<void> endCall() async {
    await _speech.cancel();
    await _speech.stop();
    context.read<ChatProvider>().stopAudio();
    stopListening();
    await widget.stoppedListening!();
    setState(() {
      isInCallSession = false;
    });
    _stopCallTimer();
  }

  Future <void> checkPermission() async {
    await startListening();
    await stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        doneTalkingConfirmationPeriod ? Column(
          children: [
            GestureDetector(
              onTapDown: (_){
                setState(() {
                  userRequestToContinueTalking = true;
                });
                _stopTimer();
                startListening();
              },

              onTapUp: (_){
                setState(() {
                  userRequestToContinueTalking = false;
                });
                _speech.stop();
                _resumeTimer();
              },

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      // border: Border.all(
                      //   // color: Colors.red[500],
                      // ),
                      color: theme.colorScheme.primary,
                      borderRadius: const BorderRadius.all(const Radius.circular(20))
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(12, 8.0, 12, 8),
                    child: Text("Hold, I am still talking", style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                    ),
                  ),
                ),
              ),

            ),
          ],
        ) : Container(),
        Center(
          child: isInCallSession ? IconButton(
            iconSize: widget.pauseIconSize,
            icon: widget.toPauseIcon!,
            color: widget.pauseIconColor,
            onPressed: () {
              context.read<ChatProvider>().stopAudio();
              stopListening();
              widget.stoppedListening!();
              _speech.stop();
              _stopCallTimer();
            },
          ) : IconButton(
            iconSize: widget.startIconSize,
            color: widget.startIconColor,
            icon: widget.toStartIcon!,
            onPressed: () async {
              if(!(await _speech.hasPermission)){
                // await checkPermission();
              }
              context.read<ChatProvider>().setStartListeningFunction(startListening, createNewSpeech, endCall);
              widget.startedListening!();
              setState(() {
                isInCallSession = true;
                liveResponse = '';
                entireResponse = '';
                chunkResponse = '';
                userRequestToContinueTalking = false;
                doneTalkingConfirmationPeriod = false;
                _startCallTimer();
                _speech = SpeechToText();
              });
            },
          ),
        ),
      ],
    );
  }

  void _startCallTimer() {
    if(timer != null && timer!.isActive){
      return;
    }
    _listeningDuration = 0;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _listeningDuration++;
    });
  }

  void _stopCallTimer() {
    timer?.cancel();
    timer = null;
    debugPrint('Final call duration: $_listeningDuration seconds');
  }

  void createNewSpeech(){
    _speech = SpeechToText();
  }

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) async {
      if (_stopwatch.elapsed >= _remaining) {
        _resetTimer();

        // if there is text to be sent to be backend send it
        if('$entireResponse $liveResponse'.trim().isNotEmpty){
          print("sending... '$entireResponse $liveResponse'.trim() to the backend");
          if(_listeningDuration >= widget.maxSessionLength){
            print("Session expired");
            context.read<ChatProvider>().setSessionExpired(true);
          }
          context.read<ChatProvider>().sendMessage('$entireResponse $liveResponse'.trim(), startListening, createNewSpeech);

          await _speech.stop();
        } else {
          Fluttertoast.showToast(msg: "I didn't hear you", toastLength: Toast.LENGTH_LONG);
        }

        setState(() {
          doneTalkingConfirmationPeriod = false;
          userRequestToContinueTalking = false;
          entireResponse = "";
          liveResponse = "";
          chunkResponse = "";
        });
        widget.doneTalkingConfirmationCallBack(doneTalkingConfirmationPeriod);
        widget.ultraCallback(liveResponse, entireResponse, isInCallSession, userRequestToContinueTalking);
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _stopwatch.stop();
    _remaining -= _stopwatch.elapsed;
  }

  void _resumeTimer() {
    _startTimer();
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _remaining = _duration;
      doneTalkingConfirmationPeriod = false;
    });
    _stopwatch.reset();
  }


  Future<void> startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) async {
        print('Speech recognition status: $status AND entire text is: ${entireResponse.trim().isNotEmpty} ${liveResponse.trim().isNotEmpty}');
        if ((status == "done" || status == "notListening") && isInCallSession) {

          if(!userRequestToContinueTalking && '$entireResponse $liveResponse'.trim().isNotEmpty && !context.read<ChatProvider>().isResponding){ // and entireResponse is not empty
            setState(() {
              doneTalkingConfirmationPeriod = true; // activate widget
            });
            widget.doneTalkingConfirmationCallBack(doneTalkingConfirmationPeriod);
            _startTimer();
          }

          if(doneTalkingConfirmationPeriod || '$entireResponse $liveResponse'.trim().isEmpty){ // or entireResponse is empty
            await _speech.stop();
            setState(() {
              print("Checking if chunk exist");
              if (chunkResponse != '') {
                print("saving received chunk...");
                entireResponse = '$entireResponse $chunkResponse';
              }
              chunkResponse = '';
              liveResponse = '';
              widget.ultraCallback(liveResponse, entireResponse, isInCallSession, userRequestToContinueTalking);
            });
            startListening();
          }
        }
      },

      onError: (error) async {
        // print("speech recognition error: $error");
        // Fluttertoast.showToast(msg: "Call ended...", toastLength: Toast.LENGTH_LONG);
        // context.read<ChatProvider>().stopAudio();
        // stopListening();
        // widget.stoppedListening!();
        // _speech.stop();
        // _stopCallTimer();
      }
    );

    if (available) {
      if(!userRequestToContinueTalking){
        setState(() {
          isInCallSession = true;
          liveResponse = '';
          chunkResponse = '';
          widget.ultraCallback(liveResponse, entireResponse, isInCallSession, userRequestToContinueTalking);
        });
      }

      await _speech.listen(
        onResult: (result) {
          setState(() {
            final state = result.recognizedWords;
            liveResponse = state;
            print(liveResponse);
            if (result.finalResult) {
              chunkResponse = result.recognizedWords;
              print("Chunk: ${result.recognizedWords}");
            }
            widget.ultraCallback(liveResponse, entireResponse, isInCallSession, userRequestToContinueTalking);
          });
        },
      );
    } else {
      debugPrint('Ultra Speech ERROR : Speech recognition not available');
    }
  }

  Future<void> stopListening() async {
    setState(() {
      isInCallSession = false;
      userRequestToContinueTalking = false;
      entireResponse = '$entireResponse $chunkResponse';
      widget.ultraCallback(liveResponse, entireResponse, isInCallSession, userRequestToContinueTalking);
    });
    await _speech.stop();
  }
}