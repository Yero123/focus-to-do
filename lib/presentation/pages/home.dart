import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focus_to_do/data/models/project.dart';
import 'package:focus_to_do/logic/list_proyect/list_proyect_cubit.dart';
import 'package:focus_to_do/presentation/utils/arguments_page.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: listProyectCubit..getProyects(),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          margin: const EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(width: 2, color: AppColors.gray),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.canva.com%2Fes_mx%2Ftwitch%2Fplantillas%2Ffotos-perfil-twitch%2F&psig=AOvVaw3HyskvHdw2ua2Y01Z4kZDG&ust=1695859137834000&source=images&cd=vfe&opi=89978449&ved=0CA4QjRxqFwoTCPDQz-C9yYEDFQAAAAAdAAAAABAI"),
                                  fit: BoxFit.cover)),
                        ),
                        const Text(
                          "YerodinCS",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        )
                      ],
                    ),
                    const Icon(Icons.area_chart, color: AppColors.gray)
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  children: [
                    GroupItemTile(
                      title: "Hoy",
                      icon: Icon(Icons.sunny,
                          color: AppColors.greenIcon, size: 20),
                      minutes: 0,
                      tasks: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/task_list',
                            arguments: ArgumentTaskListPage(
                                time: TaskTime.today, title: "Hoy"));
                      },
                    ),
                    GroupItemTile(
                      title: "Mañana",
                      icon: Icon(Icons.offline_bolt,
                          color: AppColors.orangeIcon, size: 20),
                      minutes: 0,
                      tasks: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/task_list',
                            arguments: ArgumentTaskListPage(
                                time: TaskTime.tomorrow, title: "Mañana"));
                      },
                    ),
                    GroupItemTile(
                      title: "Algún día",
                      icon: Icon(Icons.calendar_month,
                          color: AppColors.purpleIcon, size: 20),
                      minutes: 0,
                      tasks: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/task_list',
                            arguments: ArgumentTaskListPage(
                                time: TaskTime.someday, title: "Algún día"));
                      },
                    ),
                    GroupItemTile(
                        title: "En 7 días",
                        icon: Icon(Icons.calendar_today,
                            color: AppColors.blueLightIcon, size: 20),
                        minutes: 0,
                        tasks: 0,
                        onTap: () {
                          Navigator.pushNamed(context, '/task_list',
                              arguments: ArgumentTaskListPage(
                                  time: TaskTime.sevenDays,
                                  title: "En 7 días"));
                        },
                        hideMinutesAndTasks: true),
                    GroupItemTile(
                      title: "Completado",
                      icon: Icon(Icons.check_circle,
                          color: AppColors.gray, size: 20),
                      minutes: 0,
                      tasks: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/task_list',
                            arguments: ArgumentTaskListPage(
                                time: TaskTime.today, title: "Completado"));
                      },
                      hideMinutesAndTasks: true,
                    ),
                    GroupItemTile(
                      title: "Tareas",
                      icon: Icon(Icons.mail,
                          color: AppColors.blueLightIcon, size: 20),
                      minutes: 0,
                      tasks: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/task_list',
                            arguments: ArgumentTaskListPage(title: "Tareas"));
                      },
                    ),
                    BlocBuilder<ListProyectCubit, ListProyectState>(
                      builder: (context, state) {
                        if (state.isSubmitting) {
                          return SizedBox();
                        }
                        return Column(
                          children: [
                            for (var i = 0; i < state.proyects.length; i++)
                              ProyectItemTile(
                                title: state.proyects[i].name,
                                color: Color(state.proyects[i].color),
                                id: state.proyects[i].id,
                                minutes: 0,
                                tasks: 0,
                                project: state.proyects[i],
                              ),
                          ],
                        );
                      },
                    ),
                    InkWell(
                      onTap: () => {},
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (() => {
                                    Navigator.pushNamed(context, '/new_proyect')
                                  }),
                              child: Row(
                                children: [
                                  Icon(Icons.add,
                                      color: AppColors.primaryColor, size: 25),
                                  SizedBox(width: 10),
                                  Text(
                                    "Nuevo Proyecto",
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.add_alarm_sharp,
                                  color: AppColors.primaryColor,
                                  size: 26,
                                ),
                                SizedBox(width: 25),
                                Icon(
                                  Icons.add_alarm_sharp,
                                  color: AppColors.primaryColor,
                                  size: 26,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GroupItemTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final int minutes;
  final int tasks;
  final Color? color;
  final bool hideMinutesAndTasks;
  final String? id;
  final Function() onTap;
  const GroupItemTile({
    Key? key,
    this.title = "Group",
    this.icon = const Icon(Icons.sunny, color: AppColors.greenIcon, size: 20),
    this.minutes = 0,
    this.tasks = 0,
    this.color,
    this.hideMinutesAndTasks = false,
    this.id,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => {
                // Navigator.pushNamed(context, '/edit_proyect',
                //     arguments: ArgumentEditProyectPage(
                //       id: id,
                //       name: title,
                //       color: color?.value,
                //     ))
              },
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Editar',
            ),
            SlidableAction(
              onPressed: (context) => {listProyectCubit.deleteOneProyect(id!)},
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      width: 25,
                      alignment: Alignment.center,
                      child: color != null
                          ? Container(
                              width: 13,
                              height: 13,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: color),
                            )
                          : icon),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18),
                  )
                ],
              ),
              !hideMinutesAndTasks
                  ? Row(
                      children: [
                        Text(
                          '$minutes m',
                          style: const TextStyle(
                              color: AppColors.gray,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "$tasks",
                          style: const TextStyle(
                              color: AppColors.gray,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class ProyectItemTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final int minutes;
  final int tasks;
  final Color color;
  final bool hideMinutesAndTasks;
  final String id;
  final Project project;
  const ProyectItemTile({
    Key? key,
    this.title = "Group",
    this.icon = const Icon(Icons.sunny, color: AppColors.greenIcon, size: 20),
    this.minutes = 0,
    this.tasks = 0,
    this.color = AppColors.greenIcon,
    this.hideMinutesAndTasks = false,
    required this.project,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.pushNamed(context, '/task_list',
            arguments: ArgumentTaskListPage(
                projectId: project.id, title: project.name, project: project))
      },
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => {
                Navigator.pushNamed(context, '/edit_proyect',
                    arguments: ArgumentEditProyectPage(
                      id: id,
                      name: title,
                      color: color.value,
                    ))
              },
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Editar',
            ),
            SlidableAction(
              onPressed: (context) => {listProyectCubit.deleteOneProyect(id)},
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      width: 25,
                      alignment: Alignment.center,
                      child: color != null
                          ? Container(
                              width: 13,
                              height: 13,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: color),
                            )
                          : icon),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18),
                  )
                ],
              ),
              !hideMinutesAndTasks
                  ? Row(
                      children: [
                        Text(
                          '$minutes m',
                          style: const TextStyle(
                              color: AppColors.gray,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "$tasks",
                          style: const TextStyle(
                              color: AppColors.gray,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
