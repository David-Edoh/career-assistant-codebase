class CompleteStreakSession {
  String id;
  String sessionType;
  List<Map<String, dynamic>> chatHistory;

  CompleteStreakSession({
    required this.id,
    required this.sessionType,
    required this.chatHistory,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'sessionType': sessionType,
    'chatHistory': chatHistory,
  };

  factory CompleteStreakSession.fromJson(Map<String, dynamic> json) {
    return CompleteStreakSession(
      id: json['id'],
      sessionType: json['sessionType'],
      chatHistory: List<Map<String, dynamic>>.from(json['chatHistory']),
    );
  }
}