import 'dart:ui';
import 'package:focus_to_do/logic/list_proyect/list_proyect_cubit.dart';
import 'package:uuid/uuid.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:focus_to_do/data/dataproviders/proyects_preference.dart';
import 'package:focus_to_do/data/models/project.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';
import 'package:meta/meta.dart';

part 'edit_proyect_state.dart';

class EditProjectCubit extends Cubit<EditProjectState> {
  static const uuid = Uuid();

  EditProjectCubit()
      : super(EditProjectState(
          name: "",
          indexColor: 0,
          isNameValid: false,
          isColorValid: false,
          isSubmitting: false,
          id: "",
        ));
  void init(String name, int color, String id) {
    print(color);
    for (int i = 0; i < AppColors.colorPicker.length; i++) {
      if (AppColors.colorPicker[i].value == color) {
        emit(state.copyWith(
          name: name,
          indexColor: i,
          isNameValid: name.isNotEmpty,
          isColorValid: true,
          id: id,
        ));
        return;
      }
    }
    // int indexColor = AppColors.colorPicker.indexOf(Color(color));
    int indexColor = 1;
    emit(state.copyWith(
        name: name,
        indexColor: indexColor,
        isNameValid: name.isNotEmpty,
        isColorValid: true,
        id: id));
  }

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

    Project proyect =
        Project(name: state.name, color: color.value, id: state.id);

    ProjectPreference.editProyect(proyect).then((value) {
      listProyectCubit.getProyects();
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

final EditProjectCubit editProyectCubit = EditProjectCubit();
