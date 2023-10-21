part of 'list_task_cubit.dart';

class ListTaskState {
  final List<Task> tasks;
  final bool canViewDoneTasks;
  final bool isSubmitting;
  ListTaskState({
    required this.tasks,
    required this.isSubmitting,
    this.canViewDoneTasks = false,
  });
  //copyWith
  ListTaskState copyWith({
    List<Task>? tasks,
    bool? isSubmitting,
    bool? canViewDoneTasks,
  }) {
    return ListTaskState(
      tasks: tasks ?? this.tasks,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      canViewDoneTasks: canViewDoneTasks ?? this.canViewDoneTasks,
    );
  }
}
