import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_to_do/data/models/project.dart';
import 'package:focus_to_do/logic/edit_task/edit_task_cubit.dart';
import 'package:focus_to_do/presentation/common/task_check_box.dart';
import 'package:focus_to_do/presentation/utils/alerts_dialogs.dart';
import 'package:focus_to_do/presentation/utils/arguments_page.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  //LONG TIME: Ver proyect tareas
  //LONG TIME: Change pomodoros
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ArgumentTaskPage;
    EditTaskCubit editTaskCubit = EditTaskCubit(task: arguments.task);
    return BlocProvider(
      create: (context) => editTaskCubit..init(),
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
                onTap: () async {
                  bool delete = await showComfirmDialog(context);
                  if (delete) {
                    await editTaskCubit.deleteTask();
                    Navigator.pop(context);
                  }
                },
                child: const Icon(Icons.delete, color: AppColors.gray)),
            const SizedBox(width: 25),
          ],
          title: BlocBuilder<EditTaskCubit, EditTaskState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () async {
                  Project project =
                      await showSelectProyectToEdit(context, editTaskCubit);
                  editTaskCubit.changeProperties(project: project);
                },
                child: Row(
                  children: [
                    Text(state.project != null ? state.project!.name : "Tareas",
                        style: AppTextStyles.primaryColor),
                    const SizedBox(width: 5),
                    const Icon(Icons.arrow_drop_down, color: AppColors.gray),
                  ],
                ),
              );
            },
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 25),
            Container(
                height: 120,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          GestureDetector(onTap: () {
                            editTaskCubit.changeProperties(
                                isDone: !editTaskCubit.state.task.isDone);
                            Navigator.pop(context);
                          }, child: BlocBuilder<EditTaskCubit, EditTaskState>(
                            builder: (context, state) {
                              return TaskCheckBox(
                                  priority: state.task.priority);
                            },
                          )),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 200,
                            child: BlocBuilder<EditTaskCubit, EditTaskState>(
                              builder: (context, state) {
                                return TextFormField(
                                  // controller:
                                  //     editTaskCubit.nameEditingController,
                                  initialValue: arguments.task.title,
                                  cursorColor: AppColors.primaryColor,
                                  onChanged: (value) => {
                                    editTaskCubit.changeProperties(title: value)
                                  },
                                  decoration: const InputDecoration(
                                      fillColor: AppColors.white,
                                      filled: true,
                                      labelText: null,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide
                                            .none, // Establece el borde inferior a none
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 8.0)),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        TaskPriority priority =
                            await showSelectPriorityDialog(context);
                        editTaskCubit.changeProperties(priority: priority);
                        // listTaskCubit.editTask(id, priority: priority);
                      },
                      child: BlocBuilder<EditTaskCubit, EditTaskState>(
                        builder: (context, state) {
                          return Icon(Icons.flag,
                              color: priorityColors[state.task.priority]);
                        },
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 25),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                ),
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       child: Row(
                    //         children: [
                    //           Icon(Icons.timer,
                    //               color: AppColors.gray, size: 28),
                    //           SizedBox(width: 15),
                    //           Text(
                    //             "Pomodoro",
                    //             style: TextStyle(fontSize: 20),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     GestureDetector(
                    //         onTap: () async {
                    //           // TaskPriority priority =
                    //           //     await showSelectPriorityDialog(context);
                    //           // listTaskCubit.editTask(id, priority: priority);
                    //         },
                    //         child: Column(
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 const Padding(
                    //                   padding: EdgeInsets.only(right: 3),
                    //                   child: Icon(
                    //                     Icons.timer,
                    //                     color: AppColors.primaryColor,
                    //                     size: 14,
                    //                   ),
                    //                 ),
                    //                 const Padding(
                    //                   padding: EdgeInsets.only(right: 3),
                    //                   child: Icon(
                    //                     Icons.timer,
                    //                     color: AppColors.primaryColor,
                    //                     size: 14,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             const SizedBox(height: 3),
                    //             Row(
                    //               children: [
                    //                 const Padding(
                    //                   padding: EdgeInsets.only(right: 3),
                    //                   child: Icon(
                    //                     Icons.timer,
                    //                     color: AppColors.primaryColor,
                    //                     size: 14,
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   "= 25 min",
                    //                   style: TextStyle(fontSize: 14),
                    //                 )
                    //               ],
                    //             )
                    //           ],
                    //         )),
                    //   ],
                    // ),
                    // SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month,
                                  color: AppColors.gray, size: 28),
                              SizedBox(width: 15),
                              Text(
                                "Fecha de vencimiento",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(onTap: () async {
                          TaskTime time = await showSelectTimeDialog(context);
                          editTaskCubit.changeProperties(time: time);
                        }, child: BlocBuilder<EditTaskCubit, EditTaskState>(
                          builder: (context, state) {
                            String name = "Hoy";
                            return Row(
                              children: [
                                Text(
                                  timeNames[state.task.time],
                                  style: TextStyle(fontSize: 18),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    timeIcons[state.task.time],
                                    color: timeColors[state.task.time],
                                    size: 24,
                                  ),
                                ),
                              ],
                            );
                          },
                        )),
                      ],
                    ),
                  ],
                )),
            SizedBox(height: 30),
            Container(
                height: 120,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                ),
                child: TextFormField(
                  // controller: _textController,
                  maxLines:
                      null, // Establece maxLines en null para permitir varias líneas
                  initialValue: arguments.task.description,
                  cursorColor: AppColors.primaryColor,
                  onChanged: (value) =>
                      {editTaskCubit.changeProperties(description: value)},
                  decoration: const InputDecoration(
                      hintText: 'Agregar una nota...',
                      fillColor: AppColors.white,
                      filled: true,
                      labelText: null,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide
                            .none, // Establece el borde inferior a none
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0)),
                )),
          ],
        ),
      ),
    );
  }
}
