import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_to_do/data/models/project.dart';
import 'package:focus_to_do/logic/create_task/create_task_cubit.dart';
import 'package:focus_to_do/logic/edit_task/edit_task_cubit.dart';
import 'package:focus_to_do/logic/list_proyect/list_proyect_cubit.dart';
import 'package:focus_to_do/presentation/pages/home.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';

Future<TaskPriority> showSelectPriorityDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              15.0), // Ajusta el radio según tus preferencias
        ),
        content: SizedBox(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.8,
          child: GridView.count(
            crossAxisCount: 2, // 2 columnas en el grid
            crossAxisSpacing: 16.0, // Espaciado horizontal
            mainAxisSpacing: 16.0, // Espaciado vertical
            padding: const EdgeInsets.all(16.0), // Espaciado exterior
            children: const <Widget>[
              PriorityIcon(
                  color: AppColors.primaryColor,
                  name: 'Prioridad Alta',
                  value: TaskPriority.high),
              PriorityIcon(
                  color: AppColors.mediumPriorityColor,
                  name: 'Prioridad Media',
                  value: TaskPriority.medium),
              PriorityIcon(
                  color: AppColors.lowPriorityColor,
                  name: 'Prioridad Baja',
                  value: TaskPriority.low),
              PriorityIcon(
                  color: AppColors.gray,
                  name: 'Sin prioridad',
                  value: TaskPriority.none),
            ],
          ),
        ),
      );
    },
  );
}

Future<Project> showSelectProyectToCreate(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        title: const Center(
            child: Text(
          'Selecciona un proyecto',
          style: TextStyle(fontWeight: FontWeight.w600),
        )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              15.0), // Ajusta el radio según tus preferencias
        ),
        content: MultiBlocProvider(
          providers: [
            BlocProvider<ListProyectCubit>.value(value: listProyectCubit),
            BlocProvider<CreateTaskCubit>.value(value: createTaskCubit),
          ],
          child: SizedBox(
              height: 450,
              width: MediaQuery.of(context).size.width * 0.8,
              child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                  builder: (context, stateCreateTask) {
                return BlocBuilder<ListProyectCubit, ListProyectState>(
                  builder: (context, state) {
                    if (state.isSubmitting) {
                      return const SizedBox();
                    }
                    return Column(
                      children: [
                        SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            createTaskCubit.deselectProject();
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: stateCreateTask.project == null
                                ? BoxDecoration(
                                    color: AppColors.secondaryColor,
                                  )
                                : null,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // SizedBox(width: 20),
                                Icon(Icons.indeterminate_check_box,
                                    color: AppColors.blueLightIcon, size: 20),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    "Tareas",
                                    style: const TextStyle(
                                        color: AppColors.gray,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                stateCreateTask.project == null
                                    ? const Icon(Icons.check,
                                        color: AppColors.primaryColor)
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        for (var i = 0; i < state.proyects.length; i++)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(state.proyects[i]);
                            },
                            child: Container(
                              decoration: stateCreateTask.project?.id ==
                                      state.proyects[i].id
                                  ? BoxDecoration(
                                      color: AppColors.secondaryColor,
                                    )
                                  : null,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // SizedBox(width: 20),
                                  Icon(Icons.circle,
                                      color: Color(state.proyects[i].color),
                                      size: 20),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      state.proyects[i].name,
                                      style: const TextStyle(
                                          color: AppColors.gray,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  stateCreateTask.project?.id ==
                                          state.proyects[i].id
                                      ? const Icon(Icons.check,
                                          color: AppColors.primaryColor)
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          )
                      ],
                    );
                  },
                );
              })),
        ),
      );
    },
  );
}

Future<Project> showSelectProyectToEdit(
    BuildContext context, EditTaskCubit editTaskCubit) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        title: const Center(
            child: Text(
          'Selecciona un proyecto',
          style: TextStyle(fontWeight: FontWeight.w600),
        )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              15.0), // Ajusta el radio según tus preferencias
        ),
        content: MultiBlocProvider(
          providers: [
            BlocProvider<ListProyectCubit>.value(value: listProyectCubit),
            BlocProvider<EditTaskCubit>.value(value: editTaskCubit),
          ],
          child: SizedBox(
              height: 450,
              width: MediaQuery.of(context).size.width * 0.8,
              child: BlocBuilder<EditTaskCubit, EditTaskState>(
                  builder: (context, stateEditTask) {
                return BlocBuilder<ListProyectCubit, ListProyectState>(
                  builder: (context, state) {
                    if (state.isSubmitting) {
                      return const SizedBox();
                    }
                    return Column(
                      children: [
                        SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            createTaskCubit.deselectProject();
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: stateEditTask.project == null
                                ? BoxDecoration(
                                    color: AppColors.secondaryColor,
                                  )
                                : null,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // SizedBox(width: 20),
                                Icon(Icons.indeterminate_check_box,
                                    color: AppColors.blueLightIcon, size: 20),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    "Tareas",
                                    style: const TextStyle(
                                        color: AppColors.gray,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                stateEditTask.project == null
                                    ? const Icon(Icons.check,
                                        color: AppColors.primaryColor)
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        for (var i = 0; i < state.proyects.length; i++)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(state.proyects[i]);
                            },
                            child: Container(
                              decoration: stateEditTask.project?.id ==
                                      state.proyects[i].id
                                  ? BoxDecoration(
                                      color: AppColors.secondaryColor,
                                    )
                                  : null,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // SizedBox(width: 20),
                                  Icon(Icons.circle,
                                      color: Color(state.proyects[i].color),
                                      size: 20),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      state.proyects[i].name,
                                      style: const TextStyle(
                                          color: AppColors.gray,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  stateEditTask.project?.id ==
                                          state.proyects[i].id
                                      ? const Icon(Icons.check,
                                          color: AppColors.primaryColor)
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          )
                      ],
                    );
                  },
                );
              })),
        ),
      );
    },
  );
}

Future<TaskTime> showSelectTimeDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              15.0), // Ajusta el radio según tus preferencias
        ),
        content: SizedBox(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.8,
          child: GridView.count(
            crossAxisCount: 2, // 2 columnas en el grid
            crossAxisSpacing: 16.0, // Espaciado horizontal
            mainAxisSpacing: 16.0, // Espaciado vertical
            padding: const EdgeInsets.all(16.0), // Espaciado exterior
            children: const <Widget>[
              TimeIcon(
                  color: AppColors.greenIcon,
                  name: 'Hoy',
                  value: TaskTime.today,
                  icon: Icons.sunny),
              TimeIcon(
                  color: AppColors.orangeIcon,
                  name: 'Mañana',
                  value: TaskTime.tomorrow,
                  icon: Icons.offline_bolt),
              TimeIcon(
                  color: AppColors.blueLightIcon,
                  name: 'En 7 días',
                  value: TaskTime.sevenDays,
                  icon: Icons.calendar_today),
              TimeIcon(
                  color: AppColors.purpleIcon,
                  name: 'Algun día',
                  value: TaskTime.someday,
                  icon: Icons.calendar_month),
            ],
          ),
        ),
      );
    },
  );
}

class TimeIcon extends StatelessWidget {
  final Color color;
  final TaskTime value;
  final String name;
  final IconData icon;
  const TimeIcon({
    Key? key,
    required this.color,
    required this.value,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.of(context).pop(value);
      }),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(color: AppColors.gray, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class PriorityIcon extends StatelessWidget {
  final Color color;
  final TaskPriority value;
  final String name;

  const PriorityIcon(
      {Key? key, required this.color, required this.value, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.of(context).pop(value);
      }),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Center(
              child: Icon(
                Icons.flag,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(color: AppColors.gray, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

Future<bool> showComfirmDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              15.0), // Ajusta el radio según tus preferencias
        ),
        content: SizedBox(
            height: 120,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "¿ Estas seguro que quieres eliminar esta tarea ?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(color: AppColors.gray, fontSize: 20),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        "Eliminar",
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 20),
                      ),
                    ),
                  ],
                )
              ],
            )),
      );
    },
  );
}
