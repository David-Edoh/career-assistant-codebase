import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../../core/app_export.dart';
import '../../data/apiClient/api_client.dart';
import 'bloc/resume_maker_bloc.dart';
import 'models/resume_edit_session.dart';

class ResumeEditSessionProvider {

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  List<ResumeEditSession> _sessions = [];
  String? _currentSessionId;
  bool _isResponding = false;
  bool isSessionActive = false;
  List<ResumeEditSession> get sessions => _sessions;
  late Function startListening;
  final _apiClient = ApiClient();


  List<ResumeEditSession> get chatMessages {
    List<ResumeEditSession> s = _sessions.map((session) =>
        ResumeEditSession.fromJson(session.toJson())).toList();

    for (var element in s) {
      if (element.chatHistory.isNotEmpty) {
        if (element.chatHistory[0]["role"] == "user") {
          element.chatHistory.removeAt(0);
        }
      }
    }
    return s;
  }


  ResumeEditSession? get currentSession => _sessions.last;

  bool get isResponding => _isResponding;

  ResumeEditSessionProvider() {
    _loadChatHistory();
  }


  Future<void> _loadChatHistory() async {
    try {
      String? storedSessions = await _storage.read(key: 'chat_sessions');
      if (storedSessions != null) {
        List<dynamic> sessionList = jsonDecode(storedSessions);
        _sessions =
            sessionList.map((json) => ResumeEditSession.fromJson(json)).toList();
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
    if (currentSession != null) {
      currentSession?.chatHistory.add({
        'role': isUser ? "user" : "model",
        'parts': [{'text': message}],
      });
      _saveChatHistory();
    }
  }

  void didNotHearWell() {
    final session = currentSession;
    if (session != null) {
      session.chatHistory.add({
        'message': "Sorry I did not hear you properly, What did you say?",
        'isUser': false.toString(),
      });
      _saveChatHistory();
    }
  }


  dynamic sendPrompt(String prompt, String path, Map<String, dynamic> userData) async {
    _isResponding = true;
    _addMessage(prompt, isUser: true);

    try {
      dynamic value = await _apiClient.postData(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userData['accessToken']}"
        },
        path: path,
        requestData: {
          "prompt": prompt,
          "chat_history": currentSession?.chatHistory,
        },
      );

      print(value);

      if(value["result"]["type"] != "question"){
        /// Gemini Sometime returns the wrong keys -------- FIX ----------------------------------------------------
        for(int i = 0; i < value["result"]["experiences"].length; i++){
          value["result"]["experiences"][i]["position"] = value["result"]["experiences"][i]["title"] ?? value["result"]["experiences"][i]["position"];
          value["result"]["experiences"][i]["address"] = value["result"]["experiences"][i]["location"] ?? value["result"]["experiences"][i]["address"];
        } ///---------------------------------------------- FIX ----------------------------------------------------
      }

      _addMessage(value["result"].toString(), isUser: false);

      return value;
    } catch (e) {
      print('Error sending message: $e');
    }
  }


  void createSession(String id, String sessionType) async {
    ResumeEditSession newSession = ResumeEditSession(
        id: id, sessionType: sessionType, chatHistory: []);
    _sessions.add(newSession);
    isSessionActive = true;

    _currentSessionId = id;
    // Add initial user details to chat conversation here....


    _saveChatHistory();
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