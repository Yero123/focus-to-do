import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:focus_to_do/data/dataproviders/proyects_preference.dart';
import 'package:focus_to_do/data/dataproviders/task_preference.dart';
import 'package:focus_to_do/data/models/project.dart';
import 'package:focus_to_do/logic/list_task/list_task_cubit.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/task.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  static const uuid = Uuid();
  final _keyboardStateController = StreamController<bool>.broadcast();
  Stream<bool> get keyboardStateStream => _keyboardStateController.stream;
  TextEditingController textEditingController = TextEditingController();
  void changeKeyboardState(bool isKeyboardActive) {
    _keyboardStateController.add(isKeyboardActive);
  }

  CreateTaskCubit()
      : super(CreateTaskState(
          title: "",
          pomodoros: 0,
          priority: TaskPriority.none,
          time: TaskTime.today,
          date: DateTime.now(),
          project: null,
          isSubmitting: false,
          isKeyboardActive: false,
        ));

  void selectCuantityPomodoros(int pomodoros) {
    emit(state.copyWith(
      pomodoros: pomodoros,
    ));
  }

  void init({Project? project, TaskTime? time}) {
    emit(state.copyWith(
      project: project,
      time: time,
    ));
  }

  void selectPriority(TaskPriority priority) {
    emit(state.copyWith(
      priority: priority,
    ));
  }

  void selectTime(TaskTime time) {
    emit(state.copyWith(
      time: time,
    ));
  }

  void selectProject(Project project) {
    emit(state.copyWith(
      project: project,
    ));
  }

  void changeTitle(String title) {
    emit(state.copyWith(
      title: title,
    ));
  }

  void deselectProject() {
    emit(state.deleteProyect());
  }

  void submit() async {
    emit(state.copyWith(
      isSubmitting: true,
    ));
    // await TaskPreference.deleteAllTasks();
    // await ProjectPreference.deleteAllProyects();

    String id = uuid.v4();
    Task task = Task(
      title: textEditingController.text,
      id: id,
      pomodoros: state.pomodoros,
      priority: state.priority,
      projectId: state.project?.id,
      time: state.time,
    );
    textEditingController.clear();
    textEditingController.selection = const TextSelection.collapsed(offset: 0);
    TaskPreference.saveTask(task).then((value) {
      emit(state.copyWith(
        title: "",
        pomodoros: 0,
        priority: TaskPriority.none,
        time: TaskTime.today,
        date: DateTime.now(),
        project: null,
        isSubmitting: false,
        isKeyboardActive: false,
      ));
      listTaskCubit.getTasks();
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  @override
  Future<void> close() {
    _keyboardStateController.close();
    return super.close();
  }
}

CreateTaskCubit createTaskCubit = CreateTaskCubit();
