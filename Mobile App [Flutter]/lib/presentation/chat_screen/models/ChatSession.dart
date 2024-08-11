class ChatSession {
  String id;
  String sessionType;
  List<Map<String, dynamic>> chatHistory;

  ChatSession({
    required this.id,
    required this.sessionType,
    required this.chatHistory,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'sessionType': sessionType,
    'chatHistory': chatHistory,
  };

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id'],
      sessionType: json['sessionType'],
      chatHistory: List<Map<String, dynamic>>.from(json['chatHistory']),
    );
  }
}