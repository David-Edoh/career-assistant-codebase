import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotisia/presentation/chat_screen/widget/audio_note.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/apiClient/api_client.dart';
import '../../data/models/Streak/streak.dart';
import 'local_notificattion_service.dart';



Future<void> scheduler(String task, Map<String, dynamic>? inputData) async {
  print("worker executed. inputData = $inputData");
  switch (task) {
    case "getVoiceNoteTask":
      print("getVoiceNoteTask was executed. inputData = $inputData");
      final filePath = await getTodaysScheduleVoiceNoteFromSia(task, inputData);
      await _saveAudioNotes(AudioNote(filePath: filePath, audioPlayer: AudioPlayer(), userHasListened: false));
      NotificationService.showInstantNotification("Message from SIA", "Hi ${inputData?['userFirstName']}, You have a voice message from your career assistant.", "voice_note");
      break;

    case "checkIfUserPassedStreak":
      print("checkIfUserPassedStreak was executed. inputData = $inputData");
      print(inputData?['getJobsPath']);
      final streakInfo = await checkIfUserCompletedStreak(task, inputData);

      if(streakInfo.hasFailed){
        NotificationService.showInstantNotification("Message from SIA", "Hi ${inputData?['userFirstName']}, You have lost you current streak. To reach your career goals you should be diligent with your learning. Please start a new streak and be consistent. You can do this!!!", "Streak Info");
      }
      break;
  }
}

Future<Streak> checkIfUserCompletedStreak(String task, Map<String, dynamic>? inputData) async {
  final apiClient = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 6000) ,
  ));

  dynamic response = await apiClient.get(
    inputData?["getStreakInfoPath"],
    options: Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${inputData?['accessToken']}"
    })
  );

  if(!_isSuccessCall(response)) {
    throw Exception(response.data.message);
  }

  Streak streakRes = Streak.fromJson(response.data);

  print(response.data);
  return streakRes;
}

Future<List<AudioNote>> _loadAudioNotes() async {
  // final prefs = await SharedPreferences.getInstance();
  // final audioNotesData = prefs.getStringList('audioNotes') ?? [];
  const store = FlutterSecureStorage();
  final data = await store.read(key: 'audioNotes') ?? "[]";
  List<dynamic> audioNotesData = json.decode(data);

  final loadedAudioNotes = audioNotesData
      .map((audioData) {
          Map<String, dynamic> data = json.decode(audioData as String);
          return AudioNote(
              filePath: data["filePath"],
              userHasListened:  data["userHasListened"],
              audioPlayer: AudioPlayer(),
          );
        }).toList();

    return loadedAudioNotes;
}

Future<void> _saveAudioNotes(AudioNote note) async {
  List<AudioNote> audioNotes = await _loadAudioNotes();
  audioNotes.add(note);

  // final prefs = await SharedPreferences.getInstance();
  const store = FlutterSecureStorage();

  final audioNotesData = audioNotes
      .map((audioNote)
      {
        return json.encode({ "filePath": audioNote.filePath, "userHasListened": audioNote.userHasListened, });
      }).toList();

  // await prefs.setStringList('audioNotes', audioNotesData);
  store.write(key: 'audioNotes', value: json.encode(audioNotesData));
}

Future<String> getTodaysScheduleVoiceNoteFromSia(String task, Map<String, dynamic>? inputData) async {
  final apiClient = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 6000) ,
  ));

  dynamic jobs = await getJobAds(inputData?["userId"], inputData?['accessToken'], inputData?['getJobsPath']);

  dynamic response = await apiClient.post(
    inputData?["getPerformancePath"],
    options: Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${inputData?['accessToken']}"
    }),
    data: {
      "user_data": inputData?["userData"],
      "available_jobs": jobs,
      // "session": inputData?["session"],
    },
  );

  if(!_isSuccessCall(response)) {
    throw Exception(response.data.message);
  }

  print(response.data["result"]);

  //   value is a base64 audio data of Sia checking up on user.
  Uint8List audioBytes = base64Decode(response.data["result"]);
  String audioNotePath = await _saveAudioFile(audioBytes);
  return audioNotePath;
}

bool _isSuccessCall(Response response) {
  if (response.statusCode != null) {
    return response.statusCode! >= 200 && response.statusCode! <= 299;
  }
  return false;
}


Future<dynamic> getJobAds(String userId, String accessToken, String getJobsPath) async {
  print(accessToken);

  final apiClient = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 6000) ,
  ));

  try{
    dynamic response = await apiClient.get(
        getJobsPath,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $accessToken"
        }));

    if(!_isSuccessCall(response)) {
      throw Exception(response.data.message);
    }

    print("Jobs array");
    print(response.data);
    return response.data;
  } catch(e){
    print(e);
  }
}

Future<String> _saveAudioFile(Uint8List audioBytes) async {
  final directory = await getApplicationDocumentsDirectory();
  final fileName = '${DateTime.now().millisecondsSinceEpoch}.mp3';
  final file = File('${directory.path}/$fileName');
  await file.writeAsBytes(audioBytes);
  return file.path;
}