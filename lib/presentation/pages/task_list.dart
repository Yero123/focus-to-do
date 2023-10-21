import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focus_to_do/data/models/project.dart';
import 'package:focus_to_do/data/models/task.dart';
import 'package:focus_to_do/logic/create_task/create_task_cubit.dart';
import 'package:focus_to_do/logic/list_task/list_task_cubit.dart';
import 'package:focus_to_do/logic/timer/timer_cubit.dart';
import 'package:focus_to_do/presentation/common/task_check_box.dart';
import 'package:focus_to_do/presentation/utils/alerts_dialogs.dart';
import 'package:focus_to_do/presentation/utils/arguments_page.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ArgumentTaskListPage;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.gray),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            InkWell(
                onTap: () {},
                child: const Icon(Icons.add_task_sharp, color: AppColors.gray)),
            const SizedBox(width: 25),
          ],
          title: Text(arguments.title, style: AppTextStyles.primaryColor),
        ),
        body: BlocProvider.value(
          value: listTaskCubit
            ..init(
                filters: FiltersListTask(
                    projectId: arguments.projectId, time: arguments.time)),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const StatisticGroup(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InputTitleTask(),
                          ),
                          const SizedBox(height: 10),
                          TaskList(),

                          // generate INPUT TASKS
                        ],
                      ),
                    ),
                  ),
                  KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) {
                    if (isKeyboardVisible)
                      return ExtraFormTask(
                        initialProyect: arguments.project,
                        initialTime: arguments.time,
                      );
                    return const TimerFloatingButton();
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListTaskCubit, ListTaskState>(
      builder: (context, state) {
        //render by priority
        List<TaskTile> highTask = [];
        List<TaskTile> mediumTask = [];
        List<TaskTile> lowTask = [];
        List<TaskTile> noneTask = [];
        List<TaskTile> doneTask = [];
        for (var i = 0; i < state.tasks.length; i++) {
          if (state.tasks[i].priority == TaskPriority.high &&
              !state.tasks[i].isDone) {
            highTask.add(TaskTile(
              title: state.tasks[i].title,
              priority: state.tasks[i].priority,
              pomodoros: state.tasks[i].pomodoros,
              fecha: state.tasks[i].date != null,
              id: state.tasks[i].id,
              isDone: state.tasks[i].isDone,
              task: state.tasks[i],
            ));
          }
          if (state.tasks[i].priority == TaskPriority.medium &&
              !state.tasks[i].isDone) {
            mediumTask.add(TaskTile(
              title: state.tasks[i].title,
              priority: state.tasks[i].priority,
              pomodoros: state.tasks[i].pomodoros,
              fecha: state.tasks[i].date != null,
              id: state.tasks[i].id,
              isDone: state.tasks[i].isDone,
              task: state.tasks[i],
            ));
          }
          if (state.tasks[i].priority == TaskPriority.low &&
              !state.tasks[i].isDone) {
            lowTask.add(TaskTile(
              title: state.tasks[i].title,
              priority: state.tasks[i].priority,
              pomodoros: state.tasks[i].pomodoros,
              fecha: state.tasks[i].date != null,
              id: state.tasks[i].id,
              isDone: state.tasks[i].isDone,
              task: state.tasks[i],
            ));
          }
          if (state.tasks[i].priority == TaskPriority.none &&
              !state.tasks[i].isDone) {
            noneTask.add(TaskTile(
              title: state.tasks[i].title,
              priority: state.tasks[i].priority,
              pomodoros: state.tasks[i].pomodoros,
              fecha: state.tasks[i].date != null,
              id: state.tasks[i].id,
              isDone: state.tasks[i].isDone,
              task: state.tasks[i],
            ));
          }
          if (state.tasks[i].isDone) {
            doneTask.add(TaskTile(
              title: state.tasks[i].title,
              priority: state.tasks[i].priority,
              pomodoros: state.tasks[i].pomodoros,
              fecha: state.tasks[i].date != null,
              isActive: true,
              id: state.tasks[i].id,
              isDone: state.tasks[i].isDone,
              task: state.tasks[i],
            ));
          }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (highTask.length > 0) ...[
              const TitleDivision(title: "Prioridad Alta", minutes: 0),
              const SizedBox(height: 10),
              for (var i = 0; i < highTask.length; i++) highTask[i],
            ],
            if (mediumTask.length > 0) ...[
              const TitleDivision(title: "Prioridad Media", minutes: 0),
              const SizedBox(height: 10),
              for (var i = 0; i < mediumTask.length; i++) mediumTask[i],
            ],
            if (lowTask.length > 0) ...[
              const TitleDivision(title: "Prioridad Baja", minutes: 0),
              const SizedBox(height: 10),
              for (var i = 0; i < lowTask.length; i++) lowTask[i],
            ],
            if (noneTask.length > 0) ...[
              const TitleDivision(title: "Sin prioridad", minutes: 0),
              const SizedBox(height: 10),
              for (var i = 0; i < noneTask.length; i++) noneTask[i],
            ],
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    listTaskCubit
                        .changeCanViewDoneTasks(!state.canViewDoneTasks);
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Motrar tareas completadas",
                            style:
                                TextStyle(color: AppColors.black, fontSize: 12),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.black,
                            size: 20,
                          )
                        ],
                      )),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (doneTask.length > 0 && state.canViewDoneTasks) ...[
              for (var i = 0; i < doneTask.length; i++) doneTask[i],
            ],
          ],
        );
      },
    );
  }
}

class TimerFloatingButton extends StatelessWidget {
  const TimerFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: timerCubit,
      child: Positioned(
          // Botón fijo en la parte inferior
          bottom: 70,
          child: GestureDetector(
            onTap: () => {
              Navigator.pushNamed(context, '/timer',
                  arguments: ArgumentTimerPage(task: timerCubit.task))
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.only(bottom: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: const LinearGradient(
                        colors: [Color(0xffff6336), Color(0xfffb4474)],
                        stops: [0, 1],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: BlocBuilder<TimerCubit, TimerState>(
                      builder: (context, state) {
                        int minutes = (state.seconds / 60).floor();
                        return Text(
                          "$minutes",
                          style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 35),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class InputTitleTask extends StatelessWidget {
  const InputTitleTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return TextFormField(
      controller: createTaskCubit.textEditingController,
      cursorColor: AppColors.primaryColor,
      onTap: () {
        createTaskCubit.changeKeyboardState(true);
      },
      focusNode: focusNode
        ..addListener(() {
          createTaskCubit.changeKeyboardState(focusNode.hasFocus);
        }),
      decoration: const InputDecoration(
          fillColor: AppColors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          labelText: null,
          prefixIcon: Icon(
            Icons.add,
            color: AppColors.gray,
          ),
          hintText: 'Agregar una tarea...',
          contentPadding: EdgeInsets.symmetric(vertical: 8.0)),
    );
  }
}

class StatisticGroup extends StatelessWidget {
  const StatisticGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<ListTaskCubit, ListTaskState>(
        builder: (context, state) {
          int amountCompletedTask = 0;
          int amountIncompletedTask = 0;
          int totalStimatedMinutes = 0;
          state.tasks.forEach((element) {
            element.isDone ? amountCompletedTask++ : amountIncompletedTask++;
            totalStimatedMinutes += element.pomodoros * 30;
          });

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatisticTime(
                  totalMinutes: totalStimatedMinutes, title: "Tiempo estimado"),
              StatisticCounter(
                  amount: amountCompletedTask, title: "Tareas completadas"),
              StatisticTime(
                  totalMinutes: totalStimatedMinutes,
                  title: "Tiempo de enfoque"),
              StatisticCounter(
                  amount: amountIncompletedTask, title: "Tareas a completar"),
            ],
          );
        },
      ),
    );
  }
}

class StatisticCounter extends StatelessWidget {
  const StatisticCounter({
    Key? key,
    required this.amount,
    required this.title,
  }) : super(key: key);

  final int amount;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 14),
          Text("$amount",
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColors.gray)),
        ],
      ),
    );
  }
}

class StatisticTime extends StatelessWidget {
  const StatisticTime({
    Key? key,
    required this.totalMinutes,
    required this.title,
  }) : super(key: key);

  final int totalMinutes;
  final String title;

  @override
  Widget build(BuildContext context) {
    //calculate hour and rest minutes
    int hours = (totalMinutes / 60).floor();
    int minutes = totalMinutes % 60;
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("HH      MM",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColors.gray)),
          Text(
              "${hours > 10 ? hours : "0$hours"}:${minutes > 10 ? minutes : "0$minutes"}",
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColors.gray)),
        ],
      ),
    );
  }
}

class ExtraFormTask extends StatelessWidget {
  const ExtraFormTask({
    this.initialProyect = null,
    this.initialTime = TaskTime.today,
    Key? key,
  }) : super(key: key);
  final TaskTime? initialTime;
  final Project? initialProyect;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: createTaskCubit..init(project: initialProyect, time: initialTime),
      child: Container(
        color: AppColors.white,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Número estimado de pomodoros",
              style: TextStyle(color: AppColors.gray, fontSize: 12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int i = 1; i <= state.pomodoros; i++)
                              GestureDetector(
                                onTap: () =>
                                    createTaskCubit.selectCuantityPomodoros(i),
                                child: const Icon(Icons.timer,
                                    size: 35, color: AppColors.primaryColor),
                              ),
                            for (int i = 1; i <= 5 - state.pomodoros; i++)
                              GestureDetector(
                                onTap: () =>
                                    createTaskCubit.selectCuantityPomodoros(
                                        i + state.pomodoros),
                                child: const Icon(Icons.timer,
                                    size: 35, color: AppColors.grayLight),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded,
                    size: 24, color: AppColors.grayLight)
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          TaskTime time = await showSelectTimeDialog(context);
                          createTaskCubit.selectTime(time);
                        },
                        child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                            builder: (context, state) {
                          return Icon(timeIcons[state.time],
                              color: timeColors[state.time], size: 30);
                        }),
                      ),
                      const SizedBox(width: 18),
                      GestureDetector(onTap: () async {
                        TaskPriority priority =
                            await showSelectPriorityDialog(context);
                        createTaskCubit.selectPriority(priority);
                      }, child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                        builder: (context, state) {
                          return Icon(Icons.flag,
                              color: priorityColors[state.priority], size: 30);
                        },
                      )),
                      const SizedBox(width: 18),
                      const Icon(Icons.local_atm_outlined,
                          color: AppColors.gray, size: 30),
                      const SizedBox(width: 24),
                      GestureDetector(onTap: () async {
                        Project project =
                            await showSelectProyectToCreate(context);
                        createTaskCubit.selectProject(project);
                      }, child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                          builder: (context, state) {
                        if (state.project == null) {
                          return Row(
                            children: const [
                              Icon(Icons.mail,
                                  color: AppColors.blueLightIcon, size: 30),
                              SizedBox(width: 8),
                              Text(
                                "Tareas",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              )
                            ],
                          );
                        }
                        return Row(
                          children: [
                            Icon(Icons.circle,
                                color: Color(state.project!.color), size: 20),
                            SizedBox(width: 8),
                            Text(
                              state.project!.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            )
                          ],
                        );
                      }))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    createTaskCubit.submit();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Text(
                      "Listo",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                )
              ],
            )
          ],
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
    return Slidable(
      key: ValueKey(0),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.4,
        children: [
          GestureDetector(
            onTap: () async {
              TaskTime time = await showSelectTimeDialog(context);
              listTaskCubit.editTask(id, time: time);
            },
            child: Icon(timeIcons[TaskTime.today],
                color: timeColors[TaskTime.today], size: 30),
          ),
          GestureDetector(
            onTap: () async {
              TaskPriority priority = await showSelectPriorityDialog(context);
              listTaskCubit.editTask(id, priority: priority);
            },
            child: Icon(Icons.flag, color: priorityColors[TaskPriority.none]),
          ),
          GestureDetector(
            onTap: () => {
              listTaskCubit.deleteTask(id),
            },
            child: Icon(Icons.delete, color: AppColors.black, size: 20),
          )
        ],
      ),
      child: GestureDetector(
        onTap: () => {
          Navigator.pushNamed(context, '/task',
              arguments: ArgumentTaskPage(
                task: task,
              ))
        },
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.backgroundColor, // Border color
                  width: 3.0, // Border width
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          listTaskCubit.editTask(id, isDone: !isDone);
                        },
                        child: TaskCheckBox(priority: priority)),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: TextStyle(
                              color:
                                  isDone ? AppColors.grayLight : AppColors.gray,
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
                if (!isActive)
                  InkWell(
                    onTap: () => {
                      Navigator.pushNamed(context, '/timer',
                          arguments: ArgumentTimerPage(
                            task: task,
                          ))
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: AppColors.primaryColor,
                        size: 20,
                      ),
                    ),
                  )
                else
                  const Icon(Icons.timelapse_rounded,
                      color: AppColors.primaryColor, size: 26)
              ],
            )),
      ),
    );
  }
}

class TitleDivision extends StatelessWidget {
  final String title;
  final int minutes;
  const TitleDivision({
    Key? key,
    this.title = "",
    this.minutes = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Text("$title ° ${minutes}min",
          style: const TextStyle(
              color: AppColors.gray,
              fontSize: 14,
              fontWeight: FontWeight.w600)),
    );
  }
}
