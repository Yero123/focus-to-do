part of 'list_proyect_cubit.dart';

class ListProyectState {
  final List<Project> proyects;
  final bool isSubmitting;
  ListProyectState({
    required this.proyects,
    required this.isSubmitting,
  });
  //copyWith
  ListProyectState copyWith({
    List<Project>? proyects,
    bool? isSubmitting,
  }) {
    return ListProyectState(
      proyects: proyects ?? this.proyects,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
