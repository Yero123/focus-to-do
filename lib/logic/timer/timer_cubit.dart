import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:focus_to_do/data/models/task.dart';
import 'package:focus_to_do/logic/edit_task/edit_task_cubit.dart';
import 'package:focus_to_do/logic/list_task/list_task_cubit.dart';
import 'package:meta/meta.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerState(seconds: 0));
  late Timer _timer;
  late Task task;
  void init(Task initialTask) {
    task = initialTask;
  }

  void startTimer() {
    emit(state.copyWith(seconds: 0, isRunning: true));
    _startCountdown();
  }

  void pauseTimer() {
    _timer.cancel();
    emit(state.copyWith(isPaused: true));
  }

  void resumeTimer() {
    emit(state.copyWith(isRunning: true, isPaused: false));
    _startCountdown();
  }

  void finishTimer() {
    _timer.cancel();
    listTaskCubit.editTask(task.id, addPomodoroDone: true);
    task = task.copyWith(pomodorosDone: task.pomodorosDone + 1);
    emit(state.copyWith(seconds: 0, isRunning: false, isPaused: false));
  }

  void resetTimer() {
    _timer.cancel();

    emit(state.copyWith(seconds: 0, isRunning: false, isPaused: false));
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newSecond = state.seconds + 1;
      emit(state.copyWith(seconds: newSecond));
    });
  }

  void changeTask(bool isDone) {
    task = task.copyWith(isDone: isDone);
  }
}

TimerCubit timerCubit = TimerCubit();
