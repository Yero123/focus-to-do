import 'package:bloc/bloc.dart';
import 'package:focus_to_do/data/dataproviders/proyects_preference.dart';
import 'package:focus_to_do/data/models/project.dart';
import 'package:meta/meta.dart';

part 'list_proyect_state.dart';

class ListProyectCubit extends Cubit<ListProyectState> {
  ListProyectCubit()
      : super(ListProyectState(
          proyects: [],
          isSubmitting: false,
        ));

  getProyects() async {
    emit(state.copyWith(
      isSubmitting: true,
    ));
    List<Project> proyects = await ProjectPreference.getProyects();
    emit(state.copyWith(
      proyects: proyects,
      isSubmitting: false,
    ));
  }

  deleteAllProyects() async {
    emit(state.copyWith(
      isSubmitting: true,
    ));
    List<Project> proyects = await ProjectPreference.getProyects();
    ProjectPreference.deleteAllProyects().then((value) {
      emit(state.copyWith(
        proyects: [],
        isSubmitting: false,
      ));
    });
  }

  deleteOneProyect(String id) async {
    emit(state.copyWith(
      isSubmitting: true,
    ));
    List<Project> proyects = await ProjectPreference.getProyects();
    proyects.removeWhere((element) => element.id == id);
    Project project = await ProjectPreference.getProject(id);
    ProjectPreference.deleteProyect(project).then((value) {
      var newProyects = state.proyects;
      newProyects.removeWhere((element) => element.id == id);
      emit(state.copyWith(
        proyects: newProyects,
        isSubmitting: false,
      ));
    });
  }
}

ListProyectCubit listProyectCubit = ListProyectCubit();
