import 'package:focus_to_do/data/models/project.dart';
import 'package:focus_to_do/data/models/task.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';

class ArgumentEditProyectPage {
  final String id;
  final String name;
  final int color;
  ArgumentEditProyectPage(
      {required this.id, required this.name, required this.color});
}

class ArgumentTaskPage {
  final Task task;

  ArgumentTaskPage({required this.task});
}

class ArgumentTaskListPage {
  final String? projectId;
  final TaskTime? time;
  final String title;
  final Project? project;
  ArgumentTaskListPage({ required this.title, this.projectId, this.time, this.project});
}


class ArgumentTimerPage {
  final Task task;

  ArgumentTimerPage({required this.task});
}

