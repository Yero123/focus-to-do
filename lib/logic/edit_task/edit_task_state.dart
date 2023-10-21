part of 'edit_task_cubit.dart';

class EditTaskState {
  final Task task;
  final Project? project;
  EditTaskState({required this.task, this.project});

  EditTaskState copyWith({
    Task? task,
    Project? project,
  }) {
    return EditTaskState(
      task: task ?? this.task,
      project: project ?? this.project,
    );
  }
}
