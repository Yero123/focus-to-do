import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:focus_to_do/data/dataproviders/task_preference.dart';
import 'package:focus_to_do/data/models/task.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';
import 'package:meta/meta.dart';

part 'list_task_state.dart';

class ListTaskCubit extends Cubit<ListTaskState> {
  ListTaskCubit() : super(ListTaskState(tasks: [], isSubmitting: false));
  FiltersListTask filtersListTask = FiltersListTask();
  init({FiltersListTask? filters}) {
    //save filter in state}
    if (filters != null) {
      filtersListTask = FiltersListTask(
        projectId: filters?.projectId,
        time: filters?.time,
      );
    }
    getTasks();
  }

  getTasks() async {
    emit(state.copyWith(
      isSubmitting: true,
    ));
    List<Task> tasks = await TaskPreference.getTasks(filters: filtersListTask);
    emit(state.copyWith(
      tasks: tasks,
      isSubmitting: false,
    ));
  }

  changeCanViewDoneTasks(bool canViewDoneTasks) {
    emit(state.copyWith(
      canViewDoneTasks: canViewDoneTasks,
    ));
  }

  editTask(
    String id, {
    TaskPriority? priority,
    TaskTime? time,
    bool? isDone,
    bool? addPomodoroDone,
  }) {
    List<Task> newtasks = state.tasks;
    Task task = newtasks.firstWhere((element) => element.id == id);
    newtasks.removeWhere((element) => element.id == id);
    newtasks.add((task).copyWith(
        priority: priority,
        isDone: isDone,
        time: time,
        pomodorosDone: addPomodoroDone == true
            ? task.pomodorosDone + 1
            : task.pomodorosDone));
    TaskPreference.saveTasks(newtasks).then((value) {
      getTasks();
    });
  }

  deleteTask(String id) async {
    emit(state.copyWith(
      isSubmitting: true,
    ));
    List<Task> tasks = state.tasks;
    tasks.removeWhere((element) => element.id == id);
    TaskPreference.deleteTaskById(id).then((value) {
      emit(state.copyWith(
        tasks: tasks,
        isSubmitting: false,
      ));
    });
  }
}

ListTaskCubit listTaskCubit = ListTaskCubit();

class FiltersListTask {
  final String? projectId;
  final TaskTime? time;

  FiltersListTask({this.projectId, this.time});
  //copyWith

  FiltersListTask copyWith({
    String? projectId,
    TaskTime? time,
  }) {
    return FiltersListTask(
      projectId: projectId ?? this.projectId,
      time: time ?? this.time,
    );
  }
}
