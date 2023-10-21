part of 'edit_proyect_cubit.dart';

class EditProjectState {
  final String name;
  final int indexColor;
  final bool isNameValid;
  final bool isColorValid;
  final bool isSubmitting;
  final String id;
  EditProjectState({
    required this.name,
    required this.indexColor,
    required this.isNameValid,
    required this.isColorValid,
    required this.isSubmitting,
    required this.id,
  });
  //copyWith
  EditProjectState copyWith({
    String? name,
    int? indexColor,
    bool? isNameValid,
    bool? isColorValid,
    bool? isSubmitting,
    String? id,
  }) {
    return EditProjectState(
      name: name ?? this.name,
      indexColor: indexColor ?? this.indexColor,
      isNameValid: isNameValid ?? this.isNameValid,
      isColorValid: isColorValid ?? this.isColorValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      id: id ?? this.id,
    );
  }
}
