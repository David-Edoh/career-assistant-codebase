class ResumeEditSession {
  String id;
  String sessionType;
  List<Map<String, dynamic>> chatHistory;

  ResumeEditSession({
    required this.id,
    required this.sessionType,
    required this.chatHistory,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'sessionType': sessionType,
    'chatHistory': chatHistory,
  };

  factory ResumeEditSession.fromJson(Map<String, dynamic> json) {
    return ResumeEditSession(
      id: json['id'],
      sessionType: json['sessionType'],
      chatHistory: List<Map<String, dynamic>>.from(json['chatHistory']),
    );
  }
}