part of 'create_task_cubit.dart';

class CreateTaskState {
  final String title;
  final int pomodoros;
  final TaskPriority priority;
  final TaskTime? time;
  final DateTime? date;
  final Project? project;
  final bool? isSubmitting;
  final bool? isKeyboardActive;
  CreateTaskState({
    required this.title,
    required this.pomodoros,
    required this.priority,
    required this.time,
    required this.date,
    required this.project,
    required this.isSubmitting,
    required this.isKeyboardActive,
  });

  //copyWith
  CreateTaskState copyWith({
    String? title,
    int? pomodoros,
    TaskPriority? priority,
    TaskTime? time,
    DateTime? date,
    Project? project,
    bool? isSubmitting,
    bool? isKeyboardActive,
  }) {
    return CreateTaskState(
      title: title ?? this.title,
      pomodoros: pomodoros ?? this.pomodoros,
      priority: priority ?? this.priority,
      time: time ?? this.time,
      date: date ?? this.date,
      project: project ?? this.project,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isKeyboardActive: isKeyboardActive,
    );
  }

  CreateTaskState deleteProyect() {
    return CreateTaskState(
      title: title,
      pomodoros: pomodoros,
      priority: priority,
      time: time,
      date: date,
      project: null,
      isSubmitting: isSubmitting,
      isKeyboardActive: isKeyboardActive,
    );
  }
}
