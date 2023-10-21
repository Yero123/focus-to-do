import 'dart:ui';
import 'package:uuid/uuid.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:focus_to_do/data/dataproviders/proyects_preference.dart';
import 'package:focus_to_do/data/models/project.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';
import 'package:meta/meta.dart';

part 'create_proyect_state.dart';

class CreateProjectCubit extends Cubit<CreateProjectState> {
  static const uuid = Uuid();
  CreateProjectCubit()
      : super(CreateProjectState(
          name: "",
          indexColor: 0,
          isNameValid: false,
          isColorValid: false,
          isSubmitting: false,
        ));
  void changeName(String name) {
    emit(state.copyWith(
      name: name,
      isNameValid: name.isNotEmpty,
    ));
  }

  void changeColor(int indexColor) {
    emit(state.copyWith(
      indexColor: indexColor,
      isColorValid: true,
    ));
  }

  void submit() async {
    emit(state.copyWith(
      isSubmitting: true,
    ));
    Color color = AppColors.colorPicker[state.indexColor];
    print(color.value);

    String id = uuid.v4();
    Project proyect = Project(name: state.name, color: color.value, id: id);

    ProjectPreference.saveProyect(proyect).then((value) {
      emit(state.copyWith(
        isSubmitting: false,
      ));
    });
  }

  // void printfa() async {
  //   List<Project> proyects = await ProyectPreference.getProyects();
  //   print(proyects[0].color);
  // }
}

final CreateProjectCubit createProyectCubit = CreateProjectCubit();
