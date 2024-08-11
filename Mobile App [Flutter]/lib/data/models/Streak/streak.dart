import 'dart:convert';

class Streak {
  final int id;
  final DateTime? startDate;
  final DateTime? endDate;
  final int currentStreak;
  final int? recentlyWonMilestone;
  final int currentMilestone;
  final int longestStreak;
  final bool hasFailed;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final int careerId;
  final User user;
  final List<Progress> progress;
  final List<Schedule> schedule;

  Streak({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.currentStreak,
    required this.recentlyWonMilestone,
    required this.currentMilestone,
    required this.longestStreak,
    required this.hasFailed,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.careerId,
    required this.user,
    required this.progress,
    required this.schedule,
  });

  factory Streak.fromJson(Map<String, dynamic> json) {
    return Streak(
      id: json['id'],
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      currentStreak: json['current_streak'],
      currentMilestone: json['current_milestone'],
      recentlyWonMilestone: json['recently_won_milestone'],
      longestStreak: json['longest_streak'],
        hasFailed: json['hasFailed'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['userId'],
      careerId: json['careerId'],
      user: User.fromJson(json['User']),
      progress: (json['progress'] as List<dynamic>).map((e) => Progress.fromJson(e)).toList(),
      schedule: (json['schedule'] as List<dynamic>).map((e) => Schedule.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'current_streak': currentStreak,
      'current_milestone': currentMilestone,
      'recently_won_milestone': recentlyWonMilestone,
      'longest_streak': longestStreak,
      'hasFailed': hasFailed,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId,
      'careerId': careerId,
      'User': user.toJson(),
      'progress': progress.map((e) => e.toJson()).toList(),
      'schedule': schedule.map((e) => e.toJson()).toList(),
    };
  }
}

class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String? picturePath;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.picturePath,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      picturePath: json['picturePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'picturePath': picturePath,
    };
  }
}

class Progress {
  final int id;
  final String progressDescription;
  final int? subjectId;
  final int? score;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final int streakId;

  Progress({
    required this.id,
    required this.progressDescription,
    this.subjectId,
    this.score,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.streakId,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'],
      progressDescription: json['progress_description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['userId'],
      streakId: json['streakId'],
      score: json['score'],
      subjectId: json['subjectId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'progress_description': progressDescription,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId,
      'streakId': streakId,
      'subjectId': subjectId,
      'score': score,
    };
  }
}

class Schedule {
  final int id;
  final bool monday;
  final bool tuesday;
  final bool wednesday;
  final bool thursday;
  final bool friday;
  final bool saturday;
  final bool sunday;
  final String startTime;
  final String endTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final int streakId;

  Schedule({
    required this.id,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.streakId,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      monday: json['monday'],
      tuesday: json['tuesday'],
      wednesday: json['wednesday'],
      thursday: json['thursday'],
      friday: json['friday'],
      saturday: json['saturday'],
      sunday: json['sunday'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['userId'],
      streakId: json['streakId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday,
      'startTime': startTime,
      'endTime': endTime,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId,
      'streakId': streakId,
    };
  }

  // Method to collect days' boolean values into a list
  List<bool> getDaysAsList() {
    return [monday, tuesday, wednesday, thursday, friday, saturday, sunday];
  }
}
