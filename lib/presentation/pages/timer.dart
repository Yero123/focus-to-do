import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_to_do/data/models/task.dart';
import 'package:focus_to_do/logic/list_task/list_task_cubit.dart';
import 'package:focus_to_do/logic/timer/timer_cubit.dart';
import 'package:focus_to_do/presentation/common/task_check_box.dart';
import 'package:focus_to_do/presentation/pages/task_list.dart';
import 'package:focus_to_do/presentation/utils/arguments_page.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ArgumentTimerPage;
    return SafeArea(
      child: Scaffold(
        body: BlocProvider.value(
          value: timerCubit..init(arguments.task),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xfffb4474), Color(0xffff6336)],
                stops: [0, 1],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => {Navigator.pop(context)},
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            color: AppColors.white, size: 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BlocBuilder<TimerCubit, TimerState>(
                    builder: (context, state) {
                      return TaskTile(
                        title: timerCubit.task.title,
                        priority: timerCubit.task.priority,
                        pomodoros: timerCubit.task.pomodoros,
                        fecha: false,
                        id: timerCubit.task.id,
                        isDone: timerCubit.task.isDone,
                        task: timerCubit.task,
                      );
                    },
                  ),
                ),
                IconCircle(),
                BlocBuilder<TimerCubit, TimerState>(
                  builder: (context, state) {
                    if (state.isPaused) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => {timerCubit.resumeTimer()},
                              child: Container(
                                width: 120,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Continuar",
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => {timerCubit.finishTimer()},
                              child: Container(
                                width: 120,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 207, 205, 205),
                                      width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Terminar",
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ),
                          ]);
                    }
                    if (state.isRunning) {
                      return InkWell(
                        onTap: () => {timerCubit.pauseTimer()},
                        child: Container(
                          width: 120,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: Color.fromARGB(255, 207, 205, 205),
                                width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Pausa",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      );
                    }
                    if (!state.isPaused && !state.isRunning) {
                      return InkWell(
                        onTap: () => {timerCubit.startTimer()},
                        child: Container(
                          width: 260,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.play_arrow,
                                  color: AppColors.primaryColor, size: 26),
                              const SizedBox(width: 10),
                              const Text("Comenzar a Enfocarse",
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      );
                    }
                    return SizedBox();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final TaskPriority priority;
  final String title;
  final int pomodoros;
  final bool fecha;
  final bool isActive;
  final String id;
  final bool isDone;
  final Task task;
  const TaskTile({
    Key? key,
    this.priority = TaskPriority.none,
    this.title = "",
    this.pomodoros = 0,
    this.fecha = false,
    this.isActive = false,
    this.id = "",
    this.isDone = false,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        listTaskCubit.editTask(id, isDone: !isDone);
                        timerCubit.changeTask(!isDone);
                      },
                      child: TaskCheckBox(priority: priority)),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                            color: isDone
                                ? Color.fromARGB(255, 183, 174, 174)
                                : AppColors.gray,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            decoration: isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          )),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          if (task.pomodorosDone > 0)
                            for (var i = 0; i < task.pomodorosDone; i++)
                              const Padding(
                                padding: EdgeInsets.only(right: 3),
                                child: Icon(
                                  Icons.timer,
                                  color: AppColors.primaryColor,
                                  size: 14,
                                ),
                              ),
                          if (pomodoros > 0)
                            for (var i = 0;
                                i < pomodoros - task.pomodorosDone;
                                i++)
                              const Padding(
                                padding: EdgeInsets.only(right: 3),
                                child: Icon(
                                  Icons.timer,
                                  color: AppColors.primaryColorIncomplete,
                                  size: 14,
                                ),
                              ),
                          if (fecha)
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Row(children: const [
                                Icon(Icons.calendar_today,
                                    color: AppColors.primaryColor, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  "Lun, 3 jul",
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 14),
                                )
                              ]),
                            )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const Spacer(),
              // const Icon(Icons.control_point_outlined,
              //     color: AppColors.gray, size: 26)
            ],
          )),
    );
  }
}

class IconCircle extends StatelessWidget {
  const IconCircle();

  @override
  Widget build(BuildContext context) {
    int length = 22;
    return Container(
      width: double.infinity, // Tamaño del círculo
      height: 480,
      child: Stack(children: [
        BlocBuilder<TimerCubit, TimerState>(
          builder: (context, state) {
            int cantidad = state.seconds % 22;
            return Stack(children: [
              ...List.generate(
                length,
                (index) {
                  final double angle = (2 * pi * index) / length;
                  final double x = cos(angle);
                  final double y = sin(angle);
                  return Positioned(
                    left: 200 +
                        x * 165, // Ajusta la posición de los íconos según el radio
                    top: 200 + y * 165,
                    child: Transform.rotate(
                      angle: angle -
                          pi / 2, // Alinea los íconos con el centro del círculo
                      child: Icon(
                        index > cantidad
                            ? Icons.privacy_tip_outlined
                            : Icons.privacy_tip,
                        size: 15,
                        color: AppColors.white, // Tamaño del ícono
                      ),
                    ),
                  );
                },
              ),
            ]);
          },
        ),
        Positioned(
          top: 160,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<TimerCubit, TimerState>(
                  builder: (context, state) {
                    int minutes = state.seconds ~/ 60;
                    int seconds = state.seconds % 60;
                    String minutesStr = minutes < 10 ? "0$minutes" : "$minutes";
                    String secondsStr = seconds < 10 ? "0$seconds" : "$seconds";
                    return Text(
                      "$minutesStr:$secondsStr",
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 80,
                          fontWeight: FontWeight.w100),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
