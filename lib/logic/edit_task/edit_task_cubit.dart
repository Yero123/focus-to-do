import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:focus_to_do/data/dataproviders/proyects_preference.dart';
import 'package:focus_to_do/data/dataproviders/task_preference.dart';
import 'package:focus_to_do/data/models/project.dart';
import 'package:focus_to_do/data/models/task.dart';
import 'package:focus_to_do/logic/list_task/list_task_cubit.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';
import 'package:meta/meta.dart';

part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit({
    required Task task,
  }) : super(EditTaskState(
          task: task,
        ));
  TextEditingController nameEditingController = TextEditingController();

  void init() async {
    if (state.task.projectId != null) {
      Project project =
          await ProjectPreference.getProject(state.task.projectId!);
      emit(state.copyWith(project: project));
      nameEditingController.text = state.task.title;
    }
  }

  void changeProperties({
    String? title,
    int? pomodoros,
    TaskPriority? priority,
    TaskTime? time,
    Project? project,
    bool? isDone,
    String? description,
  }) async {
    await TaskPreference.editTask(state.task.copyWith(
      title: title ?? state.task.title,
      pomodoros: pomodoros ?? state.task.pomodoros,
      priority: priority ?? state.task.priority,
      isDone: isDone ?? state.task.isDone,
      time: time ?? state.task.time,
      projectId: project?.id,
      description: description ?? state.task.description,
    ));

    emit(state.copyWith(
      task: state.task.copyWith(
        title: title ?? state.task.title,
        pomodoros: pomodoros ?? state.task.pomodoros,
        priority: priority ?? state.task.priority,
        time: time ?? state.task.time,
        // date: date ?? state.task.date,
        projectId: project != null ? project?.id : null,
        description: description ?? state.task.description,
        isDone: isDone ?? state.task.isDone,
      ),
      project: project ?? state.project,
    ));
    listTaskCubit.getTasks();
  }

  Future<void> deleteTask() async {
    await TaskPreference.deleteTaskById(state.task.id);
    listTaskCubit.getTasks();
  }

  //
}
