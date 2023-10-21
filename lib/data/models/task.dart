import 'package:focus_to_do/presentation/utils/constants.dart';

class Task {
  final String id;
  final String title;
  final int pomodoros;
  final TaskPriority priority;
  final DateTime? date;
  final TaskTime? time;
  final int pomodorosDone;
  final String? projectId;
  final bool isDone;
  final String? description;
  Task({
    required this.id,
    required this.title,
    this.pomodoros = 0,
    this.priority = TaskPriority.none,
    this.date,
    this.pomodorosDone = 0,
    required this.projectId,
    this.isDone = false,
    this.time,
    this.description,
  });
  //copyWith
  Task copyWith({
    String? id,
    String? title,
    int? pomodoros,
    TaskPriority? priority,
    DateTime? date,
    int? pomodorosDone,
    String? projectId,
    bool? isDone,
    TaskTime? time,
    String? description,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      pomodoros: pomodoros ?? this.pomodoros,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      pomodorosDone: pomodorosDone ?? this.pomodorosDone,
      projectId: projectId ?? this.projectId,
      isDone: isDone ?? this.isDone,
      time: time ?? this.time,
      description: description ?? this.description,
    );
  }

  //fromJson
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      pomodoros: json['pomodoros'],
      priority: json['priority'] != null
          ? TaskPriority.values[json['priority']]
          : TaskPriority.none,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      pomodorosDone: json['pomodorosDone'],
      projectId: json['projectId'],
      isDone: json['isDone'],
      time: json['time'] != null ? TaskTime.values[json['time']] : null,
      description: json['description'],
    );
  }
  //toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'pomodoros': pomodoros,
      'priority': priority?.index,
      'date': date?.toIso8601String(),
      'pomodorosDone': pomodorosDone,
      'projectId': projectId,
      'isDone': isDone,
      'time': time?.index,
      'description': description,
    };
  }
}
