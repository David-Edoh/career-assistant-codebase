import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'dart:typed_data';
import 'package:just_audio/just_audio.dart';
import '../../../data/apiClient/api_client.dart';
import '../models/ChatSession.dart';

class ChatProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late IO.Socket _socket;
  List<ChatSession> _sessions = [];
  String? _currentSessionId;
  bool _isResponding = false;
  late AudioPlayer _audioPlayer = AudioPlayer();
  bool keepConnectionOpen = false;
  bool isSessionActive = false;
  List<ChatSession> get sessions => _sessions;
  late Function startListening;
  late Function endCall;
  late Function createNewSpeech;
  late StreamController<Uint8List> _audioStreamController;
  late StreamController<Uint8List> _checkAudioStreamController;
  late MyCustomSource audioSourceLengthChecker;
  bool isPlayingAudio = false;
  final _apiClient = ApiClient();
  var baseUrl = dotenv.env['FOTISIA_BACKEND_BASE_URL'];
  bool sessionExpired = false;


  List<ChatSession> get chatMessages {
    List<ChatSession> s = _sessions.map((session) => ChatSession.fromJson(session.toJson())).toList();

    for (var element in s) {
      if(element.chatHistory.isNotEmpty){
        if(element.chatHistory[0]["role"] == "user"){
          element.chatHistory.removeAt(0);
        }
      }
    }
    return s;
  }

  void setSessionExpired(bool value){
    sessionExpired = value;
  }

  void stopAudio(){
    _audioPlayer.stop();
  }

  ChatSession? get currentSession => _sessions.last;
  bool get isResponding => _isResponding;

  ChatProvider(){
    _loadChatHistory();
  }

  void _initializeSocket() {
    try {
      _socket = IO.io(baseUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      _socket.on('connect', (_) {
        print('connected');
      });

      _socket.on('disconnect', (_) {
        print('disconnected');
        sessionExpired = false;
        _reconnectSocket();
      });

      _socket.on('audioData', (data) async {
        final audioBytes = base64Decode(data);
        _audioStreamController.add(audioBytes);
        print(isPlayingAudio);

        if (!_audioPlayer.playing && !isPlayingAudio) {
          print("played audio");
          await _playAudio();
        }
      });

      _socket.on('audioDataEnd', (data) async {
        print("audioDataEnd");

        final audioBytes = base64Decode(data);
        _checkAudioStreamController = StreamController<Uint8List>();
        _checkAudioStreamController.add(audioBytes);
        audioSourceLengthChecker = MyCustomSource(_checkAudioStreamController.stream);
        AudioPlayer player  = AudioPlayer();
        await player.setAudioSource(audioSourceLengthChecker);
      });

      _socket.on('message', (data) {
        _addMessage(data['message'], isUser: false);
      });

      _socket.on('error', (error) {
        print('Socket error: $error');
        _reconnectSocket();
      });

      _socket.connect();
    } catch (e) {
      print('Socket connection error: $e');
      _reconnectSocket();
    }
  }

  Future<void> _playAudio() async {
    isPlayingAudio = true;
    try {
      MyCustomSource audioSource = MyCustomSource(_audioStreamController.stream);

      await _audioPlayer.setAudioSource(audioSource);
      _audioPlayer.setSpeed(0.9);
      _audioPlayer.play();

      _audioPlayer.processingStateStream.listen((state) async {
        if (state == ProcessingState.completed) {

          if(sessionExpired){
            await endCall();
            _isResponding = false;
            isPlayingAudio = false;
            return;
          }

          if(audioSourceLengthChecker.duration != null && _audioPlayer.position.inSeconds >= audioSourceLengthChecker.duration!.inSeconds){
            _audioStreamController = StreamController<Uint8List>();
            createNewSpeech();
            startListening();
            _isResponding = false;
            await _audioPlayer.stop();
            return;
          }

          // if (audioSource.buffer.isNotEmpty) {
          //   // Check if more data is available to continue playback
          //   await _audioPlayer.seek(_audioPlayer.position);
          //   _audioPlayer.play();
          // }
        }
      });

    } catch (e) {
      print('Error playing audio: $e');
    }
  }




  void _reconnectSocket() {
    if (keepConnectionOpen) {
      Future.delayed(const Duration(seconds: 5), () {
        if (!_socket.connected) {
          _socket.connect();
        }
      });
    }
  }

  Future<void> _loadChatHistory() async {
    try {
      String? storedSessions = await _storage.read(key: 'chat_sessions');
      if (storedSessions != null) {
        List<dynamic> sessionList = jsonDecode(storedSessions);
        _sessions = sessionList.map((json) => ChatSession.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error loading chat history: $e');
    }
  }

  Future<void> _saveChatHistory() async {
    try {
      await _storage.write(key: 'chat_sessions', value: jsonEncode(_sessions));
    } catch (e) {
      print('Error saving chat history: $e');
    }
  }

  void _addMessage(String message, {required bool isUser}) {
    final session = currentSession;
    if (session != null) {
      session.chatHistory.add({
        'role': isUser ? "user" : "model",
        'parts': [{'text': message}],
      });
      _saveChatHistory();
      notifyListeners();
    }
    notifyListeners();
  }

  void didNotHearWell() {
    final session = currentSession;
    if (session != null) {
      session.chatHistory.add({
        'message': "Sorry I did not hear you properly, What did you say?",
        'isUser': false.toString(),
      });
      _saveChatHistory();
      notifyListeners();
    }
  }

  void closeConnection() {
    isPlayingAudio = false;
    _isResponding = false;
    keepConnectionOpen = false;
    isSessionActive = false;
    _socket.disconnect();
    _socket.clearListeners();
    _socket.close();
  }

  void openConnection() {
    keepConnectionOpen = true;
    _audioStreamController = StreamController<Uint8List>();
    _initializeSocket();
  }

  void sendMessage(String message, Function startListeningCallBack, Function createNewSpeechCalBack) {
    startListening = startListeningCallBack;
    createNewSpeech = createNewSpeechCalBack;
    isPlayingAudio = false;

    _isResponding = true;
    print(isResponding);

    try {
      _socket.emit('message', jsonEncode({'message': '$message. ${sessionExpired ? "systemInstruction: Session has exceeded 5min, Inform the user we are out of time and give the user your final advice, a score and end the call by saying goodbye" : ""}', 'history': currentSession?.chatHistory}));
      _addMessage(message, isUser: true);
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  void setStartListeningFunction(Function startListeningCallBack, Function createNewSpeechCalBack, Function endCallFunction){
    startListening = startListeningCallBack;
    createNewSpeech = createNewSpeechCalBack;
    endCall = endCallFunction;
  }

  void createSession(String id, String sessionType) async {
    ChatSession newSession = ChatSession(id: id, sessionType: sessionType, chatHistory: []);
    _sessions.add(newSession);
    isSessionActive = true;

    _currentSessionId = id;
    // Add initial user details to chat conversation here....
    String? userResumeData = await getUserResumeData();

    List<ChatSession> lastTwoSessions = [];
    for(int i = sessions.length - 1; i >= 0; i--){
      if(lastTwoSessions.length >= 2){
        break;
      }

      if(sessions[i].sessionType == "career-coaching"){
        lastTwoSessions.add(sessions[i]);
      }
    }

    if(userResumeData != null && currentSession != null){
      String? message;
      switch (sessionType) {
        case 'career-coaching':
          message = "Here is my career detail in JSON: $userResumeData. This is a career coaching call session, You are my career coach. ask me about any other detail you need and give me advice on what direction I should take. The career coaching call session starts now! ask your questions briefly, keep it short and ask one question at a time, We'd take turns talking. From now on, you are the in charge! Go straight to the point! Introduce yourself as Sia and start the session. \n\n systemInstruction: when you have any required enquiry, you can ask. When we run out of time, proceed to end the call by giving me your final recommendation and a score of my performance."; // systemInstructions: previous session with user ${lastTwoSessions.toString()}
          break;
        case 'choose-a-career':
          message = "Here is my career detail in JSON: $userResumeData. I will like to start a new career but I don't know which career to choose, Help me find the suitable career for me. ask me about any detail you need and give me suitable career options. The career coaching call session starts now! ask your questions briefly, keep it short and ask one question at a time, We'd take turns talking. From now on, you are the in charge! Go straight to the point! Introduce yourself as Sia and start the session. \n\n systemInstruction: when you have any required enquiry, you can ask. When we run out of time, proceed to end the call by giving me your final recommendation and a score of my performance. systemInstructions: previous session with user ${lastTwoSessions.toString()}";
          break;
        case 'interview-simulation':
          message = "Here is my career detail in JSON: $userResumeData. Simulate a call interview session where you interview me about a job position so I can become more confident with job interviews. Score and tell me how i performed after the interview and how i can become better. The interview starts now! ask your questions briefly and one at a time if any, We'd take turns talking. From now on, you are the interviewer! Go straight to the point! Introduce yourself as Sia and start the session. \n\n systemInstruction: when you have any required enquiry, you can ask. When we run out of time, proceed to end the call by giving me your final recommendation and a score of my performance.";
          break;
        case 'pitch-session':
          message = "Here is my career detail in JSON: $userResumeData. Simulate a call pitch session where you listen to me pitch my startup or idea so I can become more confident with with it. Score and tell me how i performed after the pitching session and how i can become better. The pitching session starts now! ask your questions briefly and one at a time if any, We'd take turns talking. From now on, you are the investor! Go straight to the point! Introduce yourself as Sia and start the session. \n\n systemInstruction: when you have any required enquiry, you can ask. When we run out of time, proceed to end the call by giving me your final recommendation and a score of my performance.";
          break;
        case 'progress-tracking':
          message = "Here is my career detail in JSON: $userResumeData. Simulate a progress tracking call session to evaluate how committed I am to my career, You are my career guide in this call session. Look at my current progress and ask me about any other detail you need and give me advice on what I should improve on. The progress-tracking session starts now! ask your questions briefly and one at a time if any, We'd take turns talking. From now on, you are the in charge! Go straight to the point! Introduce yourself as Sia and start the session. \n\n systemInstruction: when you have any required enquiry, you can ask. When we run out of time, proceed to end the call by giving me your final recommendation and a score of my performance.";
          break;
        case 'skill-gap-analysis':
          message = "Here is my career detail in JSON: $userResumeData. This is a skill gap analysis call session to evaluate if there are gaps in my career skill/knowledge, You are my career guide. ask me about any other detail you need and give me advice on what I should improve on. The skill/knowledge gap analysis call session starts now! ask your questions briefly and one at a time if any, We'd take turns talking. From now on, you are the in charge! Go straight to the point! Introduce yourself as Sia and start the session. \n\n systemInstruction: when you have any required enquiry, you can ask. When we run out of time, proceed to end the call by giving me your final recommendation and a score of my performance.";
          break;
        default:
          message = "Here is my career detail in JSON: $userResumeData. This is a career coaching call session, You are my career coach. ask me about any other detail you need and give me advice on what direction I should take. The career coaching call session starts now! ask your questions briefly, keep it short and ask one question at a time, We'd take turns talking. From now on, you are the in charge! Go straight to the point! Introduce yourself as Sia and start the session. \n\n systemInstruction: when you have any required enquiry, you can ask. When we run out of time, proceed to end the call by giving me your final recommendation and a score of my performance.";
      }

      Map<String, dynamic> historyObj = {
        'role':  "user",
        'parts': [{'text': message}],
      };
      currentSession?.chatHistory.add(historyObj);
      _isResponding = true;
      _socket.emit('message', jsonEncode({'message': message, 'history': []}));
    }

    _saveChatHistory();
    notifyListeners();
  }

  void switchSession(String id) {
    if (_sessions.any((session) => session.id == id)) {
      _currentSessionId = id;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _socket.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }


  Future<String> getUserResumeData() async {

    String? userResumeData = await _storage.read(key: "userResumeData");
    if(userResumeData != null){
      return userResumeData;
    }

    String resumeJson = "";
    String? jsonString = await _storage.read(key: "userData");
    Map<String, dynamic> userData = json.decode(jsonString.toString());
    String path = "api/resume/user/${userData['id']}";

    await _apiClient.getData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        showLoading: true
    ).then((value) async {
      resumeJson = value['userResumeDetails'];
    }).onError((error, stackTrace) {
      // TODO: implement error call
      //   event.onLoginEventError?.call();
    });

    return resumeJson;
  }
}


class MyCustomSource extends StreamAudioSource {
  final StreamController<List<int>> _controller = StreamController();
  final List<int> buffer = [];

  MyCustomSource(Stream<Uint8List> audioStream) {
    audioStream.listen((chunk) {
      buffer.addAll(chunk);
      _controller.add(buffer);
    });
  }

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= buffer.length;
    final data = buffer.sublist(start, end);
    return StreamAudioResponse(
      sourceLength: buffer.length,
      contentLength: data.length,
      offset: start,
      stream: Stream.value(Uint8List.fromList(data)),
      contentType: 'audio/mpeg',
    );
  }


  @override
  void dispose() {
    _controller.close();
    // super.dispose();
  }
}

