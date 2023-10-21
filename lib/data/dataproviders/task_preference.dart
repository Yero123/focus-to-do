import 'dart:convert';

import 'package:focus_to_do/data/models/task.dart';
import 'package:focus_to_do/logic/list_task/list_task_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskPreference {
  static const String key = 'task_preference';
  static Future<List<Task>> getTasks({FiltersListTask? filters}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> tasks = prefs.getStringList(key) ?? [];
    List<Task> tasksList = [];
    if (filters != null) {
      tasksList = tasks
          .map((String task) => Task.fromJson(json.decode(task)))
          .where((element) {
        if (filters.projectId != null) {
          return element.projectId == filters.projectId;
        } else {
          return true;
        }
      }).where((element) {
        if (filters.time != null) {
          return element.time == filters.time;
        } else {
          return true;
        }
      }).toList();
    } else {
      tasksList =
          tasks.map((String task) => Task.fromJson(json.decode(task))).toList();
    }
    return tasksList;
  }

  static Future<bool> saveTasks(List<Task> tasks) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> tasksString =
        tasks.map((Task task) => json.encode(task.toJson())).toList();
    return prefs.setStringList(key, tasksString);
  }

  static Future<bool> saveTask(Task task) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> tasks = prefs.getStringList(key) ?? [];
    tasks.add(json.encode(task.toJson()));
    return prefs.setStringList(key, tasks);
  }

  static Future<bool> deleteTask(Task task) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> tasks = prefs.getStringList(key) ?? [];
    tasks.remove(json.encode(task.toJson()));
    return prefs.setStringList(key, tasks);
  }

  static Future<bool> deleteTaskById(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> tasks = prefs.getStringList(key) ?? [];
    tasks.removeWhere((element) => json.decode(element)['id'] == id);
    return prefs.setStringList(key, tasks);
  }

  static Future<bool> deleteAllTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> tasksString = [];
    return prefs.setStringList(key, tasksString);
  }

  // edit task
  static Future<bool> editTask(Task task) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> tasks = prefs.getStringList(key) ?? [];
    var pastTask = tasks.firstWhere((element) {
      return Task.fromJson(json.decode(element)).id == task.id;
    });
    tasks.remove(pastTask);
    tasks.add(json.encode(task.toJson()));
    return prefs.setStringList(key, tasks);
  }
}
