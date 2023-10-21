import 'dart:convert';

import 'package:focus_to_do/data/models/project.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectPreference {
  static const String _proyects = 'proyects';

  static Future<List<Project>> getProyects() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> proyects = prefs.getStringList(_proyects) ?? [];
    return proyects
        .map((String proyect) => Project.fromJson(json.decode(proyect)))
        .toList();
  }

  static Future<Project> getProject(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> proyects = prefs.getStringList(_proyects) ?? [];
    return proyects
        .map((String proyect) => Project.fromJson(json.decode(proyect)))
        .firstWhere((element) => element.id == id);
  }

  static Future<bool> saveProyects(List<Project> proyects) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> proyectsString = proyects
        .map((Project proyect) => json.encode(proyect.toJson()))
        .toList();
    return prefs.setStringList(_proyects, proyectsString);
  }

  //saveProyect
  static Future<bool> saveProyect(Project proyect) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> proyects = prefs.getStringList(_proyects) ?? [];
    proyects.add(json.encode(proyect.toJson()));
    return prefs.setStringList(_proyects, proyects);
  }

  //deleteProyect
  static Future<bool> deleteProyect(Project proyect) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> proyects = prefs.getStringList(_proyects) ?? [];
    proyects.remove(json.encode(proyect.toJson()));
    return prefs.setStringList(_proyects, proyects);
  }

  static Future<bool> deleteAllProyects() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> proyectsString = [];
    return prefs.setStringList(_proyects, proyectsString);
  }

  // editProyect
  static Future<bool> editProyect(Project proyect) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> proyects = prefs.getStringList(_proyects) ?? [];
    var pastProyect = proyects.firstWhere((element) {
      return Project.fromJson(json.decode(element)).id == proyect.id;
    }, orElse: () => '');
    var index = proyects.indexOf(pastProyect);
    proyects.removeWhere((element) => json.decode(element)['id'] == proyect.id);
    proyects.insert(index, json.encode(proyect.toJson()));
    return prefs.setStringList(_proyects, proyects);
  }
}
