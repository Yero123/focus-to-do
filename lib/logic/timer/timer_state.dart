part of 'timer_cubit.dart';

class TimerState {

  final int seconds;
  final bool isPaused;
  final bool isRunning;
  final bool isFinished;
  TimerState({

    required this.seconds,
    this.isPaused =false,
    this.isRunning =false,
    this.isFinished =false,
  });
  //copyWith
  TimerState copyWith({
    int? minutes,
    int? seconds,
    bool? isPaused,
    bool? isRunning,
    bool? isFinished,
  }) {
    return TimerState(
      seconds: seconds ?? this.seconds,
      isPaused: isPaused ?? this.isPaused,
      isRunning: isRunning ?? this.isRunning,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}
