import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../../../data/apiClient/api_client.dart';
import '../../../core/app_export.dart';
import 'models/session.dart';


class StreakSessionProvider {

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  List<CompleteStreakSession> _sessions = [];
  String? _currentSessionId;
  bool _isResponding = false;
  bool isSessionActive = false;
  List<CompleteStreakSession> get sessions => _sessions;
  late Function startListening;
  final _apiClient = ApiClient();


  List<CompleteStreakSession> get chatMessages {
    List<CompleteStreakSession> s = _sessions.map((session) =>
        CompleteStreakSession.fromJson(session.toJson())).toList();

    for (var element in s) {
      if (element.chatHistory.isNotEmpty) {
        if (element.chatHistory[0]["role"] == "user") {
          element.chatHistory.removeAt(0);
        }
      }
    }
    return s;
  }


  CompleteStreakSession? get currentSession => _sessions.last;

  bool get isResponding => _isResponding;

  // StreakSessionProvider() {
  //   print("new StreakSessionProvider instance created ");
  //   loadChatHistory();
  // }


  Future<void> loadChatHistory() async {
    try {
      String? storedSessions = await _storage.read(key: 'chat_sessions');
      if (storedSessions != null) {
        List<dynamic> sessionList = jsonDecode(storedSessions);
        _sessions = sessionList.map((json) => CompleteStreakSession.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error loading chat history: $e');
    }
  }

  Future<void> _saveChatHistory() async {
    try {
      await _storage.write(key: 'chat_sessions', value: jsonEncode(_sessions));
      print("session saved");
    } catch (e) {
      print('Error saving chat history: $e');
    }
  }

  void addMessage(String message, {required bool isUser}) {
    if (currentSession != null) {
      currentSession?.chatHistory.add({
        'role': isUser ? "user" : "model",
        'parts': [{'text': message}],
      });
      _saveChatHistory();
    }
  }


  void createSession(String id, String sessionType) async {
    // _sessions.clear();
    CompleteStreakSession newSession = CompleteStreakSession(id: id, sessionType: sessionType, chatHistory: []);
    print(_sessions.length);
    _sessions.add(newSession);
    print(id);
    // isSessionActive = true;

    // _currentSessionId = id;
    // Add initial user details to chat conversation here....


    await _saveChatHistory();
  }

  void switchSession(String id) {
    if (_sessions.any((session) => session.id == id)) {
      _currentSessionId = id;
    }
  }

  @override
  void dispose() {
    // super.dispose();
  }

}