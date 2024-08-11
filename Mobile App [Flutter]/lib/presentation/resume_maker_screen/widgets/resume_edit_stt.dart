import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/material.dart';

class SpeechToTextProvider with ChangeNotifier {
  SpeechToText _speech = SpeechToText();
  bool isListening = false;
  String liveResponse = '';
  String entireResponse = '';
  String chunkResponse = '';
  Timer? timer;
  int _listeningDuration = 0;
  int get duration => _listeningDuration; // Duration in seconds

  // SpeechToTextUltraState(){
  //   speech = SpeechToText();
  // }

  Future<void> checkPermission() async {
    await Future.delayed(const Duration(seconds: 2));
    await _speech.initialize();
    await _speech.cancel();
    await _speech.stop();
    _speech = SpeechToText();
  }

  void startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) async {
        print("status from resume s_to_t: $status");
        if ((status == "done" || status == "notListening") && isListening) {
          await _speech.stop();
          if (chunkResponse != '') {
            entireResponse = '$entireResponse $chunkResponse';
          }
          chunkResponse = '';
          liveResponse = '';

          startListening();
        }
      },
      onError: (error) async {
        print("Error: $error");
      }
    );

    if (available) {
      isListening = true;
      liveResponse = '';
      chunkResponse = '';
      _startTimer();

      await _speech.listen(
        onResult: (result) {
          final state = result.recognizedWords;
          liveResponse = state;
          print(liveResponse);
          if (result.finalResult) {
            chunkResponse = result.recognizedWords;
            print("Chunk: ${result.recognizedWords}");
          }
        },
      );
    } else {
      debugPrint('Ultra Speech ERROR : Speech recognition not available');
    }
  }

  void clearTexts(){
    chunkResponse = '';
    liveResponse = '';
    entireResponse = '';
  }

  void stopListening() async {
    await _speech.cancel();
    await _speech.initialize();
    await Future.delayed(const Duration(seconds: 2));
    await _speech.listen();
    await _speech.stop();
    _speech = SpeechToText();
    print("Stopping speechToText");
    isListening = false;
    entireResponse = '$entireResponse $chunkResponse';
    _stopTimer();
    // widget.ultraCallback(liveResponse, entireResponse, isListening);
  }

  void _startTimer() {
    if(timer != null && timer!.isActive){
      return;
    }
    _listeningDuration = 0;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _listeningDuration++;

      debugPrint('Listening duration: $_listeningDuration seconds');
      notifyListeners();
    });
  }

  void _stopTimer() {
    timer?.cancel();
    timer = null;
    debugPrint('Final listening duration: $_listeningDuration seconds');
  }
}
